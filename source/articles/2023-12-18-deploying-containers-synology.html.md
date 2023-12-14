---
title: "Synology on Rails Part II: Deploying"
date: 2023-12-18 20:34 UTC
tags:
- web development
- ruby
- rails
- software engineering
- deployment
keywords:
- web development
- ruby
- rails
- software engineering
- deployment
- docker
- containers
- synology
- nas
series: rails-docker-nas
teaser: "Digging deep in the terminal and figuring out how to use rake to deploy my containerized Rails app to my Synology NAS."
---

[series]: /series/rails-docker-nas
[partI]: /rails-containers-on-synology/
[gist]: https://gist.github.com/infews/4852e0c15795e5bbee4653d5a0f1deee
[sshkit]: https://github.com/capistrano/sshkit
[sshkit-sudo]: https://github.com/kentaroi/sshkit-sudo

_This is part II. Visit [rest of this series][series] to find out how we got here._

Now that I had a _very_ [manual set of steps][partI] to get my Meal Planning app to run on Synology DSM, I wanted a more automated set of deployment steps - something I could deploy with a single rake task.

## What I Wanted

- No DockerHub round tripping
    - Why send 1GB up to the cloud just to come back down again?
- Local image building
    - MacOS/M2 build times were under 3 minutes vs. over 20+ minutes on the NAS
- One rake task to do it all from clean git to new version of the app up and running

## What I Had

- Only a partial understanding of how the Synology GUI maps to Docker underneath
- Zero clue if this was possible

## What I Did

Let's see what happened.

__TL;DR__ Here's [a gist of the final files][gist].

### 1. Get the Image to the NAS

Once I made the decision to not involve Docker Hub, or any registry, I figured this was going to be simple enough copy across my network, right? I had a folder on the NAS that was accessible.

I just needed to save the image out to a .tar file and then copy it to the server.

```sh
$ docker save dwfrank/meals > tmp/dwfrank-meals.tar
$ cp tmp/dwfrank-meals.tar /Volumes/docker/meals
```

There are two key things here:

1. I used `docker save` to get the built image from local Docker. Export also worked, but caused problems later.
2. I saved the tar file in `./tmp`, which is in the `.dockerignore` file, which means it's in the development file system, but not the container image.

### 2. Get the Container Loaded

The Synology Container Manager GUI will let you import an image in a tar file. That way was easy. But how could I do this from the command line?

I learned two things:

1. The Container Manager GUI is really just running `docker` under the hood.
2. The `docker` and `docker-compose` executables are installed, but only for root or sudo access.

I enabled the Synology's SSH service, on an alternate port, and made sure my NAS's deploy user had administrator rights. Then I set up a key pair so I could ssh without a password.

After some trial and error, I found that I needed to use Docker's `load` command:

```sh
$ sudo docker load --input /volume1/docker/meals/dwfrank-meals.tar
```

...and that I had to have the full path to the image.[^1]

The image showed up in Container Manager as expected. Progress!

### 3. Injecting Values into the Dockerfile

I decided that the most appropriate place to add the `RAILS_MASTER_KEY` environment variable was when the image is built. It keeps all the environment vars together, after all.

So back to the `Dockerfile` and its env vars section:

```Docker
ARG MASTER_KEY=""  
  
# Set production environment  
ENV RAILS_ENV="production" \  
    BUNDLE_DEPLOYMENT="1" \  
    BUNDLE_PATH="/usr/local/bundle" \  
    BUNDLE_WITHOUT="development" \  
    RAILS_MASTER_KEY=$MASTER_KEY
```

I added the empty Docker ARG for the master key, and then pass it in at build time.[^2] This meant writing the first rake task that does any of this work so I could read the key from the Rails config directory:

```ruby
key = File.read("config/master.key")  
system "docker buildx build --build-arg=\"MASTER_KEY=#{key}\" --platform linux/amd64 -t dwfrank/meals ."
```

I round-tripped the build again, and after running `sudo docker load`, the `RAILS_MASTER_KEY` was right there with the rest of the variables.

### 4. Adding the Database Volume Mount Point

It looked like `docker-compose` was the right way to add volumes. So I  created a `docker-compose.yml` in my app's root with the image name, the name for the container when it's running, and the database mount point:

```yaml
services:  
  web:  
    image: dwfrank/meals  
    container_name: balboa-meals  
    command: bash -c "rm -f tmp/pids/server.pid && ./bin/rails server"  
    volumes:  
      - /volume1/docker/meals/db:/rails/db/production
```

Then I copied this file to the NAS, ssh'd over, and then called `docker-compse`:

```bash
$ cp docker-compose.yml /Volumes/docker/meals
$ ssh deploy@192.168.1.100:822
$ # Now on the NAS
$ cd /volume1/docker/meals
$ sudo docker-compose create .
```

...and I had the container loaded but not running. And all of the environment variables were there as I expected.

### 5. Connecting the Container to the Web Station

The last step was going to have to be manual for now. In the DSM GUI:[^3]

- Container Manager - run the container
- Web Station - reconnect the `meals.local` portal, which won't have a container associated with it, to the container I just ran.

So let's stitch this all together!

### 6. Rake All the Things!

To recap the work so far, I did the following:

- Built a `production.sqlite3`
    - Moved to a subdirectory under `./db`
    - Fixed `./config/database.yml`
- Added a `./.dockerignore`
    - Excluded `./tmp`
    - Excluded `./db/production/`
- Updated the Rails `./Dockerfile`
    - Commented out asset builds
    - Added NAS user and group IDs to the `chown` commands
    - Added injecting the `RAILS_MASTER_KEY` during the image build
    - Used this `Dockerfile` to build the container image from the command line
- Added a `./docker-compose.yml`
    - Picks the image name
    - Sets a container name
    - Sets the database volume mount point

The remaining work that needed to be done on the NAS, via `sudo`, to deploy the app was to load the image, with `docker`, and then execute `docker-compose`. Local commands are easy. But what about the `sudo` commands?

Enter [SSHKit][sshkit]. This is what Capistrano and Kamal use under the hood in order to do their work. And SSHKit [has a Sudo module][sshkit-sudo]. So I was able to use all this for the last remote commands.

I made two additions to the `Gemfile` development group:


```ruby
gem "sshkit"  
gem "sshkit-sudo"
```

And then these commands are in a Rake task:

```ruby
require "sshkit"
require "sshkit/dsl"
require "sshkit/sudo"

desc "Loads the built image into Docker on Filgate"  
task :deploy_to_synology do
 include SSHKit::DSL

  pw = "kwijibo" # get your password from a password manager, etc.
  send_password = SSHKit::MappingInteractionHandler.new("Password: " => pw)

  bin = "/usr/local/bin"
  docker_compose = "#{bin}/docker-compose"
  docker = "#{bin}/docker"

  on "deployuser@192.168.10.124:622" do
    # acutal mounted path for the docker folder
    within "/volume1/docker/meals" do
      sudo "#{docker_compose} down",
        interaction_handler: send_password
      sudo "#{docker} image rm --force dwfrank/meals",
        interaction_handler: send_password
      sudo "#{docker} load --input /volume1/docker/meals/dwfrank-meals.tar",
        interaction_handler: send_password
      sudo "#{docker_compose} create",
        interaction_handler: send_password
    end
  end
end
```

Of note above:
- SSHKit wasn't loading the `PATH` as expected, so I used absolute paths to the executables
- It stops the running container down and then deletes its image
- Then it uses `docker load` to add the image to Container Manager/Docker
    - The assumption is that the image tar is present
- Then it uses `docker-compose` to _create_ the new container from that image

So when you look at the [Gist][gist], you'll see these tasks:

- Ensure that git is clean and everything is committed.
- Rebuild the Rails assets in `./public`.
- Build the image.
- Copy the image and `docker-compose.yml` to the NAS.
- Do the Docker work on the NAS: 
  - Top the current container
  - Remove its image
  - Load the new image
  - Create the new container

Phew! And now I'm wondering how I can get the last manual steps into Rake tasks. Stay Tuned!

---
[^1]: My Synology NAS mounts most of the file system to `/volume1`. Your mileage will vary and will be different from what you see in the DSM File Station.
[^2]: I also went back and uses the same technique for the UserID and GroupID for the `chown` command. You can see that in the code in the GIST.
[^3]: I'm guessing that Web Station sits on top nginx configuration files, but I've not found them or the right mix of commands yet. I will update this post, and/or add a Part III, once I figure this out.
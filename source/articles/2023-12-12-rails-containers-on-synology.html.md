---
title: "Synology on Rails Part I: Running"
date: 2023-12-12 20:35 UTC
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
teaser: "How I finally learned containers and got my Rails Meal Planning app up on running on my Synology NAS."
---

[planning]: /covid-19-inspired-meal-planning/
[forms]: /rails-dynamic-polymorphic-forms/
[ignore]: https://gist.github.com/yizeng/eeeb48d6823801061791cc5581f7e1fc
[syn-cm]: https://www.youtube.com/watch?v=aUFpdjfDI6c
[fw]: https://firewalla.com

Following my [last post][forms], I was ready to deploy an early version of my Meal Planning/Recording Rails app. Given this is a small app, with really only two users, I didn't feel it necessary to pay to deploy it to the cloud and to do the work needed to secure it for cloud hosting.

I knew that I could run containerized apps on my Synology NAS. So I just needed to figure out howto get Rails and my app containerized and deployed.

## What I Wanted

- Rails app running in a container on the NAS
- The SQLite file _not_ in the container
- Access inside my home network
- Automatable deployment

## What I Had

- A Rails app using a SQLite database
- A Mac Mini M2 for development
- A Synology NAS with an Intel processor running DSM 7.2
- Me, who despite working at Pivotal on container-based technology, only had a conceptual understanding of all of these pieces working together.

## What I Did

First, I needed an image.

### 1. Install Docker on MacOS

I installed the Homebrew Cask version of Docker

```bash
$ brew install --cask docker
```

I ran Docker, keeping the Docker daemon running in the background on MacOS.

### 2. Getting The Rails 7.1 Dockerfile

Rails 7.1 ships with a Dockerfile. I built the app with Rails 7.0, but have since upgraded to 7.1, so I generated a new app and copied these two key files:

- `./Dockerfile`
- `./bin/docker-entrypoint`

I'm using `cssbuild` to turn my SASS into CSS. I decided to keep Node and Yarn out of the container for size, which means I made this change to the Dockerfile to comment out the asset compilation:

```bash
# Precompiling assets for production without requiring secret RAILS_MASTER_KEY 
#RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
```

I'll deal with assets later.

### 3. Building the Image

It's possible to build an Intel-targeted container on Apple silicon. Very simple:

```bash
$ docker buildx build --platform linux-amd64 -t <tag-name>
```

However, the when bundling, Bundler complained that the Gemfile needed to support Intel processors.  This line adds this support:

```bash
$ bundle lock --add-platform x86_64-linux
```

Then the image build just worked and was in Docker locally. Then I was able to push the image to Docker Hub in the GUI.

### 4. Running the Image on Synology DSM

I followed [this guide][syn-cm] to better understand how containers, and the Container Manager, work on Synology. I applied this knowledge by:

1. Updated Synology DSM to 7.2+
2. Installed the Container Manager package
3. Installed the Web Station package
4. Imported my image from Docker Hub
5. Ran that image to get a booted container

This _almost_ worked. Everything was good until step 5. The Container Manager had all of the environment variables. Port 3000 was exposed.

I followed the prompts in the UI and made a named Web Station Web Portal - I called it `meals.local` that pointed to the Container. I also updated my local DNS - I use a [Firewalla][fw] at home - so that `meals.local` pointed to my NAS's IP address.

### 5. Whoops - RAILS_MASTER_KEY

But Rails wouldn't start because I didn't have the master key. This was a simple setting in the Container Manager app, adding a `RAILS_MASTER_KEY` environment variable and manually copying the key over from `config/master.key`.

I saved and restarted the container.

### 6. Whoops - The Database

Now Rails wouldn't start because there was no database.  I did the following:

1. Created and migrated the production database file in `db/production/production.sqlite3` on my dev machine
2. Updated `config/database.yml`:

```yaml
production:  
  <<: *default  
  database: db/production/production.sqlite3
 ```

3. Downloaded a Rails `.dockerignore` (thanks [yizeng][ignore]!) and added `db/production` to it
    - This keeps the production SQLite file out of the container
4. Created a directory for my app on the NAS
    - Synology Container Manager makes a directory called `/docker`, so I made `/docker/meals`
5. Shared `/docker` so I could see it on my network, thus able to copy files from my development machine
6. Copied `production.sqlite` to `/docker/meals/db/production.sqlite3`
7. Rebuilt the image and uploaded to Docker Hub

From there I was able to stop and delete the container, then update the image from Docker Hub. Before I started it I had to make a container Settings change in Container Manager:

8. Map a mount point in Container Manager (Container - Settings - Volume Settings in the GUI) for the container so that `/rails/db/production` in the container pointed to `/docker/meals/db` on the NAS.

I rebuilt and restarted again.

###  7. Whoops - Users and File Permissions

Rails still wouldn't start. This time it was because the `rails` user, which the Dockerfile creates, didn't exist. Back to Synology DSM.

1. Created a user named `rails` in the `users` group
2. Fount the `rails` user id and group id - I had to `sudo` to the NAS for this
3. Updated the Dockerfile's "`useradd`" area like this:

```docker
# Run and own only the runtime files as a non-root user for security  
# Synology DSM - make a user called 'rails' and save its id (will need to ssh/terminal for this)  

ARG UID=132 # sudo and find this  
ARG GID=100 # likely this value, but sudo and set properly  

RUN useradd -m -u $UID -g $GID --create-home --shell /bin/bash rails && \  
    chown -R rails:users db log storage tmp public

# Switch to this user
USER rails:users
```

Then I had to do the manual cycle of build image, push image, stop container, delete container, update image, run image, change container settings.

But the app booted and worked! I could visit `https://meals.local` and see my app. Victory!

This was a lot of trial and error. And I was tired of all the manual building, copying, and GUI work. 

Next post: automating the deploy.



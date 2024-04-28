---
title: "Synology on Rails Part III: Improve Deploying with a Local Registry"
date: 2024-04-28 00:00 UTC
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
teaser: Manual deploy steps are maddening. Let's fix it.
---

[p1]: /rails-containers-on-synology/
[p2]: /deploying-containers-synology/
[fw]: https://www.firewalla.com

Well, my app is deployed and running. But after several months of continued development and maintenance, I'm not happy with how I deploy this app. The required manual steps in the Synology DSM UI have proven error prone. I often forget what the steps are and have to click around until it's working. How might we improve deploying my containerized Rails app? 

After talking to others and researching some more, I have two things to try in order to make deploying a container image to my Synology NAS.

## A Local Registry

If you recall the [previous][p1] [posts][p2], getting the image from my desktop to the NAS has these steps:

- Export the image from Docker into a tarfile
- Copy the tarfile to the NAS via the Terminal
- Delete the tarfile. 
 
That has always felt clunky.

I'm not the only one that thinks there's no need to copy a 500GB image up to the Internet, only to copy it back down again. There's consensus around running a local container registry, in a container, on the Synology NAS. Why not? This would drop the export and delete steps from my current workflow. And is makes more sense when deploying via containers.

Good news, everyone! This is super easy. Docker Hub hosts a registry image that nearly drops right in.

### 1. Make a new shared directory

I made a new directory on the NAS at  `/volume1/docker/registry`. I used this folder because I'm already sharing `/volume1/docker` to my network. All my deployable apps have their mount points there. On my Mac, this mounts as `/Volumes/docker`.

### 2. Make a new docker-compose file

On my desktop I created this file: `/Volumes/docker/registry/docker-compose.yml` - and filled it with this:

```yaml
version: "3.5"
services:
  registry:
    image: registry
    container_name: registry
    network_mode: bridge
    volumes:
      # map your volume on the left as makes sense for you
      - /volume1/docker/registry/:/var/lib/registry
    ports:
      # important b/c Synology runs DSM on port 5000
      - 5050:5000
    restart: unless-stopped
```

The first key thing here is to map the volumes correctly - the left-hand size of the colon needs to be the Synology path to the directory I created in the first step. The Docker registry will see this at its `/var/lib/registry` and create files there.

The second is that I needed to map the port. The registry container is listening on 5000. But Synology uses 5000 for the DSM web interface. So I chose 5050, which does not conflict.

### 3. Create the Container Manager Project

In Container Manger, I made a new Project. I called it "registry". I used the path from first step. Container Manager found the `docker-compose.yml` and asked to use it.

It downloaded the registry image from Docker Hub, created the container, and started it. Container Manager calls this "building" the project.

I got a Container Manager dialog that had a checkbox to "allow insecure registry." I said yes. I'm not opening this registry to the Internet, so I'm fine with this.

### 4. Create the Web Portal

Next, Container Manager brings up the Web Station the dialog for creating the Web Portal for the registry. I gave this a domain name of `registry.local`.

I am able to create custom DNS "records" on my home firewall/router (shout out to [Firewalla][fw]), so I set `registry.local` to map to my Synology NAS's IP address - which is a reserved address in my DHCP server. 

### 5. Run and Test

Then I visited `http://registry.local/v2/` and got a response of `{}`. So, yay! A registry!

Next up is using this registry at deploy time.
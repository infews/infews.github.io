---
title: "Synology on Rails Part IV: Simplifying Deploys"
date: 2024-05-02 00:00 UTC
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
teaser: "Moving to Container Manager/Docker Compose is even better."
---

[p3]: /synology-with-registry/
[deploy.rake]: https://github.com/infews
[marius]: https://web.archive.org/web/20240209012226/https://mariushosting.com/synology-how-to-update-containers-in-container-manager/

Now that we have a local registry on the Synology NAS, how do we use it? We want to push to this registry, as well as set up the Synology Container Manager for low-fuss deploys.

## Pushing to the Registry

Pushing is simple. Following the Docker instructions everywhere, there are two small steps - first is tagging the image with the registry name. Then pushing the new tagged image:

```shell
$ docker tag dwfrank/meals registry.local/dwfrank/meals
$ docker push registry.local dwfrank/meals
```

Recall from the [previous post][p3] that I have local DNS set up for `registry.local`. If you're following along and don't have the ability to use local DNS, an IP address + port will work. 

I've extracted my [deploy tasks on GitHub][deploy.rake]. 

To verify that the push worked, I did the following:

1. Go to the Container Manager / Registry pane
2. Click the Settings button and to see my local registry in the list
3. Click the local registry row and then click the Use button; it now had a green checkmark
4. Close this dialog

And there was `dwfrank/meals` in the local registry. Boom.

## Moving to Docker Compose

In earlier iterations, I had some problems using `docker-compose.yml`. But since I got the Container Registry working, I understand Synology's terminology better. And it turns out that using a Container Manager Project w/ a `docker-compose.yml` makes updates _very_ simple. 

### 1. Delete the Old Versions of the app

I deleted the current image, container (both of these in Container Manager), and the app's Web Portal (in WebStation).I'm not going to be using them any more.

### 2. Make the docker-compose File

Next I made a `docker-compose.yml` file in my app's root directory (so it was in `git`):

```yaml
version: "3.5"  
services:  
  web:  
    image: registry.local/dwfrank/meals  
    container_name: balboa-meals
    network_mode: bridge  
    volumes:  
      - /volume1/docker/meals/db:/rails/storage  
    ports:  
      - 3000:3000  
    command: bash -c "rm -f tmp/pids/server.pid && ./bin/rails server"
```

And then I copied this to the app's NAS directory at `/Volumes/docker/meals` on my desktop, where it's mounted from `/volume1/docker/meals`.

### 3. Create a Container Manager project

Again, just like the registry, I created a new Container Manager Project and pointed it at `/volume1/docker/meals`. It found the `docker-compose.yml`, then downloaded the image from the local registry, made the container, and then put up Web Station's "create a Web Portal" dialog.

I gave it the local URL as a name as before. And the app came right up.

### 4. Updating on Deploy

The full deploy cycle is now _very_ simple.

From my desktop:

```$ bundle exec update_version deploy```

Then on the Synology[^1]:

1. Go to the Container Manager / Registry pane
2. Double click on the image I want to update
1. From the dialog, choose the "latest" tag and hit Apply; this downloads the updated image
1. Stop the Container Manager Project
1. Build the Container Manager Project; this recreates the container from the updated image and restarts the Project

There is nothing else to do!

[^1]: This [guide][marius] (Internet Archive version) has a good step-by-step. However, Container Manager doesn't show which projects have images with updates in the local registry. But that's not bothering me for now.

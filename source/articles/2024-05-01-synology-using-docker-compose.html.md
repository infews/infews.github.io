---
title: "Synology on Rails Part IV: Simplifying Deploys"
date: 2024-05-01 00:00 UTC
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
teaser: "Moving an app to Synology Container Manager Projects, which uses Docker Compose, is a huge improvement."
---

[p3]: /synology-with-registry/
[deploy.rake]: https://github.com/infews/synology_rails_deploy_tasks
[marius]: https://web.archive.org/web/20240209012226/https://mariushosting.com/synology-how-to-update-containers-in-container-manager/

Now that we have a local container registry running on the Synology NAS, how do we use it? We want to push updated containerized app builds to this registry, as well as set up the Synology Container Manager for low-fuss deploys.

## Pushing to the Registry

Pushing is simple. Following the Docker instructions, there are two small steps - first is tagging the image with the registry URL. Then pushing the new tagged image:

```shell
$ docker tag dwfrank/meals registry.local/dwfrank/meals
$ docker push registry.local/dwfrank/meals
```

Recall from the [previous post][p3] that I have local DNS set up for `registry.local`. If you're following along and don't have the ability to use local DNS, an IP address + port will work.

To verify that the push worked, I did the following:

1. Go to the Container Manager / Registry pane
2. Click the Settings button and to see my local registry in the list
3. Click the local registry row and then click the Use button; it now had a green checkmark
4. Close this dialog

And there was `dwfrank/meals` in the local registry. Boom.

## Moving to Docker Compose

In earlier exploration, I had some problems using `docker-compose.yml` to configure my app. But since I got the Container Registry working, I understand Synology's terminology better. And it turns out that using a Container Manager Project w/ a `docker-compose.yml` makes updates _very_ simple. 

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

Again, just like the registry, I created a new Container Manager Project and pointed it at `/volume1/docker/meals`. It found the `docker-compose.yml`, then downloaded the image from the local registry, made the container, and then launched WebStation's "create a Web Portal" dialog.

I gave it the local URL as a name as before. And the app came right up.

## Deploying to Tie It All Together

The full deploy cycle is now _very_ simple.

From my desktop (using my deploy tasks linked above):

```$ bundle exec update_version deploy```

Then on the Synology[^1]:

1. Go to the Container Manager / Registry pane
1. Double click on the image I want to update
   1. From the dialog, choose the "latest" tag and hit Apply; this downloads the updated image
   2. Wait for the download to complete
1. Container Manager / Project Pane
   1. Click the Project
   2. From the Actions button, choose Stop; wait for the dialog to say it's complete
   3. From the Actions button, choose Build; wait for the dialog to say it's complete

And that's it. Far less clunky and error prone. And all of the configuration, thanks to the `docker-compose.yml` file is in source control.

In case it helps your projects, I've extracted my [deploy tasks to this repo on GitHub][deploy.rake] for easy inclusion in other Rails apps. These are not Synology-specific, and tie together all the knowledge from this series.

[^1]: This [guide][marius] (Internet Archive version) has a good step-by-step. However, Container Manager doesn't show which projects have images with updates in the local registry. But that's not bothering me for now.

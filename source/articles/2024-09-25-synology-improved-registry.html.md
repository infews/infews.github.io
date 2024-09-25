---
title: "Synology on Rails Part VI: An Improved Docker Registry"
date: 2024-09-25 00:00 UTC
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
teaser: "Adding UI to the Docker Registry now running on the Synology."
---

[orig]: https://github.com/vlastocom/synology-docker-registry
[q]: https://github.com/Quiq/registry-ui 
[fork]: https://github.com/infews/synology-docker-registry/

After a few months of pushing container images to my home grown registry, I was noticing that my server was filling up. I wasn't worried about running out of space soon, but what about a few months from now?

There are a handful of UI projects out there that run on top of the Docker Registry and provide UI to allow management of old images, retention policies, etc. Just what I needed. 

I looked into deploying a few of them and ran into various complexities. Did I have all the dependencies? I think it's running? But I'm getting errors. I was ready to throw up my hands.

## A New Project has Entered the Chat

I found [a project][orig] that unified the default Docker Registry image and the [Registry UI project from Quiq][q] into one `docker-compose.yml`. This looked promising.

My only concern was that the last commit was 4 years ago. And then I couldn't get it all running correctly in the latest Synology DSM, version 7.x. I lost about a half of a day figuring out what was wrong.

## A DSM 7.x Solution

But after that work, I was able to bring [this project up-to-date in a fork][fork]. The README has more detailed instructions. Check it out!

The full details are in the README, but from a high level:

- One Container Manager Project that downloads and boots both the Registry and the UI in their own containers
- A small workaround (an extra reverse proxy) due to a Web Station limitation
- All the management is done through the Container Manager UI (just like your apps you've been pushing)

I've submitted a PR to the original project, but given the age, I'll keep an eye on my fork for feedback.

---
title: "Synology on Rails Part V: Automate the Rest"
date: 2024-09-06 00:00 UTC
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
teaser: "Thanks to Luke Winikates, the rest of the deploy is now automated."
---

[piv]: /synology-using-docker-compose/
[gn]: https://futurama.fandom.com/wiki/Good_news,_everyone!
[luke]: https://github.com/LukeWinikates/
[sc]: https://github.com/LukeWinikates/synology-go
[syndeploy]: https://github.com/infews/synology_rails_deploy_tasks
[bs]: https://ruby.social/@soulcutter

When [last][piv] we left our intrepid heroes, the final couple of steps of the Rails app deployment to a Synology NAS were still manual. It still took mouse clicks in the Container Manager to pull the image from the registry and rebuild the Project. 

[Good News, Everyone!][gn] 

Pivot [Luke Winikates][luke] has put together the [SynoCtl][sc] project which can drive the Synology DSM via its own API. He snooped the http traffic from the web UI, checked out some other "let's automate DSM" projects (the project page has some good references), and got to work. The result is a Golang SDK and an executable that I was able to use in my rake tasks to automate the remaining deploy steps. 

## What's New?

I've updated the [rake tasks project][syndeploy] to use synoctl. There are now rake tasks for pulling the image into the Container Manager Project and rebuilding/restarting the Project. 

Synoctl requires more configuration values than I had, which made the tasks more messy. Thanks to some inspiration from [Bradley Schaefer][bs], I moved to an RSpec-like configuration in a separate file. 

Lastly, I added a namespace for the tasks. Which meant a bit more explanation in the README. And,yes, I've already moved another app to using this file.

Now with _one rake command_ and a few minutes, we can deploy a new version of a Rails app to the Synology Container Manager and get it restarted. This is a happy place to be.

ps: Big thanks to Luke and Bradley!
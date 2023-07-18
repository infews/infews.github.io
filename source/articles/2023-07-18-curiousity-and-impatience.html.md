---
title: Curiosity and Impatience
date: 2023-07-18 00:00 UTC
tags:
  - agile
  - software development
keywords:
  - software development
  - agile
  - continuous delivery
  - the cd test
  - curiosity
  - impatience
  - Pivotal
series: the_cd_test
teaser: "Two under-valued behaviors that accelerate a team."
---
[tbm]: https://cutlefish.substack.com/p/tbm-4952-your-calendar-your-priorities
[nat1]: https://www.simplermachines.com/notes-on-the-pivotal-interview-process/
[nat2]: https://www.simplermachines.com/do-what-works-was-the-hard-part/

Some years ago, during a particularly complex client engagement, we got thrown a curveball. The team was about 10 developers, cranking on a greenfield project. We were a few months in and despite a rocky start, were feeling pretty productive. CI stayed green, we had code in Production, and we were iterating quickly. Then came a random stakeholder request.

The client wanted us to build an upcoming feature set on top of their research teams' experimental APIs. We were building a Ruby on Rails app, deployed on Linux. This API was a collection of Windows DLL's, running on a PC in a lab, in the client's office, in another state.

Did we make it work? Totally. It's just software.

It was a bit of a slog. We had to set up tunnels between our cloud deployments and that office. We stalled for days at a time while we waited on the client's IT team to get to our configuration request tickets. We got there. But it was not fun. Or reliable.

The tunnels were flaky, dying often. The client's IT team rotated IP addresses on an unknowable schedule. This would cause CI to fail. Or even worse, cause demos for the client to crash. At least once we had to find someone to go reboot the Windows box. Not. Fun.

After a few weeks of this, we added some lightweight observability alarms. We invested in some scripts to restart tunnels and update some config files. These were bandages to make things somewhat manageable so we could continue development.

But our morale, productivity, and credibility all took a hit every time this service went down. It was a tax, slowing down work the team was doing. But we lived with it in service of doing new work.

Empathy is a hot topic these days - and for good reason. Software is made of people. Even when we are remote-first and heavily asynchronous, we still have to work _together_ to build software products. Empathy is key to that. Nat Bennett [wrote about screening for empathy][nat1] in Pivotal's hiring process and tied it to one of Pivotal's values - "Be Kind".

Pivotal had two other values: "Do the Right Thing" and "Do What Works." Over time I've realized that a good way to practice these values is to be _curious_ and _impatient_.

A productive team is impatient. They pay attention to anything that feels awkward, slow, or inefficient. It could be production code, a CI that is flaky, a manual task list for every deploy, or that Finance keeps complaining about your infrastructure bill. These are taxes on your team's productivity.

It's not enough to notice, or worse, to complain that these are slowing you down. You need to be curious enough to find out _why_ the tax exists. And then you need to find an alternate way to achieve the same outcome - only with less distraction and more efficiency.

This is work like any other the team does. The team needs to plan and manage it against other priorities. But it's work that you need to do. And it can be just as important as new feature work.

John Cutler mentioned this in his newsletter post _[Your Calendar = Your Priorities][tbm]_. There is value in doing the work that improves your efficiency - what John calls "managing complexity." If you ignore these issues, they inflate and turn into long, expensive interrupts. That work becomes an even _bigger_ drag on your team.

Back to the project. The issues of this Windows machine spilled over at a retrospective a couple of weeks later. Nobody was happy with our solutions we'd tried so far or the impact it was having on the team. Time to find a better way.

We gave a pair of developers a couple of weeks to dig deep into the problem space and experiment. It wasn't easy, but they found a way. They negotiated for admin rights to the vSphere instance that was managing all our VMs for our Rails app. They scripted vSphere (using a Ruby gem) to provision Windows VMs. They automated deploying the latest version of the DLLs to those VMs and then connected them to our Linux Rails deployment. They test drove this work and integrated it into our CI and deployment scripts. After this investment, the Windows code never caused CI to fail, or a Production demo to crash, ever again.

It's hard to map curiosity and impatience directly to the values of "Do the Right Thing" and "Do What Works." When teams acted according to these values, they fixed small problems early and stayed productive. They stayed productive by making themselves even more productive.

Pay attention to your slow tests. Or flaky tests. Don't waste your infrastructure. Keep your dependencies up-to-date.

Do the Right Thing. Do What Works.

Stay impatient. Stay curious.

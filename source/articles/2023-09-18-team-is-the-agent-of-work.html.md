---
title: The Team is the Agent of Work
date: 2023-09-18 22:11 UTC
tags:
  - agile
  - software development
keywords:
  - software development
  - agile
  - Pivotal
  - Release Engineering
teaser: "That time that somebody wanted me fired."
---
[bt]: https://tanzu.vmware.com/developer/learningpaths/application-development/balanced-teams/
[andy]: https://a.co/d/7wMVxHz
[cutler]: https://cutlefish.substack.com/p/tbm-224-the-black-box
[esh]: https://www.linkedin.com/in/testobsessed/
[releng]: https://dwf.bigpencil.net/releng-beer-talk/

Once, a VP walked into my boss's office and said that I needed to be fired.

I had been on the team for about four months. The first few months I was an engineer on the team. Then I had moved into the role of Product Manager - in the [Balanced Team/Pivotal][bt] sense, defining and prioritizing the outcomes for the team of 3-to-4 pairs of engineers.

This was a Release Engineering Team and we weren't releasing  incremental builds to the rest of the organization very fast or efficiently. We were finding problems and fixing them, and thus increasing our frequency of output. But we had a _long_ way to go.

But for some in the org management chain, we weren't moving nearly fast enough. And since I was nominally "in charge," they decided that _I_ was the problem. Replacing me was the essential course of action.

# Finding Accountability

Release Engineering for PKS was an intentional specialization, abstracting away the complexity of Kubernetes, 5 different cloud infrastructures, and multiple interdependent products from related teams. The was was building all the tooling to run a very complex set of continuous integration pipelines for 4 versions of the product simultaneously.

The org had over 30 engineers and multiple downstream teams who needed CI to be green and an installable product package in order to get their jobs done. RelEng needed to be smooth and efficient and we weren't there yet.

The VP had _very_ different expectations about how long CI and packaging should take. Since I couldn't meet these expectations after four weeks leading, I needed to be held accountable. Removing me was necessary to make the team more productive.

Somehow.

Looking back, this would have been like a Major League Baseball team replacing its manager in the middle of a losing season and then expecting a World Series win come October.

# Keeping the Black Box Open

Andy Grove [valued middle management][andy] because they could cut a hole in the (black) box that is a system to find out a team's problems, then drive them to fix those problems. John Cutler has talked about what happens [when you stop looking inside the box][cutler] - you return to status-report-driven drudgery without improvements.

[Elisabeth Hendrickson][esh] taught me about a model of management that's builds well on top of these ideas - that _the team is the agent of work_. They do the work. They own the desired outcomes. Together. No single person, and certainly not the manager, is essential to team success. The team succeeds and fails together.

If a team is struggling, if they are not meeting expectations, a manager should ask them why. A _lot_. The team has the most context about what is happening and why. They know where their dependencies are. They know what work they are doing or not able to do. The manager's job is to ask, listen, understand, and then use their own context and experience to enable the team to improve.

Because it's the team doing the work.

# Flashlight Time

Back to the story.

My boss asked me a boatload of questions about what was _really_ going on. Then she pulled some organizational aikido and had me lead a series of meetings with the VP and other team leaders where I reviewed, in excruciating detail, the entire Release Engineering pipeline. We talked about code and dependencies. I showed average timings of each step over the past few weeks. I talked about the causes of our top five bottlenecks and what our roadmap was to fix them. I also pointed out where other parts of the org could help RelEng go even faster.

I kept the job. The team kept moving. We even got a bit more support from the rest of the organization. And [we did get faster][releng] over the coming months.

(It's worth noting I didn't hear about the whole firing thing from this manager until a year or two later. Great managers know how to get the most out of a team.)

# Save the Team, Save the Outcomes

So when a team is struggling, if it seems sudden or perennial, the solution is almost never to replace the manager.

If you want to help as a leader, remember that building software is a system like any other. Dig into the context with the team. Ask why enough times until you understand what is preventing the outcomes you and the organization expect.

Then use your experience and influence to increase the team's chances of success. Remove obstacles. Change goals. Find other black boxes, cut more holes, and shine more lights. And if you have data that tells you to, make staff changes.

But remember that a new manager isn't going to win you the World Series. Just ask New York Yankees fans about Billy Martin.

The _team_ is the agent of work.


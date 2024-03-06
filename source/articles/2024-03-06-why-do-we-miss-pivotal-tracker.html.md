---
title: Why Do We Miss Pivotal Tracker?
date: 2024-03-06 00:00 UTC
tags: 
    - agile
    - xp
    - pivotal
    - pivotal tracker
    - project management
    - backlog
keywords:
    - agile
    - xp
    - pivotal
    - pivotal tracker
    - project management
    - backlog
teaser: These two key features made your project run more smoothly thanks to Pivotal Tracker.
unsplash:
  url: https://www.pivotaltracker.com/marketing_assets/blog/2018/Customize_Your_Tracker_experience_1-36f1155592bc77922661a6671f47e43b0ef6a910518c8b1183c678ebd95b99c2.png
  title: Example Pivotal Tracker UI
---

[pt]: https://www.threads.net/@parkert
[tracker]: https://pivotaltracker.com
[wenodis]: https://www.youtube.com/watch?v=2kQxVwYwrME
[linear]: https://linear.app
[short]: https://shortcut.com
[jira]: https://jira.com


Among my favorite stories about the "early" days of Pivotal Tracker was the argument of whether or not Bugs and Chores should have (story) points. Tracker originally said no.

[Parker Thompson][pt] had a different take. At the time, his client thought in terms of capacity planning - not velocity volatility - and so he wanted points, dammit. After weeks of this being a persistent breakfast and lunch topic, he escalated to Rob Mee. Which led to a semi-intense argument.

[Pivotal Tracker][tracker] is about to go away for all but Broadcom Enterprise customers. Many of us who love Tracker are still using it for personal projects. A few companies are still using it for shipping products - how awesome is that? So now we pivots are being reflective about Tracker.

So why do _I_ miss Pivotal Tracker so much? I boiled it down to two-ish things.

## Small and Opinionated

Pivotal Tracker has a tight UI with lots of opinions. It's only one tab (per project), stories open in-line (so it's harder to get lost), and even today the fields on a story are not overly complex or rich.

There are only five types of stories, instead relying on tags (Tracker calls them Labels) to categorize lightly. When Epics were added, they were orthogonal - essentially labels that had the same fields as a story. Stuff you want to deal with later - just throw it in the Icebox. And when the icebox got too full and freezer rot happened, it was easy to purge.

All of these choices make it very easy to use 80% of the time. IPMs - Iteration Planning Meetings - stay very fluid. Developers picking up stories knew what to do - pick the next story, open, re-read, ask everyone for clarifications, document anything new, and then start work. Product Managers knew what stories they could accept. Anyone with project context could figure out what was happening with a very quick glance.

Tracker has an opinion about your backlog. And your stories. And your bugs and chores. Not allowing points on bugs - features that _used_ to work, but now don't (this is important) - and chores - developer work that had to be done, but didn't need PM acceptance (say, updating a certificate) - was intentional. If you're completing lots of stories, but your velocity is dropping, that should drive multiple _why_ questions:

**PM:** Our velocity is down. Why?
**Devs:** We had lots of bugs this week.
**PM:** Why?
**Devs:** We had to upgrade a dependency, which led to incompatibilities we didn't anticipate. So. Bugs.
**PM:** Why?
**Devs:** Well, we were missing some tests. Which we have now backfilled.
**PM:** Great! Did we learn anything else for the next time?
**Devs:** A few things. We're ready for next time.

Tracker is simple enough to teach a team the basics in an afternoon. As a team gets better at estimation and monitoring their velocity, Tracker reinforces those practices and helps everyone stay productive.

## Plenty of Problems

Sure there are issues. Tracker still doesn't handle interdependent projects well. It's not smooth when, as a PM, you have lots of draft stories - I found myself working in other apps or keeping future epics "hidden" in another project until they are ready to be discussed at IPM. The integration with source control or CI systems is better than it was, but still can be clunky. There are other features and quirks that bother me and likely some that bothers you.

Backlogs, however, remain awesome. And that leads to Tracker's absolute best feature.

## Release Prediction

The most common question teams get is, "When is it going to be done?" Pivotal Tracker can not only answer that question, but it enables the necessary mitigations to keep a project to any date commitments.

Tracker has a type of story called a Release. Its form is the same as the others. But it has a target date (you read that right: an agile project planning tool with a date; stick with me here). You create a release, fill out the rest of the UI (description, etc.), add a date, and then drag the release down to just past the last story you want completed for that release.

Tracker cares about the project's current _expected_ weekly velocity and the estimations of all of the stories before the Release in the backlog. If the sum of all of the estimations says you are likely to get all the work done by that date, nothing changes. But if the velocity tells you that the work won't be completed by that date the release marker _turns red_. Literally. The background goes from blue to crimson. You're not going to make that date and you need to take action to get the Release de-risked.

Much like the velocity discussion, the team gets to have a release discussion. There are two choices[^1] -

1. Cut scope.
2. Change the date.

Both involve work. Cutting scope means making product and technical choices. Changing the date means having hard discussions with management and customers. Likely, the team is going to use some mix of the two. But when you make decisions and update the backlog, Tracker will reward you by turning that Release's background color from red back to blue.

## Back to Bugs & Chores

In the end, Parker got his points for bugs and chores - one of the few customizations that Tracker allowed at the time. It's project-specific. And yes it puts you into a capacity-planning mindset - which _can work_. And the above features and team responses still apply. But no, I don't put points on bugs and chores.

## Will Other Apps Ever Catch Up?


I've used other backlog tools: [Linear][linear], [Shortcut][short], and [Jira][jira]. Each has pros and cons. I've even worked in Jira backlogs that aren't awful - just not as good at the above as Tracker. But none of these apps has "release prediction" functionality, reinforcing good velocity and estimation practices, anywhere close to Tracker's. 

With Tracker waltzing over the horizon, I wonder if we'll ever see something close to its superpowers[^2].

[^1]: Sure, you can "work harder." But that's less predictable and not sustainable. [Wenodis][wenodis].
[^2]: I'd love to be wrong on this. Reach out you've found an app that does release prediction well, or know how to configure one of the mentioned apps to approximate this.


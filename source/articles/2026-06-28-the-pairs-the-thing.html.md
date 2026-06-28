---
title: The Pair's The Thing - Introducing PXP
date: 2026-06-28 14:32 UTC
tags:
  - ruby
  - rails
  - software engineering
teaser: "How I learned to stop worrying and love the agent."
---
[jess]: https://github.com/jszmajda
[lid]: https://linked-intent.dev/
[pxp]: https://github.com/infews/pxp_skill

My experience with chat-based AI code generation in 2025 was...fine. I liked it, but didn't love it. I didn't see what all the hype was about. And then the agents entered the chat.  

## Linked-Intent Development

I had my first agentic coding session in early 2026. I used my coworker [Jess Szmajda][jess]'s [Linked Intent Development][lid] skill and AI coding clicked for me. LID[^1] is a multi-phase Spec-Driven-Development system. You write the high-level description for the work you need to do in Markdown. Then you and your agent refine the work into high-level and low-level design documents. The agent slices the low-level design into EARS Specs, then TDD's each spec. I worked on a toy exercise for an afternoon and felt productive.

## Iterating

After a few more cycles on a couple of different projects and I wanted something different than LID. I felt like I was spending a _lot_ of time in design documents. I like that the agent keeps all the levels of documents connected. But I prefer emergent design - I want the tests to tell me what the design should be. I caught my agent, more than once, writing entire classes in the low-level-design doc. How can you TDD if the code was already written?

It was time to write my own skill.

### What I Wanted

My primary goal was to build a skill that felt as familiar to me and other pivots as possible. How did we work? How would this adapt to having an agent?  I knew I wanted:

- _Real TDD._ Red-Green-Refactor and no writing of any implementation without a test. Tests need to fail for the expected reason.
- _Small feedback loops._ The agents should be writing small parts of the solution at a time. One function, or maybe one class at a time. Definitely not whole UI flows before a developer reviewed the work.
- _Idea-to-task flow that felt familiar._ I wanted the workflow to feel like a Pivotal Iteration Planning Meeting (IPM). You start with an Epic or story and then work down to dev task tasks and TDD.
- _Works for one person._ That is, I'm going to be the Product Manager and the developer at different times. The agent had to keep us honest regardless of the hat I was wearing. We should have enough tracking documentation to allow for interrupted work. Side projects start and stop. API limits can mean pausing for a few hours.

### What I Didn't Want

I had to avoid the sneaky "write the code first" behavior.  I wanted to keep things simple, so I wanted to avoid any multi-agent orchestration. One at a agent at a time was fine for now. Maybe forever. And I wanted to avoid the long-running agent problem. I didn't want to have to review pages and pages of code to see if it met the need and avoided hallucinations.

### Duh

I wanted a _pair_. Both when I was in Product Manager mode _and especially_ when I was coding. Claude, want to pair on this?

## Introducing the Pivotal XP Skill

AAnd here is the result - [PXP][pxp]. It is agentic skill, proven to work well with Claude, that takes you through an entire feature from IPM to TDD. Together, you and your agent write and refine documentation in your repo that gives an SDD flow. It strives to feel like you are working from a Pivotal Tracker Backlog.

- _Epics_ - Documents that describe each batch of work - one shippable feature or set of bug fixes. It tells you what is in and out of scope for the work. You write this and refine it with your agent pair.
- _Stories_ - Your agent then slices the epic into actionable stories. Each story has a set of Gherkin/GWT Acceptance Criteria. The Epic maintains links to each of its stories.
- _EARS-based Tasks_ - Each Acceptance Criteria gets its own named, spec-driven task. These are broken down into an implementation order in the story doc.
- _TDD / Red-Green-Refactor_ - Each EARS gets TDD'd one at a time. The agent annotates tests and implementsion, with the EARS name in comments.

I've been using and iterating on this skill for the past 2-or-3 months. We've written a lot of code. Hallucinations have been low. I tend to commit as each story is complete - though bigger stories have had some WIP commits at a EARS/task boundary. I am very much in the loop on every step of the way and still feel crazy productive. I'm happy with the code results.  Refactoring has gone well. I've had similar success with Ruby, Rails, and JavaScript (and Google AppsScript) projects. I also dipped my toes into an iOS project, where I know next to nothing.

I completed a minor redesign of this blog using PXP. It included a complex CSS simplification refactor pass. You're soaking in it.

Claude did have a moment where it _really_ wanted to have table-driven tests. Um, nope. Stop that. And it did. 

The token count is not low, but the README has some tips on model choice to help manage your API usage.

It's available via GitHub right now. I've submitted it as a marketplace plugin. I hope it will get approved this week. Kick the tires and let me know what you think!

[^1]: I get partial credit for the name


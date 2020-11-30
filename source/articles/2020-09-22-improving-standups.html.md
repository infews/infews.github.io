---
title: Improving Standups
date: 2020-09-22 00:00 UTC
tags:
  - agile
keywords:
  - agile
  - xp
  - standups
  - trello  
---

[wb]: https://github.com/pivotal-legacy/whiteboard
[fuji]: https://www.amazon.com/s?k=fuji+instax&crid=30RYK9F4OJF9A&sprefix=fuji+insta%2Caps%2C203&ref=nb_sb_ss_i_6_10
[example]: https://trello.com/b/qcJ1Ba56/standup-example#
[trello]: https://trello.com
[miro]: https://miro.com
[gdocs]: https://drive.google.com

Your software development team has a daily standup meeting. How’s that going?

Teams at Pivotal had a fairly common agenda for standup. We reviewed Helps (“I need help with…”), Interestings (“Yesterday I learned that…), and Events (“What are we doing besides coding today?”). We rarely got into the details of specific work unless there were team-wide concerns or if someone had a specific question.

Keeping to this agenda daily and keeping the ritual alive over time takes effort. We wrote a [Rails app][wb] to help. Over time we realized that there are additional, some emergent, problems that cropped up during our meetings. 

## Standup Problems 

I have seen many problems in common across several teams. Some are just informational: 

- What is the agenda for today’s standup?
- When I find an item to discuss at standup tomorrow, how do I not forget to bring it up?
- Which events are coming up in the next week?
- Who’s on vacation and when?
- What stories (or epics, or tracks) is the team working on? Which pairs are working on them?
- What are today’s pair assignments?
- What are the active action items I have from team retrospectives?

Others problems are more structural:

- There is enough structure to make the meeting productive, but not so much to be a burden.
- The ritual is lightweight enough to allow for iteration, but solid enough to perpetuate.

Having some sort of physical board present in a team’s area can work well. Put this information in one place, use it to drive the daily ritual, and it lives the rest of the day as an information radiator for the team and the rest of the office. Some Cloud Foundry teams even had [Fuji Instax][fuji] photos of each team member and moved them around to identify pairings and which stories they were implementing.

The physical board breaks down as soon as the team has one remote team member. Given how COVID-19 has made so many teams fully remote, what can we do? 

We move the board online. 

(Credit to the Cloud Foundry CAPI team - a semi-remote team even in 2018 - where I first saw this solution.)

## Setup

What you need:

- An online kanban board
- Digital avatar photos of each team member
- A standup agenda.

I’m going to use [Trello][trello] in this example, but things like [Miro][miro] or even a [Google Spreadsheet][gdocs] can work. For the agenda, I’m going to use Helps/Interesting/Events/Pairing Assignment.

Then you should set it up like this:

1. The Left Column is “Standup”; it holds divider cards for each agenda item.
2. The next Columns are just labeled “Track”; we’ll have 2 tracks in this example
3. The next column is the “Pairing Parking Lot”
4. Lastly, a column for the “Retro Action Items”

<br/>
Now you can add one card for each team member to the Pairing Parking Lot. Your board should look something like this:

![Early Setup](standup/early.jpg)

Everyone on the team should have access to this board so they can add cards as needed during the day. Peer teams can have read or read/write access, depending on your organization’s norms.

Great! How do we use it?

## Standup

Standup is probably in a video call with everyone present. The emcee can now share their screen, reviewing cards in the lefthand column, top-to-bottom. Trello allows for a single keystroke to archive cards as you finish them.

## Pair Assignments

After the lefthand column is complete the team can discuss the day’s work. This means shuffling and assigning pairs to the available tracks of work. Whatever your pair rotation strategy - daily splits, track anchoring, etc. - your decisions should be reflected by moving the cards around.

The “Pairing Lot” is a place to put people’s cards when they are away from the team. Or while you decide assignments for the day (hence the example’s dividers for available/unavailable).

## Retrospective Action Items

This board can also be a place to track and remind team members about their action items from retrospectives. Even if you use software to run your retros, this board can surface them daily. Action items that stay top-of-mind are more likely to be completed.

## As Things Change

In full use, the board will look more like this:

![Full Standup](standup/full_setup.jpg)

(or play with the [live example][example])

After standup, changes that affect the team should lead to updating the board.

- Vacation on the horizon? Or team rotation about to happen? Add a card to Events.
- Find a help or interesting during the day? Add a card.
- New team member? Add their card. On their first day, use the exercise of adding their photo to verify they have access and then explain the ritual.
- Starting a new story or track? Rename the Track column. Or even better? Add a card.
- Another team member action item pops up? Add a card.

## Iteration

A developer may look at this and see opportunities for automation. Or maybe frustration that software isn’t choosing pairings, or tracking frequency of certain pairs…

This is just a starting point. It is ripe for innovation and iteration. Knock yourself out. But be careful of the yaks you choose to shave - it’s just for five minutes out of your team’s day. Do what works.


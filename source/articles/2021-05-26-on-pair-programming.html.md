---
title: "On Pair Programming"
date: 2021-05-26 14:51 UTC
tags:   
  - software development
  - agile
  - xp
  - pair programming    
keywords:
  - pair programming
  - agile
  - software development
teaser: "In which I talk about my experience and ideas on how to build a sustainable pairing environment for your team."
---

[nat]: https://www.simplermachines.com/the-mortifying-ordeal-of-pairing-all-day/
[pairing]:https://martinfowler.com/articles/on-pair-programming.html
[xp]: https://en.wikipedia.org/wiki/Extreme_programming
[lean]: http://theleanstartup.com/
[bt]: https://balancedteam.org
[jdawg]: https://janicefraser.com/
[ubad]: https://vimeo.com/298568369
[is]: /improving-standups/
[pong]: https://youtu.be/5h-zsDXQH_8?t=181

The internet had a bit of a buzz about [Nat Bennett's thoughtful post on their pairing experience][nat]. I think they did a great job talking about the personal impact of the pros and the cons of how we practiced pair programming at Pivotal. 

Dev Twitter can tell you all you ever wanted to know, and maybe much you are worried about, on the [topic of Pair Programming][pairing]. Dev Twitter will also swarm you with claims that differ from your experience. Because, _opinions_, man.

Naturally, here are some of mine.

## Pairing at Pivotal Labs

The Pivotal Labs consulting practice was built to immerse product teams in agile practices. Those practices started with [Extreme Programming][xp] (XP), and added [Lean Startup][lean] and [Balanced Team][bt] over time. Clients paid for and expected the immersion. The work was (almost exclusively) in our offices, thus away from their normal day-to-day routines, to maximize exposure to new ways of working.

For developers, XP includes pairing. So developers - pivots and clients - paired from 9am to 6pm. Every day sitting at your own keyboard, mouse, and screen, but at the same computer as another developer (who has their own keyboard mouse and screen). The coaching and learning and dead ends and green-test-runs and high-fives were constant. Breaks happened - people got up to walk around the block, play ping pong, get coffee, etc. But still, it was exhausting.

When someone is new to pairing I use the metaphor of martial arts. You are teaching yourself a new set of skills. Some are mental - thinking aloud, active listening, and figuring out how your pair does the same. Some are physical - negotiating for keyboard control, using a new set of keyboard shortcuts, and navigating a different sense of personal space. You will be tired - a _lot_ - in the first few days-to-weeks because you are thinking and doing differently than before. But with regular practice, and coaching, and breaks, you will build what feels like super powers.

Projects would start with pivot developers pairing with client developers. Over time client developers would pair with each other. The ratio of clients-to-pivots would increase over the life of the project. The client developers became the coaches. It was amazing to watch.
Pivotal Labs was successful at teaching teams how to "be agile" while shipping software. Pair programming was a foundational element of this success.

## My Personal Experience
My first month pair programming was draining. I would leave the office spent. And I slept very, _very_ well each night. It was a lot of "wax on, wax off." But after a few weeks, I did have a well-painted fence. And the finish on the cars was concours-quality.

When I left that job (after about a year) and started at Pivotal Labs, it was like starting over painting an entirely new fence around an entirely new parking lot of old cars. It was hard work, but I learned so much about myself and about the craft of software.

I stayed for 12 years. I worked through lots of change in the company and various roles on different teams. But when I was a developer, I paired by default every day. Pairing works for me. I find I'm even more productive when I pair. I enjoy it. Even fourteen years later.

## Introducing Pairing

If pairing sounds interesting, you might wonder how pairing could help your team. Here are some questions to ask:

- How long does it take for new developers to ramp up and be effective? How long until they can lead new work?
- How much time do your developers spend being coached in the craft? Are they asking for more?
- How does your team review code? Does this process work well? How long does it take to get code to production?
- What happens to the pace of work when integrating new, large blocks of features into the product? Or when finding and fixing a particularly thorny bug? How long does it take that pace to recover?
- Are there knowledge silos on the team? How large is the risk of losing one "key" person due to vacation, resignation, or other reason for leaving the team?

With practice, paring can improve these metrics while continuing to ship software predictably. Teams can grow, and shrink, with low disruption. Developers are learning from each other, improving their craft. They ship lots of business value with high confidence.

TL;DR - Pairing _can_ work. _Some_ developers like it. A lot. But that's not enough.

## Deciding to Pair

But how does a team start pairing?

The team has to decide, as a group, to try pair programming. It's too big a change to the status quo, from developer up into management, to "just start." If you want some help here, begin with [Janice Fraser][jdawg] and her [U-BAD model of decision making][ubad] : Understanding, Belief, Advocacy, and Decision.

You need a solid foundation. The team needs to understand what pairing is and how it will work. They also need to believe that it could help them. And that they will have support from each other and management to make it work. Pairing can help. A lot. But the team has to make the decision.

## Sustainable Pairing Practices

Once the team has made the decision and set themselves up for success, what next? I recommend that everyone starts the day pairing. Having a standup meeting first thing gives everyone a daily reset and catch-up. It's time to ask for help and plan the rest of the day (see my post [Improving Standups][is] for tips).

Among the messages Nat gave us from their post, the key one is sustainability. The team should set itself up so that individuals ease into, and recharge from, pairing time. This increases the chances of adoption and thus the impact on the team and product.

It is important to set the expectation that the entire day will not be pairing-on-code time. As the [guide mentions][pairing], there are plenty of non-pairing situations. The pair can and should plan their work around the meetings and 1:1's. This planning is as much about making sure these happen as it is to avoid abandoning someone in a big coding problem.

Encouraging and taking breaks is vital. People get mentally tired. There is a reason you may have heard that we [played a lot of ping pong][pong] at Pivotal. It is a paired activity that gives your coding brain some rest. I have also found that walks outside - or in a pinch, staring out the window - can be restorative.

The team also should schedule time for solo work. Deep research, reading, and writing are necessary work that are also best as solo activities. Some teams schedule regular solo "spike" or "exploration" days that allow for personal investigation.

Determining when you break up pairing sessions, be it for meetings or walks or table tennis, is going to be a personal or team decision. Some people will like long, unbroken stretches of pairing time. Others will like three or four smaller stints. Experiment. Iterate. Have focused retrospectives on pairing. Make tweaks.

Nat reminds us that teams are made up of individuals. And individuals are, well, individual. Each person's reaction is going to be different. Pairing won't work for everyone. And that is OK. Prepare for some people to opt out - be ready to move them to other teams.

In my experience I've seen pair programming work in a lot of contexts. But for pairing to _last_ in a lot of contexts, you need to remember that your developers are people. And you need to take care of people first so that they can take care of the product and themselves.

---
title: Balanced and Empowered
date: 2023-10-05 00:00 UTC
tags:
  - agile
  - software development
keywords:
  - software development
  - agile
  - Pivotal
  - Release Engineering
  - Balanced Teams
  - Empowered Teams
teaser: "How we got RelEng back on course, and I kept my job."
---

_This article is a spiritual Part II to the post [The Team is the Agent of Work][me]._

---

When I joined the PKS Release Engineering team, they had two dense tracks of work.

Track One was developing all of the continuous integration pipelines and tooling that tested and packaged the PKS product. This was a _very_ complex system of nearly 500 [Concourse][cci[] pipelines, running on 4 (eventually 5) cloud infrastructures, for 4 versions of the product, and between 3-8 different scenarios. These ran on every pull request that came from the PKS development teams.

Track Two _operating_ all of those pipelines - updating pipelines as business needs changed, triaging failing builds, fixing any infrastructure causes, and notifying the dev teams when it was a legitimate product failure.

This was hard.

To make it easier, the team was building the system so a developer could run a subset of pipelines, locally, on one infrastructure. The hypothesis was that running green locally increased the chances that the run of the full pipeline set would be green and the PR was acceptable. It was a fine hypothesis.

The complication came from the volume of RelEng feature work needed before that hypothesis could be validated. RelEng as a team was empowered to do this work for the PKS dev teams. But unvalidated hypotheses are the devil's playthings.

The stakeholders didn't care about a grand set of tooling that might eventually make the developers' job "easier." They wanted to ship PKS to customers NOW. New features, new versions of Kubernetes, and bug fixes should be shipping frequently. RelEng wasn't "moving fast enough" (read: as fast as they expected).

Which is why [one of the VPs wanted to fire me][me]. I was leading this team now. And I had a _very_ frustrated stakeholder.

## Balance the Team

With the team being the agent of work, how do you set them up to deliver to stakeholders' expectations?

Empowered teams are impressive for the amount of work they can do while staying healthy. What is sometimes missing in [the discussions of empowered team theory][rj][^1] is how to keep the team focused on the correct work - the work that actually meets the stakeholders' and customers' needs and expectations - at the right time - executed in an efficient order. How do you keep everyone talking, the team productive, and prevent unnecessary work?

One organizational approach for empowered teams is [Balanced Team][bt]. Very simply put this approach gives you three key roles:  Designers, Developers/Engineers, and Product Managers. Each comes with a set of modern practices. Designers bring User Centered Design, Developers bring XP (TDD, Pair Programming, Continuous Integration, etc.), and PMs bring Lean Product Development.

Designers decide what's _desirable_ to customers that solves their problem, Developers decide what's _feasible_ to build, and Product Managers decide what is _viable_ for the business and stakeholders. The intersection of the three areas is where the team will build the most value. The interactions between the roles reinforce each other to keep the team in the value sweet spot.

This sounds great. But how do you keep your stakeholders involved? By owning viability for the business, Product Managers are the conduit between the team and the stakeholders. They need to understand the business context well enough to help define stories and epics, especially story slicing and backlog prioritization. They need to understand design and engineering well enough to evaluate and compare the costs of potential solutions.

And it's not just a "build the backlog" role. They need to accept completed stories as a proxy for the customers and the stakeholders, rejecting work when it's incomplete or bugs are found. They need to react  to changes in the business climate when things like budget or headcount changes or new competitors enter the market. PMs also need to reset stakeholder expectations when challenges like API limits, hosting costs, or new user insights present themselves.

A strong Product Manager reduces the stress of stakeholders, enables designers to focus, and frees up developers to code.

## Reset the Team

The VP (who, again, was the one who wanted to fire me) was telling us, very directly and indirectly, that we were _not_ meeting their needs and expectations. Our Empowered RelEng team was building what we _thought_ would make the whole org move faster. Instead, it was a big, complex solution with impact that was months away from paying off.

I was acting in the balanced team's role of Product Manager. I needed to reset the relationship with the VP, the dev teams, and the rest of the stakeholders. And I needed to do this in a way that would unlock the developers' skills to tell us how we could start moving the entire org to higher productivity.

First, we broke our existing system down into all of its steps - from pull request to published package - and timed them all. We listed all of the potential failure cases along the way. We put it all on a public whiteboard and shared it with the entire org.

With some introspection, we saw that we were focusing on building an ideal toolset for the PKS dev teams - Track One. Track Two had us mostly focusing on frequent flaky tests running in the pipelines. The former was something that nobody asked for. The latter was wasting time and effort, because at the end of the day RelEng had very little control over making the tests more reliable.

## Point at the Summit

We held a [mountain climber retrospective][mtn] and put the goal at the top of the mountain of "1 pull request per day per version." We listed our "boulders" - all of the bottlenecks from the whiteboard. We talked about making better "ropes" - code we could write that would get us to the top more reliably and faster. We spotted some "First Aid kits" - places where some additional help from other teams would make us stronger.

With the new focus, we prioritized smaller efforts that shrank the feedback loops for every pull request. We did work in the pipelines themselves. We found the easy wins improving RelEng's code and tooling that removed, or heavily reduced the cost of managing, failure cases.

Some highlights[^2]:

- Parallelized our pipelines such that a 35 hour pipeline run shrunk to 7 hours
- Built our pipelines from smaller, well-abstracted YAML files, reducing manual errors during pipeline operation to zero
- Moved our public cloud resource management to well-factored Terraform, eliminating errors during cloud creation & deletion (this happened hundreds of times a day)
- Worked with an internal team to right-size our private cloud resources, reducing errors due to lack of server availability
- Deleted code that generated some product configuration YAML, replacing it with editable YAML files, reducing errors during our final packaging

We updated the public whiteboard frequently and improved org-wide communication on our results. We got _very_ close to 1 PR per day.

Oh, and I kept my job.

Our empowered team became a balanced team. We treated Release Engineering as a _product_. We interviewed our users - the PKS developers. We met more often with our stakeholders. We focused on what we _needed_ to build instead of what we _wanted_ to build.

We solved problems. We shipped. And people - customers, stakeholders, and the RelEng team - got happier.

---
[^1]: Shoutout to RJ Zaworski for this take on Empowered Teams. And extra points for the hot-take-title.
[^2]: For more technical details of some of this work, see [Three Cheers for Release Engineering][3c].

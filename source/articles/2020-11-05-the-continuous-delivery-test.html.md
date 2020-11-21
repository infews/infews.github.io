---

title: Introducing The Continuous Delivery Test
date: 2020-11-05 00:00 UTC
tags: ["agile"]
series: "The CD Test"
series_slug: "cd_test"

---
[slootman]: https://www.linkedin.com/pulse/amp-up-frank-slootman/
[farhan_profile]: https://twitter.com/fnthawar/
[farhan_list]: https://twitter.com/fnthawar/status/1314902602509938688
[cd]:https://continuousdelivery.com/
[joel]: https://www.joelonsoftware.com/2000/08/09/the-joel-test-12-steps-to-better-code/
[toaster]: https://www.danielsen.com/jokes/objecttoaster.txt
[explore_it]: https://amzn.to/2HdUWrs
[retros]: https://www.agilealliance.org/glossary/heartbeatretro/

_The spice must flow…_

Frank Slootman’s _[Amp It Up][slootman]_ advocates removing “slack” (the concept, not the app) from a team to get greatest productivity. There’s pushback that this approach is toxic and/or it leads to colossal burnout. I agree. Low slack is not the same as high productivity. [Farhan Thawar][farhan_profile] shared [a list of characteristics or practices][farhan_list] that lead to productive teams. I like this list a lot. 

I like his list no doubt because Farhan and I both used to work at Pivotal Labs. But I’d like to take a different approach to talking about software team productivity.

Instead of focusing on removing slack from a team, the best way to make a team productive is [Continuous Delivery][cd]. That is, setting the team up such that new work is flowing from concept to development to production smoothly and often. There is continuous delivery of value to customers. When work ships, it works as expected, it’s reliable, and there is little re-work. The team, by default, is always looking forward to the next new value they can be delivering. There is a low amount of waste during development. When there is waste, the team adapts to remove it.

A Continuous Delivery team looks much like a modern physical goods manufacturing line. From the outside it looks like requirements go in and work - features and fixes - come of out the other side. Inside there are conscientious workers, well-maintained machines, and low inventory. People are improving their workflows for higher efficiency. When there are problems, Andon cords get pulled, and the team stops to fix them. A high functioning CD team has high productivity with low stress. And they are improving themselves all the time.

How close is your team to this ideal?

Joel Spolksy gave us the [Joel Test][joel] for evaluating software teams 20 years ago. It is still relevant, but this test is of a time of shrink-wrapped, desktop software. Bug databases and source control have become defaults. Most software is web-deployed applications and services.

With apologies to and inspiration from Joel, I give you _The CD Test_ &mdash; a list of simple yes/no questions to check your team. The score is the sum of yes answers. A high score doesn’t mean your team is perfect at Continuous Delivery. But if you review your “no” answers I’m sure you’ll find discussion points for improving your team. Here goes…

---

## The Continuous Delivery Test

- Does the team have a single product owner?
- Is there a single backlog of stories, stack ranked in priority order?
- Does the team have weekly planning meetings to review the backlog?
- Are stories completed in a day or two?
- Do developers take the next story from the top of this backlog?
- Do developers test-drive their code?
- Is the test suite fast enough that you don’t complain about them?
- Is there a Continuous Integration system that runs on every commit?
- Does every CI green build get deployed?
- Does the Product Owner accept work by exercising it in the product and with low latency?
- Is it simple and “low drama” to make a production deployment?
- Do features make it to production frequently?
- Does the team have daily stand-ups, with a goal of communicating change and unblocking issues?
- Do people work on one project at a time?
- Is it easy for developers to move between teams?
- Are teams composed of team members of diverse skill levels?
- Is asking for help, thus leading to knowledge acquisition, seen as a strength?
- Is Quality an exploratory function (and not a gatekeeper to release)?
- Does the team meet weekly for Retrospectives to discuss team issues, leading to new work that improves team progress?
- Does the team complete their action items from Retrospectives?

---

## Does the team have a single product owner?

Somebody has to be The Decider. For CD teams, this is the Product Owner (or Product Manager). Everyone from customer support to leadership should be making their requests for new work. But the Product Owner needs to be the  Decider. The Product Owner takes all this input and prioritizes it in the backlog. There will always be give and take on work priority - that is healthy. Often this means deciding what _doesn’t_ get done. Too many cooks spoil the broth and too many stakeholders distracts a team.

## Is there a single backlog of stories, stack ranked in priority order?

If work definition lives across many pieces of software and many people’s brains, how does the team know what they should be working on? Once the Product Owner decides and prioritizes work, and the development team estimates it, this needs to be communicated. There should be a single, team-visible, stack-ranked backlog of work to do. Each piece of work - ok, I’ll call them stories. Each _story_ should have enough information so that work can start. 

Each story should include use cases, acceptance criteria, estimates, design artifacts, and implementation ideas.  The key is to put it all in one place with clear priority order. This makes it easy for the team to pick up the next work to do.

## Does the team have weekly planning meetings to review the backlog?

The world around your product is changing all the time. The Product Owner needs to share these changes and how they affect the upcoming work. The rest of the team needs to digest and contribute their views to team understanding. The team needs to review designs and estimate implementation. This helps the team increase their shared understanding of the product. And it helps the Product Owner change priorities. Having this meeting weekly allows everyone to make small corrections and stay productive.

## Are stories completed in a day or two?

Long stories take a lot of time to understand, design, and implement. They seem perpetually “almost done.” The work is not yet available to verify and not yet in front of users. Some of the team is working on them and nothing else. Nobody is happy.

Keeping stories small enough to complete in a day or two is the antidote to this problem. The stories are often simpler, making them easier to complete. It is easier for the Product Owner to verify smaller pieces of work, thus confirming progress. The team will build a sense of progress and maintain it. And customers will get more value more quickly.

## Do developers take the next story from the top of the backlog?

When a developer completes a story, how do they decide what work is next? If developers aren’t getting their work from the Product Owner, what are they working on? Any other source of work and there is a high risk that it’s not the next most important work to provide user value. And there is _very_ high risk that this other work could provide little value to the product.

 If the backlog is well prioritized and well understood, then the next piece of work is obvious. This keeps the team moving forward in a uniform way.

## Do developers test-drive their code?

Writing tests for code has become common. Test code has become part of the product. Writing tests that run several times a day helps find bugs early where and when they are cheapest to fix. Joel was spot-on for this one.

But writing tests first is even better. It helps the team write only the code they need to finish a story. This means less waste in the development process. It also increases test coverage because tests define which code gets written. It will be easier to find bugs later when refactoring or when dependent code changes. And in another nod to Joel, well written tests are _even better_ than product specs. They tell “you in the future” how the code actually works.

## Is the test suite fast enough that you don’t complain about it?

If the test suite is too slow, then development will be slow. The team will tend to run it less often, lengthening the feedback loop when they add new code. Or even worse, if the test suite takes too long to run the information it provides will be less relevant. You want a test suite and you want to run it often. So keep it fast.

The team can keep their test suites fast with several techniques. They can reduce over-testing (hitting the same code over and over again). They can write only enough tests to keep confidence in the product high. They can parallelize tests. They can use the best hardware. They can limit testing external dependencies (e.g., external API’s). And since test code is product code, developers can refactor it as needed to keep performance at peak.

## Is there a Continuous Integration system that runs on every commit?

Even today “it works on my machine” is still a problem. There can be accidental inconsistencies between development systems and production environments.  Developers can be working on semi-conflicting changes without realizing it. The product can be working, with test suites passing on one developer's machine. But that same work could fail shortly after check-in.

Continuous Integration (CI) takes every code commit, integrates the changes, and runs the full test suite. A "green build" means there are no conflicts. This means work can continue. When there are errors, the developers can fix them right away, dropping new work to fix the build. CI keeps the team flowing, preventing some bugs from making it to production.

## Does every CI green build get deployed?

A green CI build tells that the team that the product currently works as expected. It should "ship" to a deployment immediately for review. A team which is deploying every green CI build is acting in the spirit of The Joel Test's daily builds. Less complicated products might do this on a staging deployment. More complicated products may deploy to production, but with feature flags. This prevents users from using new work before validation. 

It does not matter where the green build deploys. Regular deployment shows that the team knows how to build regularly and repeatedly. They find issues early. "Early" means after the tests have passed, but before users can exercise it. 

## Does the Product Owner accept work by exercising it in the product and with low latency?

A test suite tells everyone the current status of the product. CI will catch integration problems, broken features, or bug regressions. But what about that status of new work?

New work should only ship to production when the Product Manager approves it. A staging deployment that has the latest green build of the product enables them to review new work. This is the opportunity to tell developers, “Great work! Let’s get it in front of users,” or, “Oops. This doesn’t work as we discussed. Let’s try again.” 

If the Product Owner is reviewing work early and often, it keeps the feedback loops short. Ideally they are validating new work daily. Fixing bugs and problems can happen more quickly. Or, if the work is as desired, the Product Owner can plan for how to get this new work to production and to users.

## Is it simple and “low drama” to make a production deployment?

Getting new work to users is one of the most important things a product team can do. It is often one of the most fragile processes: too flaky, too manual, and resulting in extra hours worked.

Instead, teams should treat deployment like a feature of the product. The Product Owner puts deployment stories in the backlog. Development implements them. The product ships to staging and production often. Changes in deployment, like changes in infrastructure or a database upgrade, suggest new stories in the backlog. Deployment is then simple, reliable, automated, and predictable. Customers get their new features consistently. And the team can go home on time.

## Do features make it to production frequently (> 1x every 3 mo)? 

Shipping work to customers is important. It should happen often. Completed work that is not yet in production is potential waste. Without feedback from users you don’t know if the work was valuable. Any time that features “sit on the shelf” is time that a competitor could be using to take your customers. 

As soon as a feature, or set of features, is practical for users to exercise it should get deployed to production. CD teams aim for deploying to production about once a week. This keeps feedback loops short and tight, delivering value to customers sooner. It also makes it easier for your developers to make changes when there is a bug.

For some products this is hard or seemingly impossible. Teams should drive to the highest frequency possible for their situation.

## Does the team have daily stand-ups, with a goal of communicating change and unblocking issues?

Standups have become popular. They can add a lot of value to keep the team up to date. But they can also devolve into long, meandering status reports. Team members zone out, get distracted, and start to complain at retrospectives.

The most effective standups aren’t _just_ quick. They focus on new information. They review changes to the backlog or the business. They discuss important external items (e.g., interview schedules, upcoming vacations). And they stay short.

Standup is a vital opportunity to ask the entire team for help. Using the team’s collective knowledge is good way to unblock hard problems. Unblocking progress is an essential step for a productive day.

## Do people work on one project at a time?

Splitting a person across multiple projects is a distraction waiting to happen. Humans are poor at multi-tasking and at adjusting expectations based on task splitting. Letting team members work on many projects at once adds task-switching costs to a project. This is waste. It may speed one team up, but will slow down the others others.

Keeping people working on a single team at a time allows for focus. Focus leads to personal flow. Personal flow leads to team flow. And team flow leads to getting new business value to customers.

## Is it easy for developers to move between teams?

If your company is only one team right now, this will not apply. But any larger organization often splits into many, smaller teams. Keeping these teams siloed from each other can slow a product down. Or worse, it can slow the entire company down. Information and expertise stays locked up, reducing organization flexibility. This will slow down all the teams.

Allowing and encouraging team member rotation keeps the organization flexible. Information, knowledge, and techniques will propagate around the organization. When one team is behind, managers can reallocate people to catch them up. And all the while everyone will learn.

## Are teams composed of team members of diverse skill levels?

Show me a "10x Engineer" and I'll show you a single point of failure. What happens when that engineer feels burned out? Or if they have a new work opportunity or a life change? Or if they go on vacation? Single points of failure put entire businesses at risk.

The alternative is to have teams with diverse sets of experience levels. Have the senior people teach the junior people. That turns them into senior people. A team where everyone is learning all the time is a happy team. And happy, knowledgable people do great work. They mitigate risk. They also spot problems and fix them. They keep the product at high quality and shipping.

## Is asking for help, thus leading to knowledge acquisition, seen as a strength?

It is not enough to put junior and senior people together on teams. If the junior people do not feel welcome and safe to ask questions, then they will never gain knowledge. This is a risk to your business and your team will work more slowly in the long term.

Hire people who are good at acquiring knowledge. Put them on teams that will immerse them in knowledge and help them apply it. Give the "junior" folks the opportunity to try and fail. Celebrate asking questions. Encourage this behavior at all levels. These teams will grow and evolve over time into productive engines for your product.

## Is Quality an exploratory function (and not a gatekeeper to release)?

If your team is waiting for a QA team to tell you the product is ready, you have already lost. Features and bug fixes alike will sit in the queue to production. Everyone will be waiting for some absolute level of confidence that can never come. Meanwhile, your customers are waiting.

Moving the testing "left," closer to your developers, makes it cheaper to find and fix bugs. A good test suite tells you all you need to know about the functionality of the product. The Product Owner should be able to use the product to decide that work is ready.

"But what about bugs?" Instead of worrying about bugs, think about Exploratory QA. Have people who use the product and find behavior that the team did not expect or test for. Sometimes these are bugs where the product is broken. Sometimes these are new use cases the team missed. Learn more by reading Elisabeth Hendrickson's [Explore It!][explore_it].

Fixing this behavior is then new work for Product Manager to consider for the backlog. And like any story in the backlog, it starts with a test. And that test ensures a fix or feature that should never regress.

## Does the team meet weekly for Retrospectives to discuss team issues, leading to new work that improves team progress?

Problems, issues, and inefficiencies occur naturally on all teams. Things that worked when the team was small start to fail as the team grows. Technology choices don't pan out. Experiments in process change fail. And there are countless other scenarios. 

Some process, techniques, and behaviors are the opposite. They work very well, solving problems and making the team stronger. They should be recognized and further promoted.

A weekly [retrospective][retros] helps a team identify both problems and successes. 

Teams should celebrate every win. This makes team members feel good about their work. It cements good patterns for potential reuse.

Discussing problems also has many good effects on the team. Everyone gets on the same page. It vents frustration and surfaces anxiety. They can discussion potential solutions, building consensus on which ones to attempt. And they can track action items to implement them.

## Does the team complete their action items from Retrospectives?

It's not enough to talk about problems at a retrospective. The team has to suggest and agree on solutions. Then they need to track action items for their implementation. This means having the action items be clear. And each must have an owner and a due date. 

The team should review the open action items at the beginning of each retro. This serves as a reminder to the owners. They are helping the team fix a problem and making everyone more productive and happy. When an action item is complete, the team should celebrate!















---
title: Driven to Tests
date: 2021-02-02 21:53 UTC
tags:
  - agile 
keywords:
  - test driven development
  - tdd
  - software development
  - agile
  - continuous delivery
  - the cd test
series: the_cd_test
teaser: "TDD all the things!"
---

[jasmine_tutorial]: https://jasmine.github.io/tutorials/your_first_suite
[gphill]: https://twitter.com/geepawhill
[steering_premise]: https://threadreaderapp.com/thread/1335623514959777795.html
[kent_tddbe]: https://amzn.to/3sYihAu
[tdd_docs]: https://github.com/testdouble/contributing-tests/wiki
[lets_play]: http://www.jamesshore.com/v2/projects/lets-play-tdd
[failures]: https://blog.testdouble.com/posts/2014-01-25-the-failures-of-intro-to-tdd/
[aoc]: https://adventofcode.com/
[joel]: https://www.joelonsoftware.com/2000/08/09/the-joel-test-12-steps-to-better-code/
[joel_testers]: https://www.joelonsoftware.com/2000/04/30/top-five-wrong-reasons-you-dont-have-testers/
[dagmar]: https://medium.com/@dagmaraszkurat
[analogy]: https://medium.com/@dagmaraszkurat/how-i-explained-tdd-to-a-non-developer-friend-and-got-a-job-offer-over-tacos-b881895182c5
[andon]: https://en.wikipedia.org/wiki/Andon_(manufacturing)
[cdt]: https://dwf.bigpencil.net/the-continuous-delivery-test/

---

What are the signs that your software product team has experienced a big issue during development? Team velocity on new features has slowed down compared to earlier iterations. Tech debt is taking a long time to pay down. There's a bug in production - or worse, some sort of production outage. How does your team adapt to the situation?

No matter the cause, there is hard coding work ahead. You're worried about the speed and effectiveness of the team as they work. And you want to finish the task with no risk to the rest of the product.

Are your tests helpful in these stressful situations? Are they just a quality check before shipping? Or are they more integrated into your workflow? How can you increase velocity of new effort, bug fixing, and production fixes? And how can your test suite increase your confidence that recent work is correct while not exposing the rest of the product to risk? How can your test suite factor into Continuous Delivery?

If these questions sound interesting, can I interest you in test-driven development?

## Why Test First?

If you've never heard or seen test-driven development (TDD), it's exactly what it sounds like. Developers write a test, run it to watch it fail, then write the implementation code to get the test to pass. Repeat.[^1] Over time, these tests build into to a robust suite that provides your product with several benefits.

First is the impact on the amount of implementation code. By writing only the code to make tests pass, you have "just enough implementation" - less code and less complicated code. The codebase will not have unused code paths cuttering developers' editors and brains. Smaller, simpler code is easier to change in the future.

Yes, there will be a lot of code written in _tests_. Likely more than what you may have seen in a traditional automated test suite. But a passing TDD'd suite provides a higher sense of confidence than a typical test suite that the product will work as described. That confidence says that when the suite is passing, the team can ship that version of the product.

The tests also allow for change in the future while maintaining that confidence. If tests are passing "near" the work a developer is doing, but failing elsewhere, that is very useful information. You know not to ship until the entire test suite is green. You know about a less obvious code depencency. This is handy when writing new code or fixing bugs. It is amazing when refactoring.

Another benefit is useful documentation. Code documentation is often a separate effort, written after code is complete and shipped. Thus they tend to be, and stay, out of date. In a TDD project, the test suites have descriptive test names and clear implementation that tell the reader exactly how the code works. So the suite serves as documentation that is complete before any code is checked into version control. Test-suites-as-documentation are useful to teams immediately and they stay that way over time.

It's also possible to build a test suite that does even more. The [Jasmine tutorial][jasmine_tutorial] is end-user documentation that is also a test suite.[^2] This executable documentation has been part of Jasmine's continuous integration process for years. Jasmine doesn't ship without knowing that version works for anyone trying the tutorial.

## What About Continuous Delivery?

That all sounds great. How does TDD relate to CD?

If we go back to the metaphor of software development as manufacturing line (from [The CD Test][cdt]), then how does a test-driven suite help eliminate wasted effort and keep new software leaving the factory?

New tests reduce effort by forcing you to express how code should work before you've written it. This is often easier than imagining the code that will accomplish the given task. It's like a well-prepared grocery run. You leave home with a shopping list of ingredients grouped by the shops you need to visit to find them. Overall it is faster to do the work at hand.

This is also true for production issues. Once you know how to reproduce a bug, and you express that bug in a new test, it becomes straightforward to solve. The bug may still be complex to fix, but you will know where to start and when you're done. That test then stays in the suite as long as necessary, preventing regression.

Existing tests do even more to keep team momentum high. Revisiting old code, whether to fix bugs, refactor, or add new functionality, often has a high start-up cost. Reading old code to understand how it works, and why, takes more time the longer its been since you visited that code. But with a test-driven suite, that effort is lower. The how and why is documented right there. If your team is growing, new developers can get oriented just by reading the tests and following the implementation as needed, building concrete understanding of the system. The test suite becomes a knowlege refresher and accelerator for anyone on the team.

Going back to the CD analogy of the manufacturing line, a failing test is like an [Andon cord][andon]. If there is a failing test in your suite, the product should not ship. The team needs to write code to get all the tests passing again. And once all the tests are green, the manufacturing line can continue. A test suite that is passing and stays passing by default increases the overall confidence in the product.

A test-driven suite removes waste and inefficiencies from the software development process.  That leads to getting the team into a regular cadence of releases. And that gives you the benefits you want of Continuous Delivery.

## Start by Starting

Getting started is easy. It is as simple as writing code in the "test, fail, implement, pass" pattern. And playing with some refactoring along the way. _Where_ to start is harder.

If you're a book person, Kent Beck's [TDD By Example][kent_tddbe] is great. If you're a tutorial type, take a look at James Shore's [Let's Play][lets_play] casts. If you're a doc-crawler, try Test Double's [TDD wiki][tdd_docs].

If it feels too daunting to start with your product code base, try smaller, isolated problems. There are plenty of TDD exercizes out there (including the Test Double wiki above). Or you can pick up something like [Advent of Code][aoc], which has fun problems with test data and test answers. When comfortable with your new habits, take them back to your product development.

Justin says in his post [The Failures of "Intro to TDD"][failures], early experience will teach you the mechanics. But like any new craft you need lots of practice to get smooth and maximize the benefits. With time, experience, and research you will see TDD as more of a [design technique][steering_premise] (ps: follow [@GeePawHill][gphill]). Your tests and code will get even better.

## Isn't this Expensive?

In the [Joel Test][joel], he talks about having dedicated testers for a software team (he expands on this in a [later post][joel_testers]). He points out that not having testers in 2000 was a false economy. Finding issues, bugs, and feature gaps earlier in the development process was, and is still, less expensive than letting users find them for you.

Twenty years on, more and more testing is done with code. These tests are repeatable and essential to your product. Moving to test-driven development provides even more benefits. It is an investment in your product that results in lower costs in code design, higher team productivity, and fewer bugs for your customers. When it comes to Continuous Delivery, it can increase the momentum of the team, making it easier to ship early and often.

[^1]: If this is hard to imagine, [Dagmara Szkurłat's][dagmar] wrote a fun [real-world analogy][analogy] that is a good next stop.
[^2]: Thanks to [Michael Jackson](https://twitter.com/mjackson) who suggested this at the speakers' summit prior to the first Fluent Conf in 2012.





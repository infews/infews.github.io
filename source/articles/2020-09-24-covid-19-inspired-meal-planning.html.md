---
title: COVID-19-Inspired Meal Planning
date: 2020-09-24 00:00 UTC
tags: personal
---

[tweets]: https://twitter.com/dwfrank/status/1297643495897706496  

_Originally published as a [tweetstorm][tweets], I've expanding this one a little to make it more blog-worthy.
<br/><br/>&mdash;dwf_

---

[airtable]: https://www.airtable.com

We cook a lot at our house. We see cooking as a life skill and family activity. Being at home full time means we have a little bit more time to cook things well. Excellent!

We mix in some local favorite restaurants  - after all, we want them to be open post-Covid - but there are problems.

Meal planning is still meal planning. It's a bit of a chore. And it's very easy for someone to complain about repetition, or general lack of variety. What are we to do??

Welcome to _How we plan home meals: A software story._

## Problems to Solve

- What are we meals are eating this week? 
- Where should we take out from tonight?
- What recipes/restaurants do we like? And not like?
- How can we reduce repetition of meals/restaurants? (We like variety!)
- How can we minimize time spent menu planning or choosing a restaurant?

## Iteration 1: Spreadsheet

Duh.

In April I started a spreadsheet with one night per row, recording the date, the recipe, a link to the recipe, and if we liked it. If we brought in from a restaurant, we recorded the restaurant and a link to their menu.

This was just simple columns. I did some conditional formatting for restaurants vs. home-cooked. But nothing more than this.

When it was time to plan food for the week, I’d look over the sheet and pick 4 or 5 meals, prioritizing time since last cooked. I’d add 1 or 2 new recipes each week (from various sources online). 

Similar to recipes, when we decided we wanted to eat out, we’d look at the top of the sheet and look for restaurants we’d not visited in a while.

This solved most of these problems, but the planning time could have been better.

## Problems to Solve

- We were guessing on age since last cooked or last visited. This was not calculated.
- We were not counting the # of times cooked/visited.
- Scrolling up and down spreadsheet rows make it hard to see history.
- We discovered we would like to rate recipes and restaurants - we wanted to be able to choose not just based on most-recently-eaten  

## Iteration 2: AirTable

People had been suggesting AirTable for a while - the “NEVER use a spreadsheet to solve a software problem” crowd. 🙄

I definitely have built my share of spreadsheets that slowly acrete functions, and SQL-esque queries, and yes, even JavaScript. And I also hate myself. And the [sunk-cost fallacy][sunk]. 

Spreadsheets are great. Until they aren't. Which meant for iteration 2, I was going to try AirTable.

Here’s a rough sketch of the implementation. I tweaked it regularly to refine, but here’s where we are today.

_3 Tables_

- Restaurants: Name, Rating (1-3 stars), Notes, Count of times linked to Meal, Roll-up to get most-recent-visit
- Recipes: Name, Rating (1-3 stars), Web Link, Notes, Count of times linked to Meal, Roll-up to get most-recent-visit
- Meals: Date, link to Recipe (can be multiple), Link to Restaurant (can be multiple)

A Meal is something we ate on a specific date - really just a join, but AirTable calls them "links". Each day can have multiple meals and/or restaurants.

AirTable has _Views_, which are sort of like database views. But they are also the visual UI for working with a given table.

Meals has a Calendar view. This is amazingly cool for planning. Meals has a web form for recording what/where we ate when, complete with calendar widget. Restaurants & Recipes each has a web form for a new record.

Restaurants & Recipes each has a “Choice View” that sorts first by least-recent-meal (ascending "roll-up" by date), then by rating (descending star count).

All views hide any extra fields that don't help with the interaction at hand.

## Restaurants vs. Recipes 

We wanted to be able to tell when a meal was home-cooked or a restaurant visit. The idea was to be able to scan and see how much we were eating out.

So the "name" field on Restaurants is now a formula that prepends 🍱 to every restaurant name. It’s now very easy to scan the calendar. Unicode FTW!

## Multiple Meals in a Night

One night we couldn’t decide on a pizzeria. It was getting knock-down, drag out. So we ordered from both. Another night the kids wanted to make a Taco Bell run. So my wife and I decided to cook something we knew they hated. 

AirTable allows for multiple links to the same date. Meals now allow multiple-links records to Restaurants & Recipes. This gave us the bonus of being able to start tracking multiple side dishes on cooking nights.

## 🌮TACO TUESDAY

We decided to embrace Taco Tuesday! Every Tuesday we have Taco Night, which means wanting to track recipes that are taco-friendly. 

We added a Taco? yes/no "choice" field to recipes. And we added a Taco-specific view for when we wanted to pick this week's taco proteins. And since we'd learned about Unicode support, Taco recipe names are always prepended with 🌮, based on the field.

## A Restaurant Closed

Oops. COVID-19 claimed a business. We added a “Closed/Avoid” selection field that allows us to filter the closed places out of the Choice view. And we can use this if we have a lousy experience at a restaurant.

## Summing Up

Planning is now a simple pass over the Choice Views, looking at what we like but have not done recently. Pick 4-5, iterate. Option anxiety reduced. It's also easy to answer, "DIDN'T WE JUST HAVE THAT?" 

I will now take questions. 🤪


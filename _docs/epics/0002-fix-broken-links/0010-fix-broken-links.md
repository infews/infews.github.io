# Fix All Broken External Links

## Goal

Repair every external link failure found by `bundle exec rake html_proof` as of 2026-06-22.

## Acceptance Criteria

`bundle exec rake html_proof` passes with 0 failures.

## Checklist

- [ ] `source/articles/2020-09-24-covid-19-inspired-meal-planning.html.md` — `https://tables.area120.google.com/u/0/home` (Google Tables shut down, 404)
- [ ] `source/articles/2021-02-02-driven-to-tests.html.md` — `https://twitter.com/geepawhill` (404)
- [ ] `source/articles/2020-09-15-foo-fighters-1995.html.md` — `https://twitter.com/dwfrank/status/1305724884052443136` (dead tweet, 404)
- [ ] `source/articles/2017-05-18-goodbye-chris-cornell.html.md` — `https://twitter.com/dwfrank/status/865661929800335360` (dead tweet, 404)
- [ ] `source/articles/2017-04-26-goodbye-jonathan-demme.html.md` — `https://twitter.com/dwfrank/status/857378526428667904` (dead tweet, 404)
- [ ] `source/ip/index.html.haml` — `https://github.com/infews/rpi_explained` (deleted repo, 404)
- [ ] `source/ip/index.html.haml` — `https://github.com/infews/meals` (deleted repo, 404)
- [ ] `source/ip/index.html.haml` — `https://github.com/infews/derby` (deleted repo, 404)
- [ ] `source/articles/2024-05-03-iterators-1-3.html.md` — `https://railsconf.com` (timeout, status 0)
- [ ] `source/articles/2020-11-30-start-with-retrospectives.html.md` — `https://www.pagerduty.com/blog/4-step-agile-sailboat-retrospective/` (404)
- [ ] `source/articles/2024-03-06-why-do-we-miss-pivotal-tracker.html.md` — `https://pivotaltracker.com` (shut down, status 0)
- [ ] `source/articles/2024-03-06-why-do-we-miss-pivotal-tracker.html.md` — `https://www.pivotaltracker.com/marketing_assets/blog/2018/Customize_Your_Tracker_experience_1-36f1155592bc77922661a6671f47e43b0ef6a910518c8b1183c678ebd95b99c2.png` (shut down, status 0)
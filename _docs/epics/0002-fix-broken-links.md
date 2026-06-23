# Fix Broken Links in Published Articles

## Vision

Repair all external links across the site that return 404 or fail to connect. Each broken link is addressed on its own terms — some links can be replaced with live equivalents, others should be annotated or removed.

## Context

`bundle exec rake html_proof` found 12 failures across 8 pages. The failures fall into a few categories: dead tweets (Twitter/X policy changes and account cleanup), shut-down services (Google Tables, Pivotal Tracker), deleted GitHub repos, a dead blog post, and a timeout on a conference site.

## Scope

### In Scope

- All 12 failures identified by `html_proof` as of 2026-06-22
- Edits to the 8 affected source files

### Out of Scope

- Fixing internal links (none currently broken)
- Link rot monitoring / automation going forward
- Any content changes beyond the link fix itself

## Success Criteria

`bundle exec rake html_proof` passes with 0 failures.

## Dependencies

None.

## Open Questions

None.

## Resulting Stories

- [ ] [0010 — Fix all broken external links](0002-fix-broken-links/0010-fix-broken-links.md)
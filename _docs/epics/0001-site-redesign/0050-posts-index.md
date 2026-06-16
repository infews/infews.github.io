# Posts Index Redesign

## Narrative

As a reader browsing `/posts`, I want every entry to share the v26 typographic system used on the article page, so that the index reads consistently with the destination it links to.

The structure of `/posts` does not change — it remains a flat reverse-chronological list. Only typography and inter-entry separation are updated.

## Acceptance Criteria

```gherkin
Feature: v26 posts index

  Scenario: Entry typography
    Given the posts index rendered under v26
    Then each entry's title renders as IBM Plex Serif at medium weight
    And each entry's teaser renders as IBM Plex Serif italic, secondary color
    And each entry's date renders as Alegreya Sans SC small, tertiary color

  Scenario: Inter-entry separation
    Given the posts index rendered under v26
    Then a subtle top border rule appears between consecutive entries
    And whitespace alone is no longer the only separator

  Scenario: Order and filtering unchanged
    Given the posts index rendered under v26
    Then entries appear in reverse-chronological order matching "blog.articles"
    And articles tagged "private" are excluded (matching the existing config filter)
    And the entry count matches the current "/posts" page count for the same data
```

## EARS Specifications

- [x] `POSTS-UI-001`: The v26 stylesheet shall declare `a.title` on the posts index to use `var(--font-body)` at weight 500.
- [x] `POSTS-UI-002`: The v26 stylesheet shall declare `p.teaser` to use `var(--font-body)` italic in `var(--color-text-secondary)`.
- [x] `POSTS-UI-003`: The v26 stylesheet shall declare `p.date` to use `var(--font-heading)` at `var(--type-byline)` in `var(--color-text-tertiary)`.
- [x] `POSTS-UI-004`: The v26 stylesheet shall style the `hr` between entries as a `0.5px solid var(--color-border-tertiary)` rule.
- [x] `POSTS-UI-005`: When the posts index is built, the article count and reverse-chronological order shall match the current build.

## Implementation Plan

1. [x] `POSTS-UI-001–004` — Typography + border CSS (new `_posts.scss` partial)
2. [x] `POSTS-UI-005` — Entry count verification gate
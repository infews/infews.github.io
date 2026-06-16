# Home Page Redesign

## Narrative

As a first-time visitor to DWF's Journal, I want the home page to tell me who Davis is in a sentence or two and immediately show me what's new and what series are worth following, so that I can decide what to read without scrolling through promotional cards.

As a returning reader, I want to see the three most recent posts at a glance and the full list of active series in one place, so that I can pick up where I left off.

## Acceptance Criteria

```gherkin
Feature: v26 home page

  Scenario: Home page no longer has the legacy h1 block
    Given the home page rendered under v26
    Then there is no large "DWF's Journal" h1 in the page body
      # The brand is in the nav (story 0010), not the page body
    And there is no separate tagline block in the page body
    And the legacy three-card grid (Latest / CD Test / Obsidian Tips) is removed

  Scenario: Profile strip
    Given the home page rendered under v26
    Then a profile strip appears at the top of the main content
    And the strip contains the avatar (the existing /images/dwf.png with @2x srcset)
    And the strip contains an h1 "Hello, I'm Davis."
    And the strip contains a two-sentence bio condensed from the existing intro paragraph
    And the strip has a light background tint distinguishing it from the page body

  Scenario: Two-column main grid — recent posts on the left
    Given the home page rendered under v26
    Then a two-column grid appears below the profile strip
    And the left column is approximately 60% width
    And the left column lists the three most recent articles from "blog.articles"
    And each entry shows: title (IBM Plex Serif medium), teaser (italic secondary), date + read time (Alegreya Sans SC small tertiary)
    And entries are separated by top/bottom border rules
    And the left column ends with an "All Posts →" link to "/posts"

  Scenario: Two-column main grid — series on the right
    Given the home page rendered under v26
    Then the right column is approximately 40% width
    And the right column lists all series from "data/series.yml"
    And each entry shows: series title (Alegreya Sans SC bold), one-line description (IBM Plex Serif italic secondary)
    And the right column ends with an "All Series →" link to "/series"

  Scenario: Mobile layout
    Given the home page rendered at a narrow viewport
    Then the profile strip stacks vertically (avatar above name+bio, or name+bio above avatar — decided in Phase 3)
    And the two-column grid stacks to a single column
    And recent posts appear above series in the stacked order
```

## EARS Specifications

**Remove legacy elements**

- [x] `HOME-UI-001`: When the home page is rendered in v26, the page body shall not contain a top-level h1 with the site title.
- [x] `HOME-UI-002`: When the home page is rendered in v26, the page body shall not contain a `ul.cards` element.

**Profile strip**

- [x] `HOME-UI-003`: When the home page is rendered, a `.profile-strip` element shall appear as the first element in main content.
- [x] `HOME-UI-004`: The profile strip shall contain the avatar image (`/images/dwf.png` with `@2x` srcset).
- [x] `HOME-UI-005`: The profile strip shall contain an h1 "Hello, I'm Davis."
- [x] `HOME-UI-006`: The profile strip shall have a `var(--color-bg-secondary)` background tint.

**Recent posts**

- [x] `HOME-UI-007`: The left column shall list the three most recent articles from `blog.articles`.
- [x] `HOME-UI-008`: Each post entry shall display the article title, teaser, date, and read time.
- [x] `HOME-UI-009`: The left column shall end with an "All Posts →" link to `/posts`.

**Series**

- [x] `HOME-UI-010`: The right column shall list all series from `data/series.yml`.
- [x] `HOME-UI-011`: Each series entry shall display the series title and its teaser.
- [x] `HOME-UI-012`: The right column shall end with an "All Series →" link to `/series`.

**Mobile**

- [x] `HOME-UI-013`: When the viewport is narrower than the smallest breakpoint, the two-column grid shall stack to single column with posts above series.
- [x] `HOME-UI-014`: When the viewport is narrower than the smallest breakpoint, the profile strip shall stack vertically with avatar above name and bio.

## Implementation Plan

1. [x] `HOME-UI-001–002` — Remove legacy elements (HAML)
2. [x] `HOME-UI-003–006` — Profile strip (HAML + CSS)
3. [x] `HOME-UI-007–009` — Recent posts column (HAML + CSS)
4. [x] `HOME-UI-010–012` — Series column (HAML + CSS)
5. [x] `HOME-UI-013–014` — Mobile stacking (CSS)
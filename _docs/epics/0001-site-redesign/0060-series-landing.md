# Series Landing Page

## Narrative

As a reader exploring DWF's Journal, I want a single page at `/series` that lists every active series with a short description, so that I can pick a series to follow without hunting through the nav or guessing slugs.

As the author, I want this page to be data-driven from `data/series.yml`, so that adding or describing a new series requires editing one file — no template changes.

## Acceptance Criteria

```gherkin
Feature: Series landing page

  Scenario: Route exists
    Given the site is built
    Then "/series" resolves to a rendered HTML page
    And the page is included in the sitemap

  Scenario: Lists every series from data
    Given "data/series.yml" contains the active series
    When "/series" is rendered under v26
    Then every series in the data file appears as an entry on the page
    And each entry shows the series title (Alegreya Sans SC bold)
    And each entry shows a one-line description (IBM Plex Serif italic secondary)
    And each entry's title links to the existing series-detail page (e.g., "/series/the-cd-test")

  Scenario: Description field exists in series data
    Given "data/series.yml"
    Then every series entry has a "description" field
      # If the field does not exist today, add it as part of this story.
      # Confirm and decide on field name during Phase 3.

  Scenario: Nav link works
    Given any page rendered under v26
    Then the nav "Series" link points to "/series"
    And clicking it loads the series landing page
```

## Phase 3 decisions

- **Description field:** Uses existing `teaser` field from `data/series.yml` — no new field needed.
- **Route:** `source/series.html.haml` → `build/series/index.html` → accessible at `/series`. Coexists with individual series detail pages at `/series/{slug}`.
- **CSS:** Reuses `.series-list` and `.series-entry` classes already defined in `_home_v26.scss`.

## EARS Specifications

- [x] `SERIES-PROC-001`: When the site is built, `build/series/index.html` shall exist.
- [x] `SERIES-UI-001`: The `/series` page shall list all four series from `data/series.yml`.
- [x] `SERIES-UI-002`: Each entry shall display the series title as a link to `/series/{slug}`.
- [x] `SERIES-UI-003`: Each entry shall display the series `teaser` field as its one-line description.
- [x] `SERIES-UI-004`: The `/series` page shall appear in `build/sitemap.xml`.

## Implementation Plan

1. [x] `SERIES-PROC-001` — Create `source/series.html.haml`
2. [x] `SERIES-UI-001–003` — Template iterates `data.series`, reuses `.series-list` CSS
3. [x] `SERIES-UI-004` — Verify sitemap inclusion
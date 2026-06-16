# Cutover

## Narrative

As the developer, I want a single deliberate change to flip `components/_stylesheets.haml` from `v23.css.scss` to `v26.css.scss` and then verify the entire site renders correctly at desktop and mobile widths under both light and dark modes, so that v26 ships in one well-understood commit that is trivially reversible.

This story is symbolic but real. The chrome and surface stories built v26 in place without affecting the public site. This story is the moment behavior changes.

## Acceptance Criteria

```gherkin
Feature: v26 cutover

  Scenario: Stylesheet include flipped
    Given the layout previously loaded "v23.css.scss"
    When this story is complete
    Then "source/components/_stylesheets.haml" loads "v26.css.scss"
    And it no longer loads "v23.css.scss"
    And "v23.css.scss" remains on disk (deletion is a separate decision)

  Scenario: All six in-scope surfaces render correctly
    Given the cutover commit is built
    Then "/" renders the v26 home page (profile strip + two-column grid)
    And any article page renders the v26 article layout (new header order, optional hero, pill tags, prev/next, restyled footnotes)
    And "/posts" renders with v26 typography
    And "/series" renders the new landing page
    And the nav and footer chrome appear on every "layout.haml" page

  Scenario: Out-of-scope pages do not crash, even if transitional
    Given the cutover commit is built
    Then "/ip", "/whisky", "/notion", "/all_tags", "/tags/ruby", "/404", "/about_me" all render
    And no page produces an SCSS build error
    And no page has obviously broken layout (overflowing containers, illegible text, missing nav/footer)
    And these pages may inherit new fonts/colors and look transitional — acceptable per epic scope

  Scenario: /resume is unaffected
    Given the cutover commit is built
    Then "/resume/dwfrank" and "/resume/dwfrank_full" render with the existing resume layout and stylesheet
    And v26 fonts and chrome do NOT apply to these pages

  Scenario: Dark mode works site-wide
    Given an OS reporting "prefers-color-scheme: dark"
    When any v26 page is loaded
    Then color tokens resolve to their dark-mode values
    And contrast remains readable on all text, tags, pull quotes, and footnotes

  Scenario: Mobile layout works site-wide
    Given a viewport narrower than the smallest breakpoint
    When any v26 page is loaded
    Then there is no horizontal scroll
    And every layout collapses to single-column as designed in its source story

  Scenario: Rollback is trivial
    Given the cutover commit
    Then reverting the single change to "components/_stylesheets.haml" restores v23 rendering
    And no other file needs to be reverted for rollback to be clean
```

## Pre-Phase-3 Notes

**`home_page_ld` hardcoding:** `helpers/linking_data_helpers.rb` lines 103–108 hardcode the CD Test and Obsidian series slugs for JSON-LD on the home page — a leftover from the old three-card grid. Update to iterate `data.series` dynamically, or remove if the JSON-LD for series panels is no longer needed.

**Footnote number rendering:** `_article.scss` uses `li::before { content: counter(list-item) }` for footnote numbers. Verify in browser that this doesn't double the number Kramdown already renders in the `li` content. If doubled, replace with `list-style-type: none` and style Kramdown's existing anchor instead.

##

**Token naming:** `v26`'s `_tokens.scss` currently uses a new `--color-text-primary` naming system that does not match HolidayCSS's variable names. Before cutover, these token names must be reconciled with HolidayCSS (either by aliasing, renaming, or removing HolidayCSS). This work is deferred to this story.

## EARS Specifications

**Pre-flip fixes**

- [x] `CUT-PROC-001`: The v26 stylesheet shall include a `_base.scss` declaring `html { font-size: 16px }` and `body` base styles (font, color, background, antialiasing) using v26 tokens.
- [x] `CUT-PROC-002`: `helpers/linking_data_helpers.rb` `home_page_ld` shall not hardcode series slugs.

**The flip**

- [x] `CUT-PROC-003`: `components/_stylesheets.haml` shall load `v26.css` and not load `v23.css`.
- [x] `CUT-PROC-004`: When the project is built after the flip, it shall complete with no errors.
- [x] `CUT-PROC-005`: `source/stylesheets/v23.css.scss` shall still exist on disk after the flip.

**Visual verifications**

- [x] `CUT-UI-001`: Nav renders brand/tagline/links correctly at desktop and mobile widths.
- [x] `CUT-UI-002`: Footer renders three-column chrome at desktop, stacked at mobile. *(Fixed: footer items now center when stacked on mobile.)*
- [x] `CUT-UI-003`: Home page renders profile strip + two-column grid (posts left, series right).
- [x] `CUT-UI-004`: Article page renders new header order, optional hero below header, pill tags, "Notes" footnotes, prev/next nav.
- [x] `CUT-UI-005`: Footnote numbers are not doubled. *(Fixed: replaced `::before counter()` with `::marker` approach.)*
- [x] `CUT-UI-006`: Posts index renders with v26 typography and border separators.
- [x] `CUT-UI-007`: Series landing page renders list of series. *(Fixed: `.series-list` CSS extracted from `.home-grid` scope to apply site-wide.)*
- [x] `CUT-UI-008`: Dark mode renders correctly (readable contrast on all surfaces).
- [x] `CUT-UI-009`: Mobile — no horizontal scroll on any page.
- [x] `CUT-UI-010`: Resume pages (`/resume/dwfrank`, `/resume/dwfrank_full`) unaffected by v26.

## Implementation Plan

1. [x] `CUT-PROC-001` — Add `_base.scss` to v26
2. [x] `CUT-PROC-002` — Fix `home_page_ld`
3. [x] `CUT-PROC-003–005` — Flip stylesheet, verify build, confirm v23 still on disk
4. [x] `CUT-UI-001–010` — `middleman serve` browser verification
# Chrome Foundation

## Narrative

As the developer of `dwf.bigpencil.net`, I want a `v26.css.scss` skeleton with fonts loaded, design tokens defined (including dark-mode overrides), and the new nav and footer chrome built, so that every subsequent surface story (article, home, posts, series) has the typographic and structural foundation it needs without re-doing the basics.

This story is built but not cutover — `layout.haml` continues to include `v23.css.scss`. v26 is exercised only via a manual toggle or preview path during development. The public site is unchanged until story 0070 (Cutover).

## Acceptance Criteria

```gherkin
Feature: v26 chrome foundation

  Scenario: v26 stylesheet exists and compiles
    Given the project is built
    Then "source/stylesheets/v26.css.scss" exists
    And the build succeeds with no SCSS errors
    And "source/stylesheets/v23.css.scss" is unchanged

  Scenario: Google Fonts loaded
    Given a page rendered with the v26 stylesheet
    Then the document head includes a single Google Fonts link
    And the link requests Alegreya Sans SC (400, 700; italic 400)
    And the link requests IBM Plex Serif (400, 500; italic 400)
    And the link requests IBM Plex Mono (400)

  Scenario: Design tokens defined as CSS custom properties
    Given the v26 stylesheet
    Then color, type-scale, and spacing tokens are declared as CSS custom properties on ":root"
    And a "@media (prefers-color-scheme: dark)" block overrides color tokens

  Scenario: Nav renders the flattened three-link structure
    Given a page rendered with v26
    Then the nav shows brand "DWF's Journal" with tagline "A computer is just a BIG. PENCIL." on the left
    And the nav shows three top-level links on the right: Posts, Series, About
    And no dropdown menu is rendered
    And the nav has a 0.5px bottom border rule

  Scenario: Footer renders three-column chrome
    Given a page rendered with v26
    Then the footer has a top border rule
    And the footer's left column shows "DWF's Journal" in Alegreya Sans SC bold
    And the footer's center column shows social links: Threads, Mastodon, Bluesky, GitHub, LinkedIn
    And the footer's right column shows "© {year} Davis W. Frank"

  Scenario: Mobile-first responsive baseline
    Given a viewport narrower than the smallest breakpoint
    Then the nav, footer, and body content render in single-column layout without horizontal scroll
    And every media query in v26 uses "min-width" (no "max-width" queries)

  Scenario: v23 still in use publicly
    Given the production layout
    Then "components/_stylesheets.haml" still includes v23
    And no public page renders with v26 unless explicitly toggled
```

## EARS Specifications

**Build & file integrity**

- [ ] `CHROME-PROC-001`: When the project is built, the system shall compile `source/stylesheets/v26.css.scss` without SCSS errors.
- [x] `CHROME-PROC-002`: The system shall not modify `source/stylesheets/v23.css.scss` during this story.
- [x] `CHROME-PROC-003`: After this story, `components/_stylesheets.haml` shall still load v23 (not v26).

**Fonts**

- [x] `CHROME-UI-001`: When a page is rendered with v26, the document head shall include exactly one Google Fonts `<link>` requesting Alegreya Sans SC (400, 700; italic 400), IBM Plex Serif (400, 500; italic 400), and IBM Plex Mono (400).

**Design tokens**

- [x] `CHROME-UI-002`: The v26 stylesheet shall declare color tokens as CSS custom properties on `:root`.
- [x] `CHROME-UI-003`: The v26 stylesheet shall declare type-scale tokens (nav, h1, h2, h3, body, byline, footnote, tag) as CSS custom properties on `:root`.
- [x] `CHROME-UI-004`: The v26 stylesheet shall declare chrome spacing tokens (nav/footer padding, content max-width) as CSS custom properties on `:root`.
- [x] `CHROME-UI-005`: When `prefers-color-scheme: dark` matches, the system shall override the color tokens on `:root` with their dark-mode values.

**Nav**

- [x] `CHROME-NAV-001`: When a page is rendered with v26, the nav shall display brand "DWF's Journal" with tagline "A computer is just a BIG. PENCIL." in the left region.
- [x] `CHROME-NAV-002`: When a page is rendered with v26, the nav shall display exactly three right-region links: Posts (→ `/posts`), Series (→ `/series`), About (→ `/about_me`).
- [x] `CHROME-NAV-003`: The v26 nav shall not render a dropdown menu.
- [x] `CHROME-NAV-004`: The v26 nav shall have a 0.5px bottom border rule.

**Footer**

- [x] `CHROME-UI-006`: When a page is rendered with v26, the footer shall display a top border rule.
- [x] `CHROME-UI-007`: The v26 footer shall display the brand "DWF's Journal" in its left column.
- [x] `CHROME-UI-008`: The v26 footer shall display these social links in its center column, sourced from `config.rb`: Threads, Mastodon, Bluesky, GitHub, LinkedIn.
- [x] `CHROME-UI-009`: The v26 footer shall display "© {current year} {site_author}" in its right column.

**Responsive**

- [x] `CHROME-UI-010`: When the viewport is narrower than the smallest breakpoint, the v26 nav, footer, and body shall render in a single-column layout with no horizontal scroll.
- [x] `CHROME-UI-011`: Every media query in v26 stylesheets shall use `min-width` (no `max-width` queries).

## Implementation Plan

1. [x] `CHROME-PROC-001` — Compile v26 skeleton
2. [x] `CHROME-UI-001` — Google Fonts link
3. [x] `CHROME-UI-002` — Color tokens
4. [x] `CHROME-UI-005` — Dark-mode color override
5. [x] `CHROME-UI-003` — Type-scale tokens
6. [x] `CHROME-UI-004` — Spacing tokens
7. [x] `CHROME-NAV-001` — Nav brand + tagline
8. [x] `CHROME-NAV-002` — Nav 3 top-level links
9. [x] `CHROME-NAV-003` — Nav no dropdown
10. [x] `CHROME-NAV-004` — Nav bottom border
11. [x] `CHROME-UI-006` — Footer top border
12. [x] `CHROME-UI-007` — Footer brand left
13. [x] `CHROME-UI-008` — Footer socials center
14. [x] `CHROME-UI-009` — Footer copyright right
15. [x] `CHROME-UI-010` — Mobile-first single-column
16. [x] `CHROME-UI-011` — All media queries min-width
17. [x] `CHROME-PROC-002` + `CHROME-PROC-003` — Final gate: verify v23 + `_stylesheets.haml` untouched

## Test Approach (per project test strategy)

Per the project's test strategy (TDD new Ruby helpers; CSS/HAML uses source assertions + manual browser confirmation): no new Ruby helpers in this story → no RSpec specs. Each EARS spec's gate is either an automated source/build assertion or a manual browser confirmation:

- **Build assertions** (PROC-001): `bundle exec middleman build` exits 0, expected output file exists
- **Source assertions** (UI-002 through UI-005, UI-011, PROC-002/003): grep / file-inspection on `source/stylesheets/v26.css.scss` and adjacent files
- **Rendered-HTML assertions** (UI-001): grep on built HTML in `build/`
- **Visual confirmation** (NAV-001 through NAV-004, UI-006 through UI-010): developer eyeballs `bundle exec middleman serve` at desktop + mobile widths, light + dark

Every step still gates on explicit developer approval.
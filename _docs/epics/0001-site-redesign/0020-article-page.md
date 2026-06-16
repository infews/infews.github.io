# Article Page Redesign

## Narrative

As a reader of DWF's Journal, I want the article page to lead with clear context (series, title, subtitle, byline) before any image, present body copy in a warm serif at a comfortable reading rhythm, surface tags as scannable pills, give footnotes a quiet but distinct treatment, and offer prev/next navigation at the end, so that articles read more like editorial pieces and less like a generic blog template.

As the author, I want the existing frontmatter (`teaser`, `series`, `tags`, optional `unsplash`) and Kramdown footnote syntax (`[^1]`) to keep working unchanged, so that no existing article needs to be re-edited for v26.

## Acceptance Criteria

```gherkin
Feature: v26 article page

  Scenario: Article header order
    Given an article with frontmatter "series: the-cd-test", "title: ...", "teaser: ..."
    When the page is rendered under v26
    Then the header renders in this order from top to bottom:
      | series label (small-caps Alegreya Sans SC, tertiary color) |
      | h1 title (Alegreya Sans SC bold)                            |
      | subtitle from the "teaser" field (IBM Plex Serif italic)    |
      | byline "Davis W. Frank · DD Month YYYY · N min read"        |

  Scenario: Byline pulls from existing sources
    Given an article
    Then the byline author name comes from "config[:site_author]"
    And the byline date comes from "current_article.date" formatted "DD Month YYYY"
    And the byline read time comes from "reading_time_for current_article.body"

  Scenario: Article with no "unsplash" frontmatter
    Given an article whose frontmatter does not contain "unsplash"
    When the page is rendered
    Then no hero image is rendered
    And no placeholder is shown
    And the body copy starts immediately after the header

  Scenario: Article with "unsplash" frontmatter
    Given an article whose frontmatter contains "unsplash.url" and "unsplash.title"
    When the page is rendered
    Then a hero image is rendered between the header and the body
    And the image has a max-height of approximately 220px
    And the image uses "object-fit: cover"

  Scenario: Body typography
    Given an article rendered in v26
    Then body paragraphs use IBM Plex Serif at approximately 15–15.5px with line-height 1.85
    And h2 elements have a 0.5px bottom border rule
    And h3 elements have no border, are slightly smaller than h2, and are letter-spaced

  Scenario: Tags render as pills
    Given an article with tags "ruby, rails, hiring"
    When the page is rendered
    Then each tag is rendered as a pill with rounded corners
    And the series name is NOT rendered inside the tag row
    And the existing "tag_sentence_for" helper output is decomposed (template iterates tags directly)

  Scenario: Footnotes section
    Given an article using Kramdown footnotes ("[^1]" in body, "[^1]: ..." at end)
    When the page is rendered
    Then the in-body reference is a superscript in IBM Plex Mono 10px, tertiary, with no underline
    And the bottom-of-page section is labeled "Notes" (Alegreya Sans SC small)
    And the section has a top border rule
    And each footnote number renders in IBM Plex Mono 10px, fixed-width column
    And each footnote body renders in IBM Plex Serif 12.5px, secondary color

  Scenario: Prev/Next navigation
    Given an article that has both a previous and a next article in the blog
    When the page is rendered
    Then a two-column block appears below the tags
    And the left column shows "← Previous" label and the previous article's title
    And the right column shows "Next →" label and the next article's title, right-aligned

  Scenario: Boundary articles
    Given the oldest article in the blog
    Then the prev column is empty or omitted, the next column renders normally
    Given the newest article in the blog
    Then the next column is empty or omitted, the prev column renders normally
```

## EARS Specifications

**Body typography**

- [x] `ART-UI-001`: When an article is rendered in v26, body copy shall use `var(--font-body)` at `var(--type-body)` with `line-height: var(--leading-body)`.
- [x] `ART-UI-002`: When an article is rendered in v26, h2 elements shall have a `0.5px solid` bottom border rule.
- [x] `ART-UI-003`: When an article is rendered in v26, h3 elements shall have no border, smaller font size than h2, and letter-spacing applied.

**Article header order**

- [x] `ART-UI-004`: When an article with `series` frontmatter is rendered, the system shall display a series label element above the h1.
- [x] `ART-UI-005`: When an article with a `teaser` frontmatter field is rendered, the system shall display it as a subtitle element below the h1.
- [x] `ART-UI-006`: When an article is rendered, the system shall display a byline element below the subtitle containing author name, date formatted as `DD Month YYYY`, and read time.

**Hero image**

- [x] `ART-UI-007`: If an article does not have `unsplash` frontmatter, the system shall not render a hero image element.
- [x] `ART-UI-008`: When an article with `unsplash` frontmatter is rendered, the system shall display the hero image below the article header with `max-height: 220px` and `object-fit: cover`.

**Tag pills**

- [x] `ART-UI-009`: When an article with tags is rendered, the system shall render each tag as a separate pill element.
- [x] `ART-UI-010`: When an article with a `series` frontmatter field is rendered, the system shall not render the series name in the tag pill row.

**Footnotes**

- [x] `ART-UI-011`: When an article with Kramdown footnotes is rendered, in-body superscript references shall use `var(--font-mono)` with no underline decoration.
- [x] `ART-UI-012`: When an article with footnotes is rendered, the footnotes section shall have a top border rule.
- [x] `ART-UI-013`: When an article with footnotes is rendered, the section shall be visually labeled "Notes" via a CSS-generated `::before` pseudo-element in `var(--font-heading)`.
- [x] `ART-UI-014`: When an article with footnotes is rendered, footnote numbers shall render in `var(--font-mono)` in a fixed-width column.
- [x] `ART-UI-015`: When an article with footnotes is rendered, footnote body text shall render in `var(--font-body)` at `var(--type-footnote-text)` in `var(--color-text-secondary)`.

**Prev/Next navigation**

- [x] `ART-NAV-001`: When an article has a previous article, the system shall display the previous article's title with a "← Previous" label.
- [x] `ART-NAV-002`: When an article has a next article, the system shall display the next article's title with a "Next →" label, right-aligned.
- [x] `ART-NAV-003`: If an article has no previous article, the system shall omit the previous column.
- [x] `ART-NAV-004`: If an article has no next article, the system shall omit the next column.

## Implementation Plan

1. [x] `ART-UI-001–003` — Body typography (CSS only)
2. [x] `ART-UI-004–006` — Article header order (HAML + CSS)
3. [x] `ART-UI-007–008` — Hero image (HAML)
4. [x] `ART-UI-009–010` — Tag pills (HAML + CSS)
5. [x] `ART-UI-011–015` — Footnotes (CSS only)
6. [x] `ART-NAV-001–004` — Prev/Next (HAML + CSS)

## Notes

- Sharing component (`_sharing.haml`) is kept in its current positions (article header and bottom). Not in scope for this story.
- `tag_sentence_for` helper output is decomposed in the template — tags are iterated directly. The helper itself is not changed.
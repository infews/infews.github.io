# Pull-Quote Helper

## Narrative

As the author, I want a way to mark a sentence as a pull quote in markdown source distinct from a default `>` blockquote, so that editorial emphasis (e.g., "the only thing harder than hiring is firing") can be rendered prominently without retroactively changing how every existing `>` blockquote in the archive renders.

As a reader, I want pull quotes to read as a deliberate editorial accent — italicized, set apart by a left border, in a secondary color — distinct from a generic indented blockquote.

## Acceptance Criteria

```gherkin
Feature: Pull-quote authoring and rendering

  Scenario: Pull quote authored via the new mechanism
    Given an article author marks a paragraph as a pull quote using the agreed mechanism
      # mechanism TBD in Phase 3: candidates include a custom kramdown class
      # ({:.pullquote}), a Middleman helper called from a haml partial,
      # or a markdown-it style fenced block. To be decided.
    When the page is rendered under v26
    Then the paragraph is wrapped in an element with class "pullquote"
    And the rendered pull quote has a 2px left border (primary color)
    And the text is IBM Plex Serif italic at approximately 16.5px
    And the text color is the secondary token

  Scenario: Default markdown blockquote still renders, distinctly
    Given an article that uses a markdown ">" blockquote (not a pull quote)
    When the page is rendered under v26
    Then the blockquote renders as a standard blockquote
    And it does NOT have the left-border pull-quote treatment
    And it is visually distinguishable from a pull quote

  Scenario: Existing articles unaffected
    Given the ~60 existing articles in "source/articles/"
    When the site is built under v26
    Then no existing ">" blockquote is rendered as a pull quote
    And no existing article requires re-editing to render correctly
```

## Authoring Mechanism (decided Phase 3)

Raw HTML in markdown: `<blockquote class="pullquote">text</blockquote>`

Rationale: `input: "GFM"` in `config.rb` disables Kramdown IAL syntax (`{:.class}`), and `.md` article files cannot call HAML helpers. GFM passes raw HTML through unchanged. Existing articles use native `> text` which renders as unclassed `<blockquote>` — no conflict.

## EARS Specifications

- [x] `PQUOTE-PROC-001`: When the site is built, no existing article in `source/articles/` shall contain `class="pullquote"` markup.
- [x] `PQUOTE-UI-001`: The v26 stylesheet shall declare `.pullquote` rules with a 2px left border in `var(--color-border-primary)`, `var(--font-body)` italic, `var(--type-subtitle)` size, and `var(--color-text-secondary)` color.
- [x] `PQUOTE-UI-002`: The v26 stylesheet shall declare `blockquote` (without `.pullquote`) rules that are visually distinct from `.pullquote` and do not include the left-border treatment.

## Implementation Plan

1. [x] `PQUOTE-PROC-001` — Verify no existing articles affected
2. [x] `PQUOTE-UI-001` — `.pullquote` CSS
3. [x] `PQUOTE-UI-002` — Default `blockquote` CSS
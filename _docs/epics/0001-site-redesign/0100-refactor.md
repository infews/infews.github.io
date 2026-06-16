# v26 CSS/HAML Refactor

## Narrative

As the developer, I want to clean up the v26 stylesheets and templates after the initial ship, so that the codebase is consistent, free of dead code, and easy to maintain going forward.

## Changes

### Bugs

- [x] `about_me.html.haml`: `mail-to:` → `mailto:` (broken email link)
- [x] Mobile nav hamburger menu is broken — HolidayCSS hamburger requires `nav > ul > li` structure; v26 nav uses `.brand` + `.nav-links` divs with no `<ul>`. Fix by restructuring `layout.haml` nav to conform to HolidayCSS's expected markup while keeping v26 brand/tagline/token styling. The mobile stacking workaround (`flex-direction: column` at default) is not sufficient — v23 had a working tap-to-reveal hamburger.

### Semantic heading hierarchy

- [ ] **Home page**: add visible `h2` section labels "Recent Posts" and "Series" above each column; make item titles `h3`
- [ ] **Series landing page (`/series`)**: wrap each series title in `h2`
- [ ] **`_article_teaser.haml` consolidation:**
  - Add read time (`reading_time_for(article.body)`) to the partial alongside the date
  - Accept a `heading_level` local variable (default `'h2'`) for the title tag
  - Remove the custom `.post-entry` markup from `index.html.haml` — use `component "article_teaser"` instead, passing `heading_level: 'h3'`
  - Posts index and series detail pages pass `heading_level: 'h2'` (or rely on default)
  - Unify CSS classes: home page adopts `.title`/`.teaser`/`.date` from `_posts.scss`; remove `.post-title`/`.post-teaser`/`.post-meta` from `_home_v26.scss`

### Token naming — align with HolidayCSS

Rename v26 tokens that overlap with HolidayCSS's active aliases so the two systems share one variable namespace. HolidayCSS is kept for future use (tables, forms, etc.) and will automatically adopt our design values.

Rename in `_tokens.scss` and update every reference across all SCSS files:

| Old v26 name | HolidayCSS name |
|---|---|
| `--color-bg-primary` | `--background-color` |
| `--color-bg-secondary` | `--highlighted-background-color` |
| `--color-text-primary` | `--text-color` |
| `--color-border-secondary` | `--border-color` |
| `--color-link` | `--link-color` |
| `--color-link-visited` | `--link-visited-color` |
| `--color-link-hover` | `--link-hover-color` |

Keep our own names for tokens with no HolidayCSS equivalent:
- `--color-text-secondary`, `--color-text-tertiary`
- `--color-border-primary`, `--color-border-tertiary`
- All font, type scale, and spacing tokens

- [ ] Rename the 7 overlapping tokens in `_tokens.scss`
- [ ] Update all references in `_base.scss`, `_nav.scss`, `_footer.scss`, `_article.scss`, `_home_v26.scss`, `_posts.scss`, `_about_v26.scss`, `_resume.scss`
- [ ] Verify dark mode still works (HolidayCSS and our `@media (prefers-color-scheme: dark)` both override the same variable names)
- [ ] Build and visual review

### High value

- [ ] Rename `_home_v26.scss` → `_home.scss` and `_about_v26.scss` → `_about.scss` (v23 is gone, version suffix is noise)
- [ ] Merge the two `article {}` blocks in `_article.scss` into one
- [ ] Remove redundant `color: var(--color-text-primary)` on `article` (inherited from `body` in `_base.scss`)
- [ ] Remove redundant `font-family: var(--font-heading)` on `article h1, h2, h3` (covered by `_base.scss` global heading rule)
- [ ] `_resume.scss` border colors: `#dfdfdf` → `var(--color-border-tertiary)`

### Dependencies

- [ ] Upgrade HolidayCSS from `0.11.2` to `0.11.6` in `source/components/_stylesheets.haml`

### Minor

- [ ] `_tokens.scss`: delete unused `--space-content-padding` and `--max-width-wide`
- [ ] `_article.scss`: remove `.byline { gap: 0 }` no-op
- [ ] `_nav.scss` tagline: `0.875rem` hardcoded and actually smaller than `--type-nav-link` (0.9375rem) — clarify or add token
- [ ] `_resume.scss`: `flex-flow` shorthand → separate `flex-direction`/`flex-wrap` for consistency
- [ ] `_print.scss`: `color: black` → `color: #000`

### Noted, not changing

- [ ] `--type-byline`, `--type-series-label`, `--type-tag`, `--type-footer-link` all equal `0.6875rem` — add comment noting intentional semantic separation
- [ ] `wrapper_classes_for` emits `.home`/`.about` classes with no v26 CSS rules — leftover from v23, harmless
- [ ] `.more` styling coupled to `.home-grid` scope — noted for future `/series` work
- [ ] Resume layout intentionally duplicates chrome — add comment noting deliberate divergence

## Implementation Plan

_Work through section by section: semantic headings → token naming → high value → deps → minor → doc notes._

### Semantic Heading Hierarchy

- [x] `RFCT-UI-001` — Home page renders an `h2` with text "Recent Posts" above the recent posts list
- [x] `RFCT-UI-002` — Home page renders an `h2` with text "Series" above the series list
- [x] `RFCT-UI-003` — Series landing page (`/series`) wraps each series title anchor in an `h2`
- [x] `RFCT-UI-004` — `_article_teaser` partial changes hardcoded `h3` to `h2` (posts index and series detail get correct `h1 → h2` hierarchy)
- [x] `RFCT-UI-005` — `_article_teaser` partial renders article read time alongside the date via `reading_time_for(article.body)`
- [x] `RFCT-UI-006` — Home page custom `.post-entry` markup updated in-place: `.post-title` → `.title`, `.post-teaser` → `.teaser`, `.post-meta`/`.post-date` → `.date`; add read time; wrap title in `h3`
- [x] `RFCT-CSS-001` — Home page `.post-entry` block in `_home_v26.scss` updated to style `.title`, `.teaser`, `.date` with equivalent visual treatment
- [x] `RFCT-CSS-002` — `.post-title`, `.post-teaser`, `.post-meta` rules removed from `_home_v26.scss`

### Token Naming — Align with HolidayCSS

- [x] `RFCT-TOK-001` — Rename `--color-bg-primary` → `--background-color` in `_tokens.scss` and every SCSS reference
- [x] `RFCT-TOK-002` — Rename `--color-bg-secondary` → `--highlighted-background-color` in `_tokens.scss` and every SCSS reference
- [x] `RFCT-TOK-003` — Rename `--color-text-primary` → `--text-color` in `_tokens.scss` and every SCSS reference
- [x] `RFCT-TOK-004` — Rename `--color-border-secondary` → `--border-color` in `_tokens.scss` and every SCSS reference
- [x] `RFCT-TOK-005` — Rename `--color-link` → `--link-color` in `_tokens.scss` and every SCSS reference
- [x] `RFCT-TOK-006` — Rename `--color-link-visited` → `--link-visited-color` in `_tokens.scss` and every SCSS reference
- [x] `RFCT-TOK-007` — Rename `--color-link-hover` → `--link-hover-color` in `_tokens.scss` and every SCSS reference
- [x] `RFCT-TOK-008` — Dark mode renders correctly after rename (both light `:root` and `@media (prefers-color-scheme: dark)` blocks use new names)

### High Value

- [x] `RFCT-HV-001` — `_home_v26.scss` → `_home.scss` and `_about_v26.scss` → `_about.scss`; `@import` in `v26.css.scss` updated
- [x] `RFCT-HV-002` — The two `article {}` blocks in `_article.scss` are merged into one
- [x] `RFCT-HV-003` — Redundant `color: var(--text-color)` on `article` removed (inherited from `body` in `_base.scss`)
- [x] `RFCT-HV-004` — Redundant `font-family: var(--font-heading)` on `article h2` and `article h3` removed (covered by `_base.scss` global heading rule)
- [x] `RFCT-HV-005` — `#dfdfdf` border colors in `_resume.scss` replaced with `var(--color-border-tertiary)`

### Dependencies

- [x] `RFCT-DEP-001` — HolidayCSS CDN reference in `_stylesheets.haml` updated from `0.11.2` to `0.11.6`

### Minor

- [x] `RFCT-MIN-001` — Unused `--space-content-padding` and `--max-width-wide` deleted from `_tokens.scss`
- [x] `RFCT-MIN-002` — No-op `.byline { gap: 0 }` removed from `_article.scss`
- [x] `RFCT-MIN-003` — Tagline font size extracted to `--type-nav-tagline: 0.875rem` in `_tokens.scss`; hardcoded value in `_nav.scss` replaced with token
- [x] `RFCT-MIN-004` — `flex-flow` shorthand in `_resume.scss` replaced with separate `flex-direction` / `flex-wrap` declarations
- [x] `RFCT-MIN-005` — `color: black` in `_print.scss` changed to `color: #000`

### Doc Notes

- [x] `RFCT-DOC-001` — Comment added to `_tokens.scss` noting intentional semantic separation of `--type-byline`, `--type-series-label`, `--type-tag`, `--type-footer-link`
- [x] `RFCT-DOC-002` — Comment added to resume layout noting deliberate chrome divergence

# v26 Polish

## Narrative

As the author, I want to apply a collection of small visual and typographic refinements to the v26 redesign, so that the site feels finished rather than freshly shipped.

## Changes

### Home Page

- [x] "DWF's Journal" and tag line should be bigger
- [x] Top right nav should be bigger
- [x] Links to articles and series should have hover color
- [x] Article titles should have the header font applied
- [x] Article and Series titles should be differentiated — series column gets background tint, series titles in secondary color

### Article Page

- [x] Title should be in header font
- [x] Style the subtitle differently
- [x] Byline should be in the header font to differentiate it from the subtitle
- [x] H2 should be bigger
- [x] H3 should be bigger — bumped to 1.25rem (20px), weight 700
- [x] Notes header should be larger — bumped to var(--type-h3), weight 700, primary color
- [x] Share button moved into the byline row (author · date · read time · Share)
- [x] Fix deprecations (`previous_article` / `next_article` → `article_previous` / `article_next`)

### Series Top Page

- [x] Header for each series page should be bigger (global heading font fix)
- [x] Link should have hover color

### Series Page

- [x] Article titles should be in header font and bigger than teaser
- [x] Date line should be bigger
- [x] Less whitespace between articles

### About Page

- [x] Title of page should be in header font (global heading font fix)
- [x] Lost the frame around the profile photo (round?) — restored via `_base.scss`
- [x] Socials + resume links should be custom list — horizontal flex row, icons + text, heading font
- [x] Resume links merged into the social links row with matching social-link styling

## Open Decisions (questions 1–8)

1. Nav brand + tagline + links: how much bigger? *(proposed: brand 18px, tagline 14px, links 14px)*
2. H2 / H3 sizing *(proposed: h2 1.5rem 700, h3 1.25rem 400)*
3. Home page: how to differentiate article vs series titles *(options: A weight, B font, C size)*
4. Home page hover color: blue (`var(--color-link)`) instead of dark gray?
5. Share button: remove, move after tags, or keep?
6. Notes header size: 12px or 16px?
7. About page social links: keep icons + text list or text-only row?
8. About page resume links: separate with `<hr>` or visually distinct within list?

## EARS Specifications

_To be derived from the change list above._

## Implementation Plan

_To be sequenced after the change list is finalized._

# DWF's Journal — v26 Redesign

## Vision

Refresh the visual identity of [dwf.bigpencil.net](https://dwf.bigpencil.net) with a new typographic system (Alegreya Sans SC headings, IBM Plex Serif body), a flattened global navigation, a redesigned home page that surfaces recent posts and active series, and a more editorial article reading experience (clearer header hierarchy, pill tags, footnote treatment, prev/next navigation). Mobile-first and dark-mode capable from the ground up.

This is a visual and structural redesign delivered entirely in CSS/SCSS and HAML templates. No Ruby application logic changes; existing helpers and frontmatter conventions are reused.

## Context

The current stylesheet is `v23.css.scss`, indicating a yearly versioning cadence. Since v23, the post archive has grown, the nav has accumulated a seven-item Posts dropdown, and the home page surfaces only one recent post out of ~60 articles. Body typography (IBM Plex Sans) is functional but reads cold for long-form prose. Responsive behavior is bolted on via a separate `_portrait_phones.scss` partial rather than designed mobile-first.

v26 is an opportunity to reset typography, restructure navigation around the post surfaces readers actually use (recent posts and series), and rebuild responsive from a mobile baseline.

## Scope

### In Scope — six surfaces

The redesign targets six surfaces. Each is described below with concrete design intent. Implementation details (exact pixel sizes, weights, partials) will be refined story-by-story in Phase 3.

#### 1. Global chrome (cross-cutting)

Applies to every page that uses `layouts/layout.haml` (i.e., everything except `/resume`).

**Typography stack**
- Headings, nav, bylines, tags, footer: `Alegreya Sans SC` (400, 700; italic 400)
- Body, subtitles, pull quotes, footnotes, post-nav titles: `IBM Plex Serif` (400, 500; italic 400)
- Footnote numbers only: `IBM Plex Mono` (400)

Google Fonts embed (single `<link>`):
```
https://fonts.googleapis.com/css2?family=Alegreya+Sans+SC:ital,wght@0,400;0,700;1,400&family=IBM+Plex+Serif:ital,wght@0,400;0,500;1,400&family=IBM+Plex+Mono:wght@400&display=swap
```

**Nav**
- Flatten the current "Posts" dropdown. Top-level items: **Posts**, **Series**, **About**
- Brand "DWF's Journal" + tagline "A computer is just a BIG. PENCIL." appear in the nav on every page (removed from home page h1)
- Layout: brand + tagline left-aligned, nav links right-aligned, bottom border rule
- Persistent across all `layout.haml` pages

**Footer**
- Three-column horizontal strip with top border rule
- Left: brand "DWF's Journal" (Alegreya Sans SC bold)
- Center: social links — Threads · Mastodon · Bluesky · GitHub · LinkedIn (Alegreya Sans SC 11px, tertiary)
- Right: © year + author (tertiary)
- Social URLs sourced from existing `config.rb` settings (no `data/social.yml` migration this epic)

**Stylesheet versioning**
- New `source/stylesheets/v26.css.scss` built alongside the existing `v23.css.scss`
- Cutover happens by swapping the include in `components/_stylesheets.haml`
- `v23` and its partials remain on disk until the epic ships

**Mobile-first**
- v26 is authored mobile-first. The `_portrait_phones.scss` desktop-then-bolt-on pattern is not carried forward
- Breakpoints introduced as `min-width` media queries from a single-column baseline

**Dark mode**
- Design tokens (colors) expressed as CSS custom properties
- `prefers-color-scheme: dark` media query overrides token values
- Pull quote border, footnote color, tag pill backgrounds all need explicit dark-mode values

#### 2. Home page

Replaces the current h1 + intro paragraph + three-card grid layout.

**Profile strip** (replaces page-level h1)
- Avatar (56px), name as h1 "Hello, I'm Davis.", two-sentence bio condensed from existing intro
- Compact horizontal strip with light background tint

**Two-column main grid**
- Left (~60%): **Recent Posts** — three most recent articles, each showing title (IBM Plex Serif medium), teaser (italic, secondary color), date + read time (Alegreya Sans SC small, tertiary). Top/bottom border rules between entries. "All Posts →" link below
- Right (~40%): **Series** — all four active series, each with series title (Alegreya Sans SC bold) and one-line description (IBM Plex Serif italic). "All Series →" link below

**Removed from home**
- Large `# DWF's Journal` h1 (covered by nav brand)
- Single "Latest" card (replaced by 3-post list)
- The two series-promo cards (CD Test, Obsidian Tips) — superseded by full series list on the right

#### 3. Article page

**Header (above hero image)**
Reading order: series/category label → h1 title → subtitle → byline.
- Series label: small caps Alegreya Sans SC 11px, tertiary color, letter-spaced (populated from existing `data/series.yml` lookup keyed on frontmatter `series:` field)
- Title: Alegreya Sans SC 27–30px bold, line-height 1.2
- Subtitle: IBM Plex Serif 16px italic, secondary color. **Source: existing `teaser` frontmatter field** (not `description` — the redesign doc mistakenly called this `description`)
- Byline: Alegreya Sans SC small — `{author} · {DD Month YYYY} · {N min read}`. Author from `config[:site_author]`, read time from existing `reading_time_for` helper

**Hero image (below header)**
- Moves from above the header to below it
- Render only when `unsplash:` frontmatter is present; absent → no image, no placeholder
- Constrained: max-height ~220px, `object-fit: cover`

**Body typography**
- IBM Plex Serif 15–15.5px, line-height 1.85
- Paragraph spacing: `margin-bottom: 1.2em`
- h2: bottom border rule
- h3: no border, slightly smaller, letter-spaced

**Pull quotes**
- New explicit `.pullquote` helper or partial (not by repurposing markdown `>`)
- Style: left border 2px (primary color), italic IBM Plex Serif 16.5px, secondary color
- Existing markdown `>` blockquotes get their own (less prominent) treatment

**Footnotes**
- "Notes" section label (Alegreya Sans SC 11px letter-spaced)
- Top border rule separating from body
- Number column: IBM Plex Mono 10px tertiary, fixed-width
- Text: IBM Plex Serif 12.5px secondary
- In-body superscript refs: IBM Plex Mono 10px tertiary, no default link color
- Kramdown's existing `.footnotes` markup is restyled — no markdown changes required

**Tags as pills**
- Replace `tag_sentence_for` inline rendering with pill row
- Pill: Alegreya Sans SC 11.5px, background-secondary fill, 0.5px border (tertiary), 6px radius, 2px/9px padding, 0.02em letter-spacing
- Series rendering is removed from tag row (series moves to header label above title)
- `tag_sentence_for` helper output decomposes — template renders tags as a loop

**Prev/Next navigation**
- New two-column grid below tags, above footer
- Direction label (Alegreya Sans SC 11px letter-spaced tertiary) + title (IBM Plex Serif 13.5px italic secondary)
- Next item right-aligned
- Sourced from `article.previous_article` / `article.next_article` (Middleman blog extension)

#### 4. Posts index page (`/posts`)

Structure unchanged. Apply v26 typographic treatment:
- Title: IBM Plex Serif medium
- Teaser: IBM Plex Serif italic secondary
- Date: Alegreya Sans SC small tertiary
- Subtle top border rule between entries

#### 5. Series landing page (`/series`) — new

- Lists all four active series from `data/series.yml`
- Each entry: series title (Alegreya Sans SC bold) + one-line description (IBM Plex Serif italic secondary)
- New template, layout, and route. Description text comes from `data/series.yml` (or a new field there if not present — to verify in Phase 3)

#### 6. Nav (covered in §1 — listed here for completeness)

### Out of Scope

- All pages not in the six surfaces above:
  - `/ip`, `/whisky`, `/notion`, `/all_tags`, `/tags/*`, `/404`, `/about_me`, `/resume`
  - These pages will inherit the new chrome (font, nav, footer) at cutover and may look transitional until their own future epics redesign them. No compatibility shim
- About page reshape (content, structure, slug rename) — deferred to a future epic
- Social link migration from `config.rb` to `data/social.yml` — deferred
- Hero image sourcing/curation — current Unsplash entries remain; per-post hero is rendered only when frontmatter is present
- Any Ruby code changes outside trivial template/helper adjustments needed for new rendering (e.g., splitting `tag_sentence_for` output in templates). No new helpers in this epic except as required by the explicit pull-quote feature

## Success Criteria

1. All six surfaces render under `v26.css.scss` and pass visual review at desktop and mobile widths
2. Nav + footer chrome appears consistently on every `layout.haml` page
3. Dark mode renders correctly when the OS reports `prefers-color-scheme: dark`
4. Existing article archive (~60 posts) renders without layout regressions in the new article template
5. Kramdown footnotes (`[^1]`) continue to work; footnote section is visually restyled per spec
6. Cutover is a single one-line change in `components/_stylesheets.haml`; rollback is trivial by reverting that line
7. No Ruby application logic changes beyond template adjustments required by the redesign

## Dependencies

- Google Fonts: `Alegreya Sans SC`, `IBM Plex Serif`, `IBM Plex Mono` (loaded via a single `<link>` in `components/_stylesheets.haml` or layout `<head>`)
- Existing Kramdown footnote rendering (no parser changes)
- Existing `reading_time_for`, `teaser_for` helpers
- Existing `data/series.yml` (may need a `description` field added — verify in Phase 3)
- Middleman blog extension `next_article` / `previous_article` (already available)
- FontAwesome (already loaded) for footer social icons if iconography is kept; otherwise text-only links per design

## Open Questions

All Phase 1 ambiguities have been resolved. Any new questions discovered during Phase 3 (EARS specs) will be raised before TDD execution begins.

## Resulting Stories

- [x] [0010 — Chrome Foundation](0001-site-redesign/0010-chrome-foundation.md)
- [x] [0020 — Article Page Redesign](0001-site-redesign/0020-article-page.md)
- [x] [0030 — Pull-Quote Helper](0001-site-redesign/0030-pullquote-helper.md)
- [x] [0040 — Home Page Redesign](0001-site-redesign/0040-home-page.md)
- [x] [0050 — Posts Index Redesign](0001-site-redesign/0050-posts-index.md)
- [x] [0060 — Series Landing Page](0001-site-redesign/0060-series-landing.md)
- [x] [0070 — Cutover](0001-site-redesign/0070-cutover.md)
- [x] [0080 — v26 Polish](0001-site-redesign/0080-polish.md)
- [x] [0090 — Resume CSS Review](0001-site-redesign/0090-resume-css.md)
- [x] [0100 — v26 CSS/HAML Refactor](0001-site-redesign/0100-refactor.md)
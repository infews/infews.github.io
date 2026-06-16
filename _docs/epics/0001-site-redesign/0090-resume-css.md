# Resume CSS Review

## Narrative

As the author, I want the resume pages (`/resume/dwfrank`, `/resume/dwfrank_full`) reviewed and updated so that their styles are intentional and consistent with any global changes introduced by v26, so that the resume doesn't feel like an orphaned page.

## Scope

- Review `source/stylesheets/_resume.scss` and `source/layouts/resume.haml`
- Identify styles that should adopt v26 tokens (fonts, colors, spacing)
- Identify styles that should remain resume-specific
- The resume uses its own layout (`resume.haml`) and is explicitly excluded from the v26 chrome — that exclusion stays

## Changes

- [x] `_resume.scss` not imported in v26 — added `@import "_resume"` to `v26.css.scss`
- [x] `$font-family-body` SCSS variable in `_resume.scss` → `var(--font-body)`
- [x] v23/HolidayCSS CSS custom properties replaced with v26 equivalents:
  - `var(--icon-tab-color)` → `var(--color-link)`
  - `var(--icon-tab-hover-color)` → `var(--color-link-hover)`
  - `var(--background-color)` → `var(--color-bg-primary)`
  - `var(--heading-color)` → `var(--color-text-primary)`
- [x] `resume.haml` contact info hardcoding replaced with `config.rb` values (email, github, site_url, linkedin)
- [x] Both `/resume/dwfrank` and `/resume/dwfrank_full` verified visually

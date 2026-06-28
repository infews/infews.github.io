# Unify Article Tags and Keywords

## Vision

Remove the `keywords:` field from all article front matter. The `ArticleLd` JSON-LD helper will read from the existing `tags` field instead. A single front matter field serves both site navigation and SEO structured data.

## Context

As of 2026-06-28, all ~60 articles carry both `tags:` (used by Middleman Blog for tag pages, navigation filtering, and private-article exclusion) and `keywords:` (used exclusively by `ArticleLd` for JSON-LD structured data). The fields were intended to differ — broad nav categories vs. specific SEO terms — but the distinction has been applied inconsistently across the archive. The tradeoff of a single value set serving both purposes is accepted.

Note: `ArticleListLd#summary_data=` also has a `keywords` key, but it is only ever populated from `data/series.yml` via `series_page_ld_for`, not from article front matter. It is not changed by this epic.

## Scope

### In Scope

- `helpers/linking_data_helpers/article_ld.rb` — change `data.keywords` to `data.tags`
- `spec/helpers/linking_data_helpers_spec.rb` — verify spec still passes; update assertions if needed
- All `source/articles/*.md` files (~60) — remove the `keywords:` block from YAML front matter

### Out of Scope

- `helpers/linking_data_helpers/article_list_ld.rb` — its `keywords` comes from `data/series.yml`, not article front matter
- `helpers/linking_data_helpers/home_ld.rb` — hardcoded keyword string, unrelated to article front matter
- `data/series.yml` — series keywords are a separate concern
- Changes to any `tags:` values in article front matter

## Success Criteria

1. `bundle exec rake spec` passes with 0 failures
2. No `keywords:` key appears in any `source/articles/*.md` front matter
3. Rendered article JSON-LD contains a `keywords` field populated from the article's `tags`

## Dependencies

None.

## Open Questions

None.

## Resulting Stories

- [x] [0010 — Update ArticleLd to use tags](0003-unify-tags-keywords/0010-update-ld-helper.md)
- [x] [0020 — Remove keywords from all article front matter](0003-unify-tags-keywords/0020-remove-keywords-frontmatter.md)
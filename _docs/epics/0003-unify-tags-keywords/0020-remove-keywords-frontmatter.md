# Remove Keywords from All Article Front Matter

## Goal

Strip the `keywords:` block from the YAML front matter of every article in `source/articles/`. After story 0010, `ArticleLd` reads from `tags`, making `keywords` dead weight.

## Acceptance Criteria

No `keywords:` key appears in any `source/articles/*.md` file.

`bundle exec rake spec` passes with 0 failures.

## Checklist

- [ ] Remove `keywords:` block from all `source/articles/*.md` files (~60 files)
- [ ] Verify with `grep -r "keywords:" source/articles/` returning no output
- [ ] Run `bundle exec rake spec` — passes

## Notes

- Content of `tags:` values must not be changed. This story removes `keywords:` only.
- `data/series.yml` is not touched; series keywords are a separate concern.
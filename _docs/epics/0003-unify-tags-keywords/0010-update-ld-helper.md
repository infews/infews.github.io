# Update ArticleLd to Use Tags

## Narrative

As a reader whose browser or search engine parses JSON-LD structured data, I want the article `keywords` field to reflect the same values as the article's navigation tags, so that the SEO metadata is consistent with the site's categorization.

As the developer, I want a single front matter field (`tags`) to serve both Middleman Blog navigation and JSON-LD, so that articles have no duplicated metadata fields.

## Acceptance Criteria

```gherkin
Feature: ArticleLd keywords come from tags

  Scenario: Article with tags
    Given an article with frontmatter "tags: [parenting]"
    When the page is rendered and JSON-LD is parsed
    Then ld["keywords"] equals ["parenting"]

  Scenario: Article with multiple tags
    Given an article with frontmatter "tags: [ruby, rails, software engineering]"
    When the page is rendered and JSON-LD is parsed
    Then ld["keywords"] equals ["ruby", "rails", "software engineering"]
```

## EARS Specifications

- [x] `LD-001`: When an article is rendered, the JSON-LD `keywords` field shall be populated from the article's `tags` front matter field.

## Implementation Plan

1. [x] Update `helpers/linking_data_helpers/article_ld.rb`: change `keywords: data.keywords` to `keywords: data.tags` in `article_data=`
2. [x] Run `bundle exec rake spec` — expect existing spec at `linking_data_helpers_spec.rb:102` to pass unchanged (the test article "Kids & Teachable Moments" has `tags: [parenting]` which matches the current expected value)

## Notes

- `ArticleListLd#summary_data=` also contains a `keywords` key but is populated from `data/series.yml` via `series_page_ld_for`, not from article front matter. It is not changed in this story.
- The full-stack spec builds Middleman before asserting, so the `keywords:` field must still exist in article front matter when this story runs. Story 0020 removes those fields after this story is complete.
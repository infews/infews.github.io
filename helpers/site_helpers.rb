require 'json'

module SiteHelpers

  def series_slug_for(series_name)
    series_name.downcase.gsub(" ", "-")
  end

  def json_ld_component_name_for(page_classes)
    classes = page_classes.split
    case classes.first
    when "index"
      "index_json_ld"
    when "series"
      "series_json_ld"
    when "tags"
      "index_json_ld"
    else
      "article_json_ld"
    end
  end

  def json_ld
    {
      "@context": "https://schema.org",
      "@type": "BlogPosting",
      "genre": "software development",
      "headline": "DWF's Journal Home",
      "keywords": "software development, agile, career, personal",
      "author": {
        "@type": "Person",
        "name": "Davis W. Frank",
        "email": "dwfrank@gmail.com"
      }
    }
  end

  def article_json_ld_for(article)
    original_date = article.date.strftime("%Y-%m-%d")
    modified_date = File.mtime(Dir.glob("source/articles/#{original_date}-#{article.slug}*")[0]).strftime("%Y-%m-%d")
    body_without_tags = article.body.gsub(/<\/?[^>]*>/, "")

    json_ld.merge({
      "headline": article.data.title,
      "keywords": article.data.keywords.join(","),
      "url": "https://dwf.bigpencil.net/#{article.slug}",
      "datePublished": original_date,
      "dateCreated": original_date,
      "dateModified": modified_date,
      "description": article.data.description,
      "articleBody": body_without_tags
    })
  end

  def series_json_ld_for(series_name, articles)
    most_recent_article = articles.first
    earliest_article = articles.last

    json_ld.merge({
      "url": "https://dwf.bigpencil.net/series/#{series_slug_for(series_name)}",
      "headline": series_name,
      "datePublished": earliest_article.date.strftime("%Y-%m-%d"),
      "dateCreated": earliest_article.date.strftime("%Y-%m-%d"),
      "dateModified": most_recent_article.date.strftime("%Y-%m-%d"),
    })
  end

  def index_json_ld
    modified_date = File.mtime(Dir.glob("source/index.html.haml")[0]).strftime("%Y-%m-%d")
    json_ld.merge({
      "url": "https://dwf.bigpencil.net/",
      "datePublished": "2020-11-01",
      "dateCreated": "2020-11-01",
      "dateModified": modified_date
    })
  end
end

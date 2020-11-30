require 'json'

module SiteHelpers

  def series_slug_for(series)
    series.downcase.gsub(" ", "-")
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
    date = article.date.strftime("%Y-%m-%d")
    article_source_path = "#{date}-#{article.slug}"
    modified_date = File.mtime(Dir.glob("source/articles/#{article_source_path}*")[0]).strftime("%Y-%m-%d")

    json_ld.merge({
      "headline": article.data.title,
      "keywords": article.data.keywords.join(","),
      "url": "https://dwf.bigpencil.net/#{article.slug}",
      "datePublished": date,
      "dateCreated": date,
      "dateModified": modified_date,
      "description": article.data.description,
      "articleBody": article.body.gsub(/<\/?[^>]*>/, "")
    })
  end

  def earliest_published_date_in(articles)
    articles.last.date.strftime("%Y-%m-%d")
  end

  def series_json_ld_for(series, articles)
    json_ld.merge({
      "url": "https://dwf.bigpencil.net/series/#{series_slug_for(series)}",
      "headline": series,
      "datePublished": earliest_published_date_in(articles),
      "dateCreated": earliest_published_date_in(articles),
      "dateModified": articles.first.date.strftime("%Y-%m-%d")
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

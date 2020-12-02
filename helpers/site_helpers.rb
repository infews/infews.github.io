require 'json'

module SiteHelpers
  module LinkingData
    def base_data
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

    def strip_tags_from(body)
      body.gsub(/<\/?[^>]*>/, "")
    end
  end

  class Article
    include LinkingData

    def initialize(page_locals)
      @article = page_locals[:article]
    end

    def data
      original_date = @article.date.strftime("%Y-%m-%d")
      modified_date = File.mtime(Dir.glob("source/articles/#{original_date}-#{@article.slug}*")[0]).strftime("%Y-%m-%d")

      base_data.merge({
        "headline": @article.data.title,
        "keywords": @article.data.keywords.join(","),
        "url": "https://dwf.bigpencil.net/#{@article.slug}",
        "datePublished": original_date,
        "dateCreated": original_date,
        "dateModified": modified_date,
        "description": @article.data.description,
        "articleBody": strip_tags_from(@article.body)
      })
    end
  end

  class Series
    include LinkingData

    def initialize(page_locals)
      @name = page_locals[:series]
      @slug = @name.downcase.gsub(" ", "-")

      @articles = page_locals[:articles]
    end

    def data
      most_recent_article = @articles.first
      earliest_article = @articles.last

      base_data.merge({
        "url": "https://dwf.bigpencil.net/series/#{@slug}",
        "headline": @name,
        "datePublished": earliest_article.date.strftime("%Y-%m-%d"),
        "dateCreated": earliest_article.date.strftime("%Y-%m-%d"),
        "dateModified": most_recent_article.date.strftime("%Y-%m-%d"),
        "articleBody": @articles.collect { |a| a.title }.join(", ")
      })
    end
  end

  class Page
    include LinkingData

    def initialize(page_locals) end

    def data
      modified_date = File.mtime(Dir.glob("source/index.html.haml")[0]).strftime("%Y-%m-%d")

      base_data.merge({
        "url": "https://dwf.bigpencil.net/",
        "datePublished": "2020-11-01",
        "dateCreated": "2020-11-01",
        "dateModified": modified_date
      })
    end
  end

  def linking_data_for(locals, article, articles)
    page = {}
    klass = Page

    if article
      page[:article] = article
      klass = Article
    elsif locals[:series]
      page[:series] = locals[:series]
      page[:articles] = articles
      klass = Series
    end

    klass.new(page)
  end
end

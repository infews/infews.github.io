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

    def to_json
      data.to_json
    end

    def strip_tags_from(body)
      body.gsub(/<\/?[^>]*>/, "")
    end
  end

  class Article
    include LinkingData

    def initialize(page)
      @path = page[:path]
      @article = page[:article]
    end

    def data
      original_date = @article.date.strftime("%Y-%m-%d")
      modified_date = File.mtime(Dir.glob("source/articles/#{original_date}-#{@article.slug}*")[0]).strftime("%Y-%m-%d")

      base_data.merge({
        "headline": @article.data.title,
        "keywords": @article.data.keywords.join(","),
        "url": "https://dwf.bigpencil.net/#{@path}",
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

    def initialize(page)
      @path = page[:path]
      @name = page[:series]
      @slug = @name.downcase.gsub(" ", "-")

      @articles = page[:articles]
    end

    def data
      most_recent_article = @articles.first
      earliest_article = @articles.last

      base_data.merge({
        "url": "https://dwf.bigpencil.net/#{@path}",
        "headline": @name,
        "datePublished": earliest_article.date.strftime("%Y-%m-%d"),
        "dateCreated": earliest_article.date.strftime("%Y-%m-%d"),
        "dateModified": most_recent_article.date.strftime("%Y-%m-%d"),
        "articleBody": @articles.collect { |a| a.title }.join(", ")
      })
    end
  end

  class Tag
    include LinkingData

    def initialize(page)
      @path = page[:path]
      @tag = page[:tag]
      @articles = page[:articles]
    end

    def data
      most_recent_article = @articles.first
      earliest_article = @articles.last

      base_data.merge({
        "url": "https://dwf.bigpencil.net/#{@path}",
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

    def initialize(page)
      @path = page[:path]
    end

    def data
      modified_date = File.mtime(Dir.glob("source/index.html.haml")[0]).strftime("%Y-%m-%d")

      base_data.merge({
        "url": "https://dwf.bigpencil.net/#{@path}",
        "datePublished": "2020-11-01",
        "dateCreated": "2020-11-01",
        "dateModified": modified_date
      })
    end
  end

  def linking_data_for(locals, article, articles)
    page = {}
    page[:path] = locals[:current_path]

    klass = Page

    if article
      page[:article] = article
      klass = Article
    elsif locals[:series]
      page[:series] = locals[:series]
      page[:articles] = articles
      klass = Series
    elsif locals[:current_path] =~ /^tags/
      page[:tag] = locals[:current_path].split('/')[1]
      page[:articles] = articles
      klass = Tag
    end

    klass.new(page)
  end
end

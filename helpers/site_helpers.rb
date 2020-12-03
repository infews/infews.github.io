require 'json'

module SiteHelpers
  class LinkingData

    def initialize(page)
      @path = page[:path]

      @data = {
        "@context": "https://schema.org",
        "@type": "BlogPosting",
        "genre": "software development",
        "headline": "DWF's Journal Home",
        "url": "https://dwf.bigpencil.net/#{@path.sub("index.html", "")}",
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

    def to_json
      @data.to_json
    end
  end

  class Article < LinkingData

    def initialize(page)
      super

      @article = page[:article]
      original_date = @article.date.strftime("%Y-%m-%d")
      modified_date = File.mtime(Dir.glob("source/articles/#{original_date}-#{@article.slug}*")[0]).strftime("%Y-%m-%d")

      @data.merge!({
        "headline": @article.data.title,
        "keywords": @article.data.keywords.join(","),
        "datePublished": original_date,
        "dateCreated": original_date,
        "dateModified": modified_date,
        "description": @article.data.description,
        "articleBody": strip_tags_from(@article.body)
      })
    end
  end

  class Series < LinkingData

    def initialize(page)
      super
      @name = page[:series]
      @slug = @name.downcase.gsub(" ", "-")

      @articles = page[:articles]

      most_recent_article = @articles.first
      earliest_article = @articles.last

      @data.merge!({
        "headline": @name,
        "datePublished": earliest_article.date.strftime("%Y-%m-%d"),
        "dateCreated": earliest_article.date.strftime("%Y-%m-%d"),
        "dateModified": most_recent_article.date.strftime("%Y-%m-%d"),
        "articleBody": @articles.collect { |a| a.title }.join(", ")
      })
    end
  end

  class Tag < LinkingData

    def initialize(page)
      super

      @tag = page[:tag]
      @articles = page[:articles]

      most_recent_article = @articles.first
      earliest_article = @articles.last

      @data.merge!({
        "headline": @name,
        "datePublished": earliest_article.date.strftime("%Y-%m-%d"),
        "dateCreated": earliest_article.date.strftime("%Y-%m-%d"),
        "dateModified": most_recent_article.date.strftime("%Y-%m-%d"),
        "articleBody": @articles.collect { |a| a.title }.join(", ")
      })
    end
  end


  class Page < LinkingData

    def initialize(page)
      super

      modified_date = File.mtime(Dir.glob("source/index.html.haml")[0]).strftime("%Y-%m-%d")

      @data.merge!({
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

  def series_link_for(series_name)
    "<a href=\"/series/#{series_name.downcase.gsub(" ", "-")}\">#{series_name}</a>"
  end
end

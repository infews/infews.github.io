require "json"

module LinkingDataHelpers
  class LinkingData
    def initialize(options)
      path = options[:path].sub("index.html", "")

      @data = {
        "@context": "https://schema.org",
        "@type": "BlogPosting",
        genre: "software development",
        headline: headline("Home"),
        url: "https://dwf.bigpencil.net/#{path}",
        keywords: "software development, agile, career, personal",
        author: {
          "@type": "Person",
          name: "Davis W. Frank",
          email: "dwfrank@gmail.com"
        }
      }
    end

    def headline(text)
      "DWF's Journal - #{text}"
    end

    def strip_tags_from(body)
      body.gsub(/<\/?[^>]*>/, "")
    end

    def to_json
      @data.to_json
    end

    def self.class_for(options)
      if options[:article]
        Article
      elsif options[:series]
        Series
      elsif /^tags/.match?(options[:path])
        Tag
      else
        Page
      end
    end
  end

  class Article < LinkingData
    def initialize(options)
      super
      article = options[:article]

      original_date = article.date.strftime("%Y-%m-%d")
      source_file = Dir.glob("source/articles/#{original_date}-#{article.slug}*").first
      modified_date = File.mtime(source_file).strftime("%Y-%m-%d")

      @data.merge!({
        headline: headline(article.data.title),
        keywords: article.data.keywords.join(","),
        datePublished: original_date,
        dateCreated: original_date,
        dateModified: modified_date,
        description: article.data.description,
        articleBody: strip_tags_from(article.body)
      })
    end
  end

  class Series < LinkingData
    def initialize(options)
      super

      articles = options[:articles]

      most_recent_article = articles.first
      earliest_article = articles.last

      @data.merge!({
        headline: headline(options[:series]),
        datePublished: earliest_article.date.strftime("%Y-%m-%d"),
        dateCreated: earliest_article.date.strftime("%Y-%m-%d"),
        dateModified: most_recent_article.date.strftime("%Y-%m-%d"),
        articleBody: articles.collect { |a| a.title }.join(", ")
      })
    end
  end

  class Tag < LinkingData
    def initialize(options)
      super

      tag = options[:path].split("/")[1]
      articles = options[:articles]
      most_recent_article = articles.first
      earliest_article = articles.last

      @data.merge!({
        headline: headline(tag.to_s),
        datePublished: earliest_article.date.strftime("%Y-%m-%d"),
        dateCreated: earliest_article.date.strftime("%Y-%m-%d"),
        dateModified: most_recent_article.date.strftime("%Y-%m-%d"),
        articleBody: articles.collect { |a| a.title }.join(", ")
      })
    end
  end

  class Page < LinkingData
    def initialize(options)
      super

      source_file = Dir.glob("source/index.html.haml").first
      modified_date = File.mtime(source_file).strftime("%Y-%m-%d")

      @data.merge!({
        datePublished: "2020-11-01",
        dateCreated: "2020-11-01",
        dateModified: modified_date
      })
    end
  end

  def linking_data_for(locals, article, articles)
    options = {
      article: article,
      articles: articles,
      series: locals[:series],
      path: locals[:current_path]
    }
    klass = LinkingData.class_for(options)
    klass.new(options).to_json
  end
end

require "json"
require_relative "./linking_data_helpers/linking_data"
require_relative "./linking_data_helpers/home_ld"
require_relative "./linking_data_helpers/article_ld"
require_relative "./linking_data_helpers/dwf_ld"
require_relative "./linking_data_helpers/series_ld"

module LinkingDataHelpers

  def full_url_for(path)
    "https://dwf.bigpencil.net#{path}"
  end

  def linking_data_for(options)
    current_page = options[:current_page]
    is_blog_article = options[:is_blog_article]
    blog = options[:blog]
    site_data = options[:site_data]
    articles = options[:articles]

    linking_data =
      if is_blog_article
        ArticleLd.new do |p|
          p.url = full_url_for(current_page.url)
          p.published_at = Date.parse(current_page.data.date).strftime("%Y-%m-%d")
          p.updated_at = updated_date_dashed(current_page.source_file)
          p.article_data = current_page.data
          p.stripped_body = strip_tags(current_page.body)
          p.is_root_node
          p.is_authored_node
        end
        #   # elsif current_page.url == "/posts/"
        #   # elsif current_page.url == "/all_tags/"
        #   # elsif /^\/tags/.match?(current_page.url)
      elsif /^\/series/.match?(current_page.url)
        series = current_page.url.split("/").last
        series_ld = SeriesLd.new do |p|
          p.url = full_url_for(current_page.url)
          p.published_at = created_date_dashed(current_page.source_file)
          p.updated_at = updated_date_dashed(current_page.source_file)
          p.series_data = site_data.series[series]
          p.is_authored_node
        end

        articles_ld =
          articles.collect do |article|
            pp article.data.date
            a_ld =
              ArticleLd.new do |p|
                p.url = full_url_for(article.url)
                p.published_at = Date.parse(article.data.date).strftime("%Y-%m-%d")
                p.updated_at = updated_date_dashed(article.source_file)
                p.article_data = article.data
                p.is_authored_node
              end
            a_ld.linking_data
          end

        series_ld.articles = articles_ld
        series_ld
      elsif current_page.url == "/"
        latest_article = options[:blog].articles.first
        latest_ld = ArticleLd.new do |p|
          p.url = full_url_for(latest_article.url)
          p.article_data = latest_article.data
        end

        HomeLd.new do |p|
          p.url = full_url_for(current_page.url)
          p.published_at = created_date_dashed(current_page.source_file)
          p.updated_at = updated_date_dashed(current_page.source_file)
          p.articles = [latest_ld.linking_data, latest_ld.linking_data, latest_ld.linking_data]
          p.is_authored_node
        end
      elsif current_page.url =~ /resume\/$/ || current_page.url =~ /about_me\/$/
        DwfLd.new do |p|
          p.url = full_url_for(current_page.url)
          p.published_at = created_date_dashed(current_page.source_file)
          p.updated_at = updated_date_dashed(current_page.source_file)
          p.is_root_node
        end
      end

     linking_data.to_json
  end

  # class LinkingData
  #   def initialize(options)
  #     path = options[:path].sub("index.html", "")
  #
  #     @linking_data = {
  #       "@context": "https://schema.org",
  #       "@type": "BlogPosting",
  #       genre: "software development",
  #       headline: headline("Home"),
  #       url: "https://dwf.bigpencil.net/#{path}",
  #       keywords: "software development, agile, career, personal",
  #       author: {
  #         "@type": "Person",
  #         name: "Davis W. Frank",
  #         email: "dwfrank@gmail.com"
  #       }
  #     }
  #   end
  #
  #   def headline(text)
  #     "DWF's Journal - #{text}"
  #   end
  #
  #   def strip_tags_from(body)
  #     body.gsub(/<\/?[^>]*>/, "")
  #   end
  #
  #   def to_json
  #     @linking_data.to_json
  #   end
  #
  #   def self.class_for(options)
  #     if options[:article]
  #       Article
  #     elsif options[:series]
  #       Series
  #     elsif /^tags/.match?(options[:path])
  #       Tag
  #     else
  #       Page
  #     end
  #   end
  # end
  #
  # class Article < LinkingData
  #   def initialize(options)
  #     super
  #     article = options[:article]
  #
  #     original_date = article.date.strftime("%Y-%m-%d")
  #     source_file = Dir.glob("source/articles/#{original_date}-#{article.slug}*").first
  #     modified_date = File.mtime(source_file).strftime("%Y-%m-%d")
  #
  #     @linking_data.merge!({
  #       headline: headline(article.data.title),
  #       keywords: article.data.keywords.join(","),
  #       datePublished: original_date,
  #       dateCreated: original_date,
  #       dateModified: modified_date,
  #       description: article.data.description,
  #       articleBody: strip_tags_from(article.body)
  #     })
  #   end
  # end
  #
  # class Series < LinkingData
  #   def initialize(options)
  #     super
  #
  #     articles = options[:articles]
  #
  #     most_recent_article = articles.first
  #     earliest_article = articles.last
  #
  #     @linking_data.merge!({
  #       headline: headline(options[:series]),
  #       datePublished: earliest_article.date.strftime("%Y-%m-%d"),
  #       dateCreated: earliest_article.date.strftime("%Y-%m-%d"),
  #       dateModified: most_recent_article.date.strftime("%Y-%m-%d"),
  #       articleBody: articles.collect { |a| a.title }.join(", ")
  #     })
  #   end
  # end
  #
  # class Tag < LinkingData
  #   def initialize(options)
  #     super
  #
  #     tag = options[:path].split("/")[1]
  #     articles = options[:articles]
  #     most_recent_article = articles.first
  #     earliest_article = articles.last
  #
  #     @linking_data.merge!({
  #       headline: headline(tag.to_s),
  #       datePublished: earliest_article.date.strftime("%Y-%m-%d"),
  #       dateCreated: earliest_article.date.strftime("%Y-%m-%d"),
  #       dateModified: most_recent_article.date.strftime("%Y-%m-%d"),
  #       articleBody: articles.collect { |a| a.title }.join(", ")
  #     })
  #   end
  # end
  #
  # class Page < LinkingData
  #   def initialize(options)
  #     super
  #
  #     source_file = Dir.glob("source/index.html.haml").first
  #     modified_date = File.mtime(source_file).strftime("%Y-%m-%d")
  #
  #     @linking_data.merge!({
  #       datePublished: "2020-11-01",
  #       dateCreated: "2020-11-01",
  #       dateModified: modified_date
  #     })
  #   end
  # end
  #
  # def linking_data_for(locals, article, articles)
  #   options = {
  #     article: article,
  #     articles: articles,
  #     series: locals[:series],
  #     path: locals[:current_path]
  #   }
  #   klass = LinkingData.class_for(options)
  #   klass.new(options).to_json
  # end
end

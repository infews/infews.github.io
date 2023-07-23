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
        single_article_ld_for(current_page)
      # elsif current_page.url == "/posts/"
      # elsif current_page.url == "/all_tags/"
      # elsif /^\/tags/.match?(current_page.url)
      elsif /^\/series/.match?(current_page.url)
        series_page_ld_for(current_page, articles, site_data)
      elsif current_page.url == "/"
        home_page_ld(current_page, blog)
      elsif current_page.url =~ /resume\/$/ || current_page.url =~ /about_me\/$/
        personal_ld_for(current_page)
      end

     linking_data.to_json
  end

  private

  def single_article_ld_for(page)
    ArticleLd.new do |p|
      p.url = full_url_for(page.url)
      p.published_at = Date.parse(page.data.date).strftime("%Y-%m-%d")
      p.updated_at = updated_date_dashed(page.source_file)
      p.article_data = page.data
      p.stripped_body = strip_tags(page.body)
      p.is_root_node
      p.is_authored_node
    end
  end

  def home_page_ld(home_page, blog)
    latest_article = blog.articles.first
    latest_ld = ArticleLd.new do |p|
      p.url = full_url_for(latest_article.url)
      p.article_data = latest_article.data
    end

    HomeLd.new do |p|
      p.url = full_url_for(home_page.url)
      p.published_at = created_date_dashed(home_page.source_file)
      p.updated_at = updated_date_dashed(home_page.source_file)
      p.articles = [latest_ld.linking_data, latest_ld.linking_data, latest_ld.linking_data]
      p.is_authored_node
    end

  end

  def series_page_ld_for(page, articles, site_data)
    series = page.url.split("/").last

    series_ld = SeriesLd.new do |p|
      p.url = full_url_for(page.url)
      p.published_at = created_date_dashed(page.source_file)
      p.updated_at = updated_date_dashed(page.source_file)
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
  end
  def personal_ld_for(page)
    DwfLd.new do |p|
      p.url = full_url_for(page.url)
      p.published_at = created_date_dashed(page.source_file)
      p.updated_at = updated_date_dashed(page.source_file)
      p.is_root_node
    end
  end
end
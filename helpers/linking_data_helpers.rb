require "json"
require_relative "linking_data_helpers/linking_data"
require_relative "linking_data_helpers/home_ld"
require_relative "linking_data_helpers/article_ld"
require_relative "linking_data_helpers/dwf_ld"
require_relative "linking_data_helpers/article_list_ld"

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
    sitemap = options[:sitemap]

    linking_data =
      if is_blog_article
        article_ld = single_article_ld_for(current_page)
        article_ld.stripped_body = strip_tags(current_page.body)
        article_ld.is_root_node
        article_ld
      elsif current_page.url == "/posts/"
        article_list_ld_for(current_page, "DWF's Journal - All Posts", articles)
      elsif /^\/tags/.match?(current_page.url)
        tag = current_page.url.split("/").last
        article_list_ld_for(current_page, "DWF's Journal - Posts tagged with \"#{tag}\"", articles)
      elsif /^\/series/.match?(current_page.url)
        series_page_ld_for(current_page, articles, site_data)
      elsif current_page.url == "/"
        home_page_ld(current_page, blog, sitemap, site_data)
      elsif current_page.url =~ /resume\/$/ || current_page.url =~ /about_me\/$/
        personal_ld_for(current_page)
        # elsif current_page.url == "/all_tags/"
      end

    linking_data.to_json
  end

  private

  def article_list_ld_for(page, title, articles)
    article_list_ld =
      ArticleListLd.new do |p|
        p.url = full_url_for(page.url)
        p.published_at = created_date_dashed(page.source_file)
        p.updated_at = updated_date_dashed(page.source_file)
        p.summary_data = {title: title}
        p.is_authored_node
      end

    article_list_ld.articles =
      articles.collect do |article|
        single_article_ld_for(article).linking_data
      end

    article_list_ld
  end

  def single_article_ld_for(page)
    ArticleLd.new do |p|
      p.url = full_url_for(page.url)
      p.published_at = Date.parse(page.data.date).strftime("%Y-%m-%d")
      p.updated_at = updated_date_dashed(page.source_file)
      p.article_data = page.data
      p.is_authored_node
    end
  end

  def series_page_ld_for(page, articles, site_data)
    series = page.url.split("/").last
    series_data = site_data.series[series]

    series_ld = article_list_ld_for(page, series_data.title, articles)
    series_ld.summary_data = {
      title: series_data.title,
      headline: series_data.teaser,
      keywords: series_data.keywords
    }

    series_ld
  end

  def series_page_on_home_page_ld_for(series_name, series_data, sitemap)
    page = sitemap.resources.find { |a| a.url == "/series/#{series_name}/" }

    ArticleLd.new do |p|
      p.url = full_url_for(page.url)
      p.published_at = created_date_dashed(page.source_file)
      p.updated_at = updated_date_dashed(page.source_file)
      p.article_data = series_data
      p.is_authored_node
    end
  end

  def home_page_ld(home_page, blog, sitemap, site_data)
    featured_articles_ld = []
    featured_articles_ld << single_article_ld_for(blog.articles.first).linking_data
    cd = "the-cd-test"
    featured_articles_ld << series_page_on_home_page_ld_for(cd,
      site_data.series[cd],
      sitemap).linking_data
    obs = "obsidian"
    featured_articles_ld << series_page_on_home_page_ld_for(obs,
      site_data.series[obs],
      sitemap).linking_data
    HomeLd.new do |p|
      p.url = full_url_for(home_page.url)
      p.published_at = created_date_dashed(home_page.source_file)
      p.updated_at = updated_date_dashed(home_page.source_file)
      p.articles = featured_articles_ld
      p.is_authored_node
    end
  end

  def personal_ld_for(page)
    DwfLd.new do |p|
      p.url = full_url_for(page.url)
      p.is_root_node
    end
  end
end

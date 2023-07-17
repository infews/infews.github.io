site_url = config[:site_url]
site_author = config[:site_author]

xml.instruct!
xml.feed xmlns: 'http://www.w3.org/2005/Atom' do
  xml.title config[:site_title]
  xml.subtitle config[:site_subtitle]
  xml.link href: URI.join(site_url, current_page.path), rel: 'self'
  xml.link href: URI.join(site_url, blog.options.prefix.to_s)
  xml.id config[:site_id]
  xml.updated Time.now.iso8601
  xml.author { xml.name site_author }
  xml.rights "© #{site_author} #{Time.now.year}"

  blog.articles.each do |article|
    xml.entry do
      xml.title article.title
      xml.link href: URI.join(site_url, article.url), rel: 'alternate'
      xml.id article.metadata[:page][:id]
      xml.author { xml.name site_author }
      xml.summary article.data.teaser, type: 'html'
      xml.content article.body, type: 'html'
      xml.published article.date.to_time.iso8601

      updated_date = updated_at(article.source_file).to_date
      xml.updated updated_date.to_time.iso8601 if updated_date > article.date
    end
  end
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml',  layout: false
page '/*.json', layout: false
page '/*.txt',  layout: false

# Disable directory_index for 404 page
page '/404.html', directory_index: false

###
# Helpers and extensions
###

helpers do
  # Builds a page title from the article title + site title
  def page_title
    if current_article && current_article.title
      current_article.title + ' | ' + config[:site_title]
    else
      config[:site_title]
    end
  end

  # Renders component partials
  def component(path, locals={})
    partial "components/#{path}", locals: locals
  end

  def wrapper_classes_for(page_data)
    if page_data.wrapper_class == "resume"
      return "resume"
    end
    classes = ["wrapper"]
    classes << page_data.wrapper_class if page_data.wrapper_class
    classes.join(" ")
  end
end

# page "/daviswfrank_resume.html", layout: "resume"

activate :blog do |blog|
  blog.permalink = '{title}'
  # Matcher for blog source files
  blog.sources = 'articles/{year}-{month}-{day}-{title}.html'
  blog.layout = 'article'
  blog.default_extension = '.md'
  blog.tag_template = "tag.html"
  blog.filter = Proc.new { |article| ! article.tags.include?('private') }
  blog.custom_collections = {
    series: {
      link: "series/{series}.html",
      template: "/articles/series/index.html"
    }
  }
end

set :haml, { :format => :html5 }
Haml::TempleEngine.disable_option_validator!

# Markdown and syntax highlighting
activate :syntax
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, footnotes: true

# Use commit time from git for sitemap.xml and feed.xml
activate :vcs_time

###
# Site settings
###

activate :directory_indexes

set :site_url, 'https://dwf.bigpencil.net/'
set :site_title, "DWF\u2019s Journal"
set :site_subtitle, 'A computer is just a BIG. PENCIL.'
# set :profile_text,
set :site_author, 'Davis W. Frank'
set :site_id, 'urn:uuid:b7b7a839-4395-4fd8-b897-9256f2f64957'

# Usernames
set :github_username, 'infews'
set :twitter_username, 'dwfrank'
set :linkedin_username, 'daviswfrank'

#set :keybase_username, 'example'
#set :lastfm_username, 'example'
#set :spotify_username, 'example'

# Replace 'nil' with your Disqus shortname, eg. 'example'
#set :disqus_shortname, nil
set :nav_background, "development"
configure :build do
  set :google_analytics, "G-SNXCW3490N"
  set :nav_background, ""
end

###
# Environment settings
###
# Development-specific configuration
configure :development do
  # Reload the browser automatically whenever files change
  # activate :livereload
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html

  # Improve cacheability by using asset hashes in filenames
  activate :asset_hash
end

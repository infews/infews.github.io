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
    partial "components/#{path}", locals
  end
end

activate :blog do |blog|
  blog.permalink = '{title}'
  # Matcher for blog source files
  blog.sources = 'articles/{year}-{month}-{day}-{title}.html'
  blog.layout = 'article'
  blog.default_extension = '.md'
end

# Markdown and syntax highlighting
activate :syntax
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

# Use commit time from git for sitemap.xml and feed.xml
activate :vcs_time

###
# Site settings
###

profile_tweet = %q(
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Davis: 10/10 All day<br>David (if your name is David): 9/10 You’ll get it<br>David (1st time): 5/10 Likely a typo; (&gt;2nd time): 2/10 <br>Frank: 0/10 There is no comma in my name<br>Dave: 6/10 But it’s never stuck<br>D: 2/10 Do I know you?<br>DWF (rhymes with “woof”): 12/10 💪 I have cooked for you <a href="https://t.co/sCHIEY0VCt">https://t.co/sCHIEY0VCt</a></p>&mdash; Thank You for being a VOTER (@dwfrank) <a href="https://twitter.com/dwfrank/status/1306699548471959552?ref_src=twsrc%5Etfw">September 17, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
)

profile_text = %q(
Davis: 10/10 All day<br/>
David (if your name is David): 9/10 You’ll get it<br/>
David (1st time): 5/10 Likely a typo; (>2nd time): 2/10<br/>
Frank: 0/10 There is no comma in my name<br/>
Dave: 6/10 But it’s never stuck<br/>
D: 2/10 Do I know you?<br/>
DWF (rhymes with “woof”): 12/10 💪 I have cooked for you<br/>
)

set :site_url, 'http://example.com/'
set :site_title, "DWF's Journal"
set :site_subtitle, 'A computer is just a BIG. PENCIL!'
set :profile_text, profile_text
set :site_author, 'Davis W. Frank'
# Generate your own by running `rake id`
set :site_id, 'urn:uuid:b7b7a839-4395-4fd8-b897-9256f2f64957'

# Usernames
set :github_username, 'infews'
#set :keybase_username, 'example'ß
set :twitter_username, 'dwfrank'
set :linkedin_username, 'daviswfrank'
#set :lastfm_username, 'example'
#set :spotify_username, 'example'

# Replace 'nil' with your Disqus shortname, eg. 'example'
#set :disqus_shortname, nil
# Replace 'nil' with your Google Analytics key, eg. 'XX-XXXXXXXX-X'
#set :google_analytics, nil

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

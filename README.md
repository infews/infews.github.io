
[mm]: https://middlemanapp.com/
[blog]: https://middlemanapp.com/basics/blogging/
[cactus]: https://github.com/dtcristo/middleman-cactus

My personal blog.

Built with [Middleman][mm], a Ruby static site generator. Uses the [blogging extension][blog] and the [Middleman Cactus][cactus] theme.

Why this theme? It's clean and respsonsive.

# Middleman Cactus Settings

Update the following site configuration settings in `config.rb`:

```ruby
###
# Site settings
###
set :site_url, 'http://example.com/'
set :site_title, 'Site title'
set :site_subtitle, 'This is the site subtitle'
set :profile_text, %q(Pitchfork kogi forage, gluten-free pour-over drinking vinegar Etsy narwhal next level shabby chic bicycle rights tofu mustache scenester. Intelligentsia Brooklyn mumblecore, church-key meggings cardigan quinoa gluten-free banjo. Polaroid beard 8-bit, lumbersexual photo booth forage bitters mustache drinking vinegar biodiesel cardigan. Four loko raw denim polaroid selfies, mixtape skateboard lumbersexual. Odd Future Blue Bottle bicycle rights Etsy. Etsy Odd Future normcore, deep v Shoreditch seitan sustainable yr heirloom Brooklyn try-hard stumptown Bushwick cornhole. Portland chillwave pug Tumblr deep v readymade.)
set :site_author, 'Joe Bloggs'
# Generate your own by running `rake id`
set :site_id, 'urn:uuid:b8261ce6-4d49-4afa-9d16-643631ab5afc'

# Usernames
set :github_username, 'example'
set :keybase_username, 'example'
set :twitter_username, 'example'
set :linkedin_username, 'example'
set :lastfm_username, 'example'
set :spotify_username, 'example'

# Replace 'nil' with your Disqus shortname, eg. 'example'
set :disqus_shortname, nil
# Replace 'nil' with your Google Analytics key, eg. 'XX-XXXXXXXX-X'
set :google_analytics, nil
```

# Additions

- Ported (most) templates to HAML, because HAML
- Removed Disqus template
- Activated pretty URLs
- Added pages for tags
- Wrote a tag helper to link all tags to their pages on each article page
- Excludes `private` posts from all list pages, but still publishes them
- Turned on Markdown footnotes (expanded syntax, supported by RedCarpet), including style changes

## Coming Soon

- Other static pages
- Available tags on home page (how? TBD)


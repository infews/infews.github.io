
[mm]: https://middlemanapp.com/
[blog]: https://middlemanapp.com/basics/blogging/
[cactus]: https://github.com/dtcristo/middleman-cactus
[hcss]: https://holidaycss.js.org/

My personal blog.

Built with [Middleman][mm], a Ruby static site generator. Uses the [blogging extension][blog], style self-grown, and has plenty of helpers.

# Additions

- Ported (most) templates to HAML, because HAML
- Activated pretty URLs
- Added pages for:
  - All articles tagged with a tag
  - The concept of a blog series, with a first post, then the rest
  - Resume
- Styling
  - Moved to [Holiday CSS][hcss] for browser reset + responsiveness 
  - Moved CSS to `rem` measurements
  - Used variables for fonts, colors
  - Added slightly simpler media queries
  - Added print CSS, especially for a resume pages  
- Wrote some helpers:
  - a tag helper to link a tag to its tag page
  - an article teaser that can be stored in the in the YAML front matter (first paragraph auto clipping just sucks)
  - JSON-LD rendering for SEO
  - approximate reading time  
- Excludes `private` posts from all list pages, but still publishes them
- Turned on Markdown footnotes (expanded syntax, supported by RedCarpet), including style changes
- Prism for code syntax highlighting 

# Writing

`be rake article "NEW ARTICLE TITLE"`

- New article will be put in `source/articles`
- Write the article
  - Note that the title from the FrontMatter will be put at the top of the article as an H1. All article headings should start at H2.
- Update the YAML frontmatter
  - Fix the title
  - Update tags (for the blog), keywords (for SEO)
  - Ideally, links at the top of the article
- Adding a header photo
  - Find an unsplash photo that fits
  - Find the url with `be rake unsplash:find ID="<id from unsplash>`
  - Put the url in the front matter at the `unsplash` key
- Reviewing locally 
  - `be middleman`
  - Play with screen sizes

# Publishing

Once the article updates look good:

- Commit new Markdown file(s)
- `be rake html_proof`
  - This builds the site and crawls all the links
  - Fix the errors (there will be some local errors)
  - Commit updates
  - Once clean, continue
  - NOTE: this will fail relative URLs
- `git restore docs`
  - resets any interim changes to the published site
- `be rake prep`
- Commit changes
- `git push`

# Extending

- Anything Ruby, make sure that you `be rake` to fix the ruby as per Standard, then RSpec passes.
- Any new Ruby likely means the HTML will change, so re-publish as needed.



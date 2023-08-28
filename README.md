
[mm]: https://middlemanapp.com/
[blog]: https://middlemanapp.com/basics/blogging/
[cactus]: https://github.com/dtcristo/middleman-cactus

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
  - Moved CSS to `rem` measurements
  - Use of variables for fonts, colors
  - Added slightly simpler media queries
  - Added print CSS, especially for a resume page  
- Wrote some helpers:
  - a tag helper to link a tag to its tag page
  - an article teaser that can be stored in the in the YAML front matter (first paragraph auto clipping just sucks)
  - JSON-LD rendering for SEO
  - approximate reading time  
- Excludes `private` posts from all list pages, but still publishes them
- Turned on Markdown footnotes (expanded syntax, supported by RedCarpet), including style changes

# Writing

`be rake article "NEW ARTICLE TITLE"`

- New article will be put in `source/articles`
- Update the YAML frontmatter
  - Fix the title
  - Update tags (for the blog), keywords (for SEO)
  - Ideally, links at the top of the article
- Write the article
  - Note that the title will be put at the top of the article as an H1. So start headings/structure at H2 
- Reviewing locally 
  - `be middleman`
  - Play with screen sizes

# Publishing

Once the article updates look good:

- Commit new Markdown file(s)
- `be rake html_proof`
  - This builds the site and crawls all the links
  - Fix the errors
  - Commit updates
  - Once clean, continue
- `be rake prep`
- Commit changes
- `git push`

# Extending

- Anything Ruby, make sure that you `be rake` to fix the ruby as per Standard, then RSpec passes.
- Any new Ruby likely means the HTML will change, so re-publish as needed.



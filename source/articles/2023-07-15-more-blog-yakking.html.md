---
title: A Little More Yak Trimming
date: 2023-07-15 21:45 UTC
tags:
  - software
  - blog
keywords:
  - ruby
  - Middleman
  - HAML
  - Markdown
  - blog
  - CSS
  - syntax highlighting
teaser: I did a couple more small things.
---

[prism]: https://prismjs.com/
[k]: https://kramdown.gettalong.org/
[obs]: /series/obsidian
[r]: https://github.com/rouge-ruby/rouge
[p]: https://pygments.org/

I continued to trim around the ears of this blog since last week. And a few things stood out that I felt worth sharing.

## CSS Factoring

CSS, in this case, SCSS, is source code worth factoring just like any other code. Now that I'd trimmed the sytlesheets signficantly, I felt it worth organizing them better for later maintenance. Maybe I won't feel the need to throw out and start over in anohter year!

I'm using Google Fonts here. While I was pretty happy with the indirection of SASS variables for font family, I did go a little further and have variables for color and weight. Then I pulled out a fonts-only file. While I stopped short of writing a function that generated the Google Fonts URL, I still can change all font attributes in one place if I choose. That's a fine win.

I also made sure all my font units were in `rem`, making it easier to scale things for mobile as I tweak sizes over time when fonts change.

I pulled out other sections, roughly mapped to the different types of pages, each into their own files. And I put special media queries at the bottom of each file. But I do have 1 key complex media query for portrait phones in its own file. The longest file is 85 lines. My final css file is only imports.

## Better Syntax Highlighting

Lastly, due to my [Obsidian][obs] series, there are a lot of code blocks that are just Markdown. I wasn't happy with how simply [Rouge][r] (and thus [Pygments][p]) supported Markdown - the tagging is simpler than I'd like. [Kramdown][k] supports Rouge and [Coderay][c]. But I wanted a converter that had more granularity for MD.

I converted to using [Prism][prism], which highlights `<code>` blocks with JavaScript. This required:

- Downloading a Prism bundle that included the language support I expect
- Finding and tweaking a Prism theme
- Adding these to the repo
- Adding these to the layout files
- Turning off syntax highlighting for [Kramdown][k] with a well-placed `nil` in Middleman's `config.rb` like so:

```ruby
set :markdown_engine, :kramdown
set :markdown,
    auto_ids: false,
    input: "GFM",            # GH emoji + ``` code blocks
    layout_engine: :haml,
    tables: true,
    autolink: true,
    smartypants: true,
    fenced_code_blocks: true,
    syntax_highlighter: nil  # turns off Rouge so we can use PrismJS
```
While Kramdown won't parse the contents of the `<code>` block, it does set a CSS class on it (and the parent `<pre>` tag) based on the language. Prism uses that class when converting to HTML for coloring.

That's enough blog yak shaving for a while. Back to writing...
---
title: Shaving The Blog Yak
date: 2023-07-11 16:43 UTC
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
teaser: All the details about the update and clean up this blog's code.
---
[mm]: https://middlemanapp.com
[ld]: https://json-ld.org/
[vcs]: https://github.com/AndrewKvalheim/middleman-vcs-time
[bt]: https://www.bridgetownrb.com/
[ms]: https://github.com/middleman/middleman-syntax
[holiday]: https://holidaycss.js.org/
[fa]: https://fontawesome.com/

I thought some would be interested in my blog "refresh" story. It's got several yaks that needed everything from a light trim to a buzz-cut/rogaine special.  Like any good technical project rathole, I started with a dependency update...

This roughly 3-year-old site is a static site built with [Middleman][mm] because I prefer Ruby, HAML, and Markdown. I wrote a few helpers, including a moderately interesting one for [json+ld][ld]. I knew I wanted to do some restyling eventually. I needed to do a `bundle update` and to see what needed to change in the "guts" before getting to the markup/CSS.

Middleman updated to 4.5, HAML to 6.x, and I moved to Ruby 3.2.2. I then ran into a couple of intertwined problems with plugins and HAML. That led me to reconsider Middleman.

[Bridgetown][bt] was the obvious next stop. But after a week of wrestling with its HAML support, I gave up. It wasn't hard to migrate the content, but without full support of HAML components, I was building lots shim Liquid templates to keep most partials in HAML. It felt exactly like the type of work I would want to rip out later. It made more sense to me to stay with Middleman and fix the issues I'd found.

The dependency problems were with two plug-ins. I was using [middleman-vcs-time][vcs] for getting published times for feeds and json+ld. That plug-in has been archived, so I moved to `File.mtime` for now.

Next was [middleman-syntax][ms] which has some problems with HAML 6. Without a fix, I deferred this and jumped ahead.

I had to make two changes for HAML 6 - `succeed` (thankfully) is gone, so I moved to string concatenation. I had a couple of places where I needed unescaped strings (thanks `!=` !) (see again, [json+ld][ld]).

I knew I wanted to clean up my HTML to ASAP - As Semantic As Practical - so I did some research into classless CSS resets and settled on [Holiday][holiday]. It has some very nice, sensible defaults, making the kinds of changes I wanted to make clean and simple. This let me kill all of my old CSS, including my [FontAwesome][fa] version-4-era self hosting, instead moving to their JS-based hosted free solution.

Next up was a bunch of cleanup of layouts, HTML, and thus CSS. I had a few design changes I wanted to make that drove this. This was a lot of iterative tweaking, but I think my layouts and component partials are better factored than before. More deleted files!

During the restyling, I found that even with Safari's Responsive Developer Mode, the media queries aren't _quite_ right. This meant having the iPhone and iPad around with a cable for working the Console from my desktop for element inspection. You have to install the full Xcode to do this, but it is worth it.

All that done, I took a look at how I was customizing and configuring Middleman. I changed how I store and build my blog series (a custom collection). I do want these presented a little differently, and I had over-complicated them before. Now the series introduction page\s are just in Markdown, like other articles/posts, and share a simple HAML template.

Next up - the motivator for all of this work - was tweaking my resume. Before my resume was in HAML. I wanted to move this to (nearly) 100% Markdown to make maintenance easier. And I got there by making a custom HAML layout, which allowed me to move the social links (using Font Awesome) from HTML-in-Markdown to HAML.

I was using RedCarpet for Markdown-to-HTML because it's what `middleman-syntax` recommended. RedCarpet doesn't support extended Markdown for HTML Definition Lists, which I use in my resume. Back to Kramdown (the Middleman default) for `<dl>`'s, installing [kramdown-parser-gfm][gfm] so I didn't have to convert all my syntax-highlighting in articles to `~~~` (and change my brain), and finding a Pygments CSS file I liked. All pretty easy, but I'm still not thrilled with how the syntax highlighting looks for Markdown, so I may be revisiting this later.

I version my resume with dates - this helps me personally and when talking with recruiters. Today this is manual and I wanted to make it automatic. Back to the resume HAML layout, where I added a line to shell out and get the last git commit date of the resume Markdown file with

`git log -n 1 --pretty=format:%cs -- FILENAME`

Then I added a step to my `rake`-based build and publish that fails if there are uncommitted files. I should've done that ages ago.

After all this work, I'm pretty happy with the result. I learned a bit. Solved some puzzles. Cleaned up some redundancy and poor factoring.

I still have a handful of small things to do that I'll work on as snacks here and there. A dark mode for CSS, fixing the most-recent-update date on articles using the git commit, some helper refactoring...

Was this yak shaving? Absolutely. Was it fun? Also absolutely.
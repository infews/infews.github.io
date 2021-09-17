---

title: "Job Search Journaling with Obsidian - updated"
date: 2021-09-17 21:36 UTC
tags:
  - obsidian
  - productivity
  - "job search"
keywords:
  - obsidian
  - notes
  - lifehack
  - productivity
  - "job search"
series: "Obsidian"
teaser: "A small update to my Obsidian Notebook and templates for tracking a job search"
---

[gh]: https://github.com/infews/job_search_in_obsidian/releases
[obs]: https://obsidian.md
[jobs]: /my-obsidian-for-a-job-search/

I wrote an article a few months ago about how I was using [Obsidian][obs] to take [copious notes during my job search][jobs]. It covers research into companies, connections in my network, and keeps true to Obsidian daily notes patterns. I've kept up the practice and it has served me well. But I found a small tweak I wanted to share.

Interestingly, a company that had turned me down early in my search got back in touch about a new role. When letting you down, internal recruiters always say, "We'll keep you in mind in the future!" I've always written this off as "nice," but here we are, several months later, and I have a re-screen/catchup chat on the calendar. Quick! To Obsidian!

I immediately ran into a problem. It was harder than I expected to walk the timeline of all of the different calls, meetings, and emails, refreshing my memory. Information was scattered around my daily notes, my per-company-note, and random notes here and there. Even with search and unlinked mentions, it was not easy at all.

## Problems to Solve

An interview cycle with a company is a series of interactions that need to be tracked in "one place" for easy retrieval. This system needs to make it easier to:

- Have a complete view of all interactions with and about the hiring company
- Know when interactions happened
- Retrieve the notes at each interaction
  - Notes I take during a call
  - Key points from emails (e.g., next steps, rejection details)
  
## A Solution

My daily note template has a Calendar section. On the day of a meeting, I will have a heading in that section like this:

```markdown
# Calendar

## 0230p Christina @ [[Everything Imaging]]

(notes from this call go here)
```

That Obsidian link goes to the Company research note.

The Company research note, then has the backlink to the daily note in a new section labeled Timeline:

```markdown
# Timeline

- [[2021.08.05]] Screening Phone call with Billy
- [[2021.08.17]] Christina interview via Zoom
```
## The Files

The repo & files live in "Release 2" at [GitHub][gh]. 

The changes:

- The research template now has the "Timeline" section (replacing "Application")
- Added how to use this section in a few places.
- Renamed the company/role note as "Research Note"






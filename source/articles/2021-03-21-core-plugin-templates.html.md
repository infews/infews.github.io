---
title: "Core Plugin: Templates"
date: 2021-03-21 16:12 UTC
tags:
  - obsidian
  - productivity
keywords:
  - obsidian
  - notes
  - lifehack
  - productivity
series: obsidian
teaser: "DRY up your notes."
---

I enabled the Core plugin for Templates. This allows you to specify a directory of templates - just Markdown files - for when you create new notes.

You get a new button on the left gutter called Insert Template for inserting templated text.

- Create a new file
- Optionally name it
- Click the __Insert Template__ button

When you click this button, Obsidian asks you which template to insert, shows you a searchable list of all of your template files. Pick one and it's inserted.

The main option is a directory to hold your template text notes. I have named my template directory `_templates_` so the folder pops to the top of my Notes tab. I keep it closed so I barely think about it. I've named each template `_Template<topic>` so they are differentiated in any file list.

There are a few variables it will evaluate, including inserting the title, date, and time, for customization.

And yes, the Daily Journal plugin is fine with the daily template living in this directory.

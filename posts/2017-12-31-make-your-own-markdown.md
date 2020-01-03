---
title: 'Make Your Own Markdown'
excerpt: 'An exploration in parsers to make my own version of Markdown'
tags: Clojure, Parsing, Markdown
date: 2017-12-31
---

I started a project using Markdown, which I love, for entering a lot of text that will be published to the web. The problem that I ran into is that this text requires more than the basic formatting that Markdown provides. Some blocks of text need to be indented and others do not. Plus there features of Markdown that I do not need, like ordered lists. In this particular text the numbering of list items does not start over with each chapter, so I would rather not have Markdown touch it at all. Furthermore, I would like to conditiontally add classes and ids to elements so that I can do more formatting with CSS.

So I went in search for a solution. I looked for Clojure projects that parsed Markdown. Why Clojure? Good question. Due to its data-centric nature, I was reasonably sure that after parsing Markdown, the result would be Clojure's basic data structures that I could inspect and modify before sending them to be converted to HTML.

I found two interesting projects [Hitman](https://github.com/chameco/Hitman) and [klobdown](https://github.com/danneu/klobbdown). What made them particularly interesting was that they used the awesome [Instaparse](https://github.com/engelberg/instaparse) library to create a grammer which parsed the Markdown. I have been wanting to play around with this library for quite a while. Once I looked at the code of the two parsing projects, I realized that it would be quite easy to write a parser for my own, custom-version of Markdown. The resulting project is on github: [Make Your Own Markdown](https://github.com/monjohn/make-your-own-markdown)

You can read the code for yourself (I leaned quite heavily on [klobdown](https://github.com/danneu/klobdown) ), as the whole thing is only about 150 lines of code, including a basic html page provided by hiccup. But I'll highlight a couple of choices that I made here.

1. I want to minimize my key strokes, so I chose to use a single `*` for to wrap bold text and a single `_` for emphasis.

2. I added support for tables, which isn't a part of the original Markdown spec. I wanted to be able to have line breaks within table cells, but the linebreak character `\n` is used to mark the end of the table row. So I added a special character to break a line: `~`. I know I could have used `<br />` but that is just ugly to me.

3. I left out syntax highlighting or any code blocks at all, since there is no code in the text. I left out lists.

4. I created a new block based on whitespace. If a line begins with text, it is wrapped in a `<p>` tag. But if it begins with a spaces, it is handled differently. It is wrapped in a `<div class="level-n">` where _n_ is the number of spaces at the beginning of the line. That way I can have more control over the layout using CSS.

All of this was surprisingly straightforward. I would encourage you to create your own Markdown parser. The [Instaparse](https://github.com/engelberg/instaparse) documentation is really good. I had way-too-much fun writing mine.

On github: [Make Your Own Markdown](https://github.com/monjohn/make-your-own-markdown)

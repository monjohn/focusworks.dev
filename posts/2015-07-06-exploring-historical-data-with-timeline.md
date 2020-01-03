---
title: 'Exploring Historical Data With a Timeline'
tags: timeline, "data visualization"
date: 2015-07-06
image: timeline.jpg
---

"There is so much information! How can we make sense of it all?"

Such is the cry of our day and age as our ability to capture and track data grows by the day. But this is not a new problem. In fact, it is a problem that is as old as time, by which I mean recorded time, or history. The study of history reveals so much data. The more you delve into a particular time period, the more you find. Making sense of this data has been the task of historians. But it is also the task of history students.

I have been thinking about how we might use visualization techniques to aid in the understanding of history. The obvious place to start is the timeline. Timelines serialze the events, which is helpful. However, when filled up with data, they can be little better than solid blocks of text on a page, provoking the same feeling of information overload. I recently ran across a design principle, called, [Shneiderman's mantra](http://www.ifp.illinois.edu/nabhcs/abstracts/shneiderman.html), which states:

Overview first, zoom and filter, then details-on-demand

This seemed to be a very helpful guideline in presenting overwhelming amounts of data. Give the big picture first so that it can provide context. Zoom in on the smaller segments, filtering as appropriate. Then give details when desired.

I decided to implement this with data of all of the Nobel Prize winners, like a software sketch to try out ideas, testing their possibilities and limits.

You can see the [results here.](http://monjohn.github.io/nobel-laureates-timeline) or the [source on github](https://github.com/monjohn/nobel-laureates-timeline)

I tried following Shneiderman literally at first, using the year as a heading and listing all of the categories for that year, with their corresponding winners. This would show all of the information with the opportunity to filter the results. But there was just too much data! I figured that the title of the page, the filter buttons and the timeline gave enough of an overview and context, so now the user initially sees the data filtered by the category of physics.

The zooming feature proved to be the trickiest. I experimented with having more data appear when hovering over the one of the laureate, with a click/touch taking the user to the full Wikipedia page. This worked reasonably well, but I didn't like that it would be useless on touch screens. So I went with having more text appear on click/touch with a link that would take the user to the Wikipedia page for the full details as well as other opportunities to explore their work more deeply.

In general, I was happy with the results. This type of timeline was a decent fit for the data. With a bit more scraping from Wikipedia, I could have added photos to the detail information in order to show the winners as real people. It would also be very interesting to find ways to show connections among the laureates. This could be things they have in common like gender or geography, or the ways the the work of later winners builds upon earlier ones. Maybe next time.

## Limitations

There were definitely limitations to consider when pursuing this type of project.

While filtering provided a way to limit the data, there is no way to pull back and take in the whole set. It is not clear how much this would help, since the user would just see a succession of years.

The Nobel Prize data is somewhat unique in that each event is discrete and regular, given on one day each year. But other historical data is better represented as a span, rather than a point, of time. This might be a lifespan, an ongoing event like the length of the Constitutional Convention, or an era of history like the Renaissance. Such spans would provide valuable context for individual events. This would require a different format, likely a horizontally-oriented line rather than a vertical one.

### Data

For data I used the api provided by the [Nobel Prize website](http://nobelprize.readme.io/v1.0/docs/laureate) to get the list of names, the year and category of their award, the motivation, as well as the id number assigned to them. I then scraped the Wikipedia pages for each laureate, taking the introductory paragraph, which gave the "zooming" information.

### Tech Used

I wrote the site in ClojureScript, using core.async for events, and Quiescent, a wrapper around Reactjs for the display. This made the filter super easy as you just filter the data in the model and React displays the right data. I also used [Boot](boot-clj.com) the build tool for the first time and found it quite pleasant.

Majore hattip to [Sebastiano Guerriero](http://codyhouse.co/gem/vertical-timeline/) for the design work. I love the responsive design.

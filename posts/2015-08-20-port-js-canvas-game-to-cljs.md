---
title: "Port Js Canvas Game to Cljs"
tags: "JavaScript", "ClojureScript", "Game Development"
date: 2015-08-20
---

I wanted to explore making game development on canvas in the browser. I found this nice introduction by James Long, [Making Sprite-based Games with Canvas](http://jlongster.com/Making-Sprite-based-Games-with-Canvas). I have also been toying with the idea of writing an introduction to ClojureScript for JavaScript developers (coming soon to a blog near you), so I thought that it would be useful to port of the game in ClojureScript. The two versions would provide an simple way to compare the symantics and syntax of the two languages in functionally equivalent code. The results are [in this github project](https://github.com/monjohn/canvas-game-in-cljs).

There are comments throughout the code but I thought that it would be useful to point out some of the contrasts which define the two languages.

### Organization

At the top of a cljs file you have a namespace declaration (ns) as well as a list of other namespaces which are required as a whole or just specific funtions. This is much like modules that are coming with ES2015.

{% highlight clojure %}
(ns game.app
(:require
[clojure.browser.event :as e][clojure.browser.dom :as dom]
[html5game.resources :as resources]cljs.core.match :refer-macros [match]]))
{% endhighlight %}

This code declares the game.app namespace and requires code from other namespaces. You can import a single function (or macro) as in the last example, or all of the functions in the namespace by calling them with their namespaced-qualified way, e.g. 'e/listen'.

Both files set up the canvas. After that, the order of the functions differ markedly. JavaScript has variable hoisting, so the order in which functions are defined is flexible; this is not the case in ClojureScript. Therefore, functions that call other functions, such as the main loop are located at the bottom of the file. The other difference is that I choose to group rendering code and updating code respectively. This achieves a separation of concerns and was born out of desire to keep all render functions pure.

This drive toward functional programming led to the biggest change in design, that is, keeping the state of the program in a map, and passing that around. This avoids global mutable state and all its inherent problems. This is why most of the functions take 'state' as their only parameter.

{% highlight clojure %}
(defn update-entities [state]
(let [dt (:dt state)]
(-> state
(update-in [:player :sprite] update-sprite dt)
(update :bullets update-bullets dt)
(update :enemies update-enemies dt)
(update :explosions update-explosions dt))))
{% endhighlight %}

There are many more comments in the code itself, highligthing other differences. All in all the project was quite fun and informative.

You can play the final result [here](https://github.com/monjohn/canvas-game-in-cljs/blob/master/resources/index.html).

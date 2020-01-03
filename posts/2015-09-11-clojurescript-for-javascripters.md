---
title: 'ClojureScript for JavaScripters'
tags: ClojureScript, JavaScript, cljs
date: 2015-09-11
---

**Goal:** To provide an introduction to ClojureScript for JavaScript developers -- particularly those who have not had much exposure to a lisp or functional programming -- giving an overview of a lisp, immutable data structures, and describing ClojureScript relationship to JavaScript Libraries such as the Google Clojure Tools, Facebook's React, and JQuery.

### Why Should You Care?

I want to introduce the language of ClojureScript to you. "Why should I care," you ask.

Sheer curiosity is sufficient. But if not...

JavaScript has been synonymous with front-end development. If you didn't write plugins like Flash or Java, you needed to write JavaScript. But this is changing. JavaScript is becoming a compile target for other languages. This ranges from something very close to JavaScript like CoffeeScript to the Haskell-inspired Elm. These other languages are having an impact on the language (CoffeeScritp) as well as on the major libraries, as we will see in the case of ClojureScript and React. Plus, ClojureScript has some great features that can change the way that you write JavaScript.

### What is ClojureScript?

Rich Hickey first released Clojure in 2007. He took 2 years to design the language before he built it. Compare this to the 2 weeks that Brandon Eich was given to create JavaScript, resulting in a lot of odd quirks of the language. Clojure incorporates so many lessons learned from other languages.

Clojure is lisp that runs on the JVM, the Java Runtime, and so is able to utilize all of the Java Libraries. The advantage is that this new language automatically runs wherever you can run Java, which is on servers, on Android, in large corporations, in Minecraft, you name it. Very practical. In writing a new language, Rich Hickey wanted to be able to take advantage of all of the tools and the the thought and hard-work that went into creating the Java ecosystem and runtime.

Then in 2011 Hickey and his collaborators announced ClojureScript, which is essentially Clojure code compiled to JavaScript. Why?

> Why are we doing this? Because Clojure rocks, and JavaScript reaches.
> — Rich Hickey

With JavaScript going everywhere, compiling to JavaScript enables ClojureScript goes everywhere. The philosophy is the same: write Clojure with the ability to fully leverage the JavaScript ecosystem, including libraries, tools, runtime environments, etc. So, you can use JQuery from ClojureScript, for instance.

So Clojure and ClojureScript are not two different languages. They are like one language that target different platforms. So unless you are dealing with interop, like dealing directly with the DOM, you just write Clojure.

### Try it Out

If you would rather experiment first and read later, go to [www.tryclj.com](www.tryclj.com).

The Clojure community values repl-driven development. Think about this like the console in your browser. This is where you keep open a REPL and play around with code until you get it right. It encourages experimentation and play.

You can experiment with a ClojureScript REPL [online](clojurescript.net), on [an iOS devise](https://itunes.apple.com/cn/app/replete/id1013465639?l=en&mt=8), on [OSX](https://github.com/mfikes/planck) with `brew install planck` and `planck` in the terminal. If you are on Windows or Linux, then you can get a Clojure or ClojureScript REPL using [Boot](http://boot-clj.com) or [Leiningen](http://leiningen.org).

### Data Structures

Let's dive in.

Traditionally, lisps had a very limited set of data, all with the parentheses-syntax. ClojureScript has a few more, very well designed, data types, some that use curly braces and square brackets which make it easier to read the code and distinguish the various types.

    {% highlight clojure %}
    ; comments are denoted by the friendly semi-colon
    "homoiconicity"      ; String
    true, false          ; Boolean
    1                    ; Integer
    1.0                  ; uses JavaScript’s floating-point
    :first-name          ; Keywords, often used as keys in a Map
    [1 "A" :a]           ; Vector (like a JavaScript Array)
    {:first "John"       ; Map, an associate data structure
     :last "Calvin"}
    address              ; Symbol, resolves to values
    (1 2 3)              ; List
    (fn [x] x)           ; Functions
    ,                    ; Commas are treated as whitespace. Awesome!
    {% endhighlight %}

ClojureScript is a relatively small language, whereas JavaScript keeps getting bigger, with new syntax and new semantics. But more importantly there is a great consistency in how you manipulate the well-designed data structures. There is so much more to say about Clojure's data structures, but I don't need to repeat what [has already been written so well](http://www.infoq.com/articles/in-depth-look-clojure-collections).

### Those Crazy Parens

I do want to talk about the venerable list, denoted by the paired parentheses, because this is what you see most often in a Lisp, and ClojureScript is a Lisp.

    {% highlight clojure %}
    (partition-by odd? '(1 1 1 2 2 3 3))
    ;returns ((1 1 1) (2 2) (3 3))
    {% endhighlight %}

The word 'lisp' is a contraction of list processing -- and that is important. The fundamental structure of the language is the list, enclosed in parentheses. The most important feature of lisp is that the list is not just a data structure in which you can keep a series of data, it is also the **form** of the code. You write your code as a series of lists that get evaluated. So in the code above, you can see both uses. There is the list of numbers: 1, 1, 1, etc, as datastructure. There is also a list as the form for code. In a lisp, the first element in the list is taken to be the name of a function, which is called with the remaining elements of the list as arguments.

This is called _homoiconicity_. This is the takeaway to impress people with your esoteric vocabulary.

> Homoiconicity: code = data

This is where so much of lisp's power comes from, because it enables macros. I am not going to get into them here, but macros allow you to manipulate your code, before it gets evaluated, allowing you to write some simple syntax, which can then get combined into something quite complicated. Let's see the lisp in action:

    {% highlight clojure %}

(+ 1 1) ; evaluates to 2
(= 1 2) ; false
(+ 1 (\* 5 6)) ; expressions can be nested and are always evaluated from the inside out
{% endhighlight %}

So in this example, which probably looks a bit odd, with its prefix notation, the '+' sign is symbol that resolves to an ordinary function. There are no operators. Each list is an expression that is evaluated and returns a value. In the last example above, `(* 5 6)` is evaluated and the result is returned and used in the evaluation of the outer expression. _There is no return statement. The last expression evaluated is returned._

    {% highlight clojure %}

; Defining functions
(defn palindrome? [s]
(= s (reduce str (reverse s))))

; You call the function in the following way:

(palindrome? “kayak”) ; returns true
{% endhighlight %}

What is going on here? We are defining a function, called palindrome?, which takes a string and tests whether or not it is a palindrome. The first thing that the function does is to reverse the string 's' (remember, evaluate inside out). The output of `reverse`, which is now a sequence, becomes the input of the `reduce` reduce function, which takes a function and a sequence and uses the function to gather up a single return value. The 'str' function makes a string out of its input. This string is now passed to the '=' function to check if the reversed string is equal to the original.

### Functional Programming

As evinced in the previous example, ClojureScript is a functional language. There is no exact definition for what makes a language functional. But there are a family of features. Javascript has many of them, such as functions as a first-class data type that you can pass to functions, return from functions, assign to variables, and call. There us also the tendency to operate on collections using map, reduce, filter. Libraries like underscore.js and lo_dash help with this.

## Immutability

Look at the following code. What is the value of x[0] at the end?

    {% highlight javascript %}
    // JavaScript
    var x = [5]
    process(x)
    x[0] = x[0] + 1
    ; What is the value of x[0] now?
    {% endhighlight %}

You don't know, because you don't know that the function called process does?

The reason is that x is mutable. It points to a memory address on your computer. And so if you ask for x, it goes and gets whatever _value_ lives at that address. Does the function 'process' change the first item in the Array? There is no way to know.

In ClojureScript you program with values. And so data structures are immutable. So x does not point to a memory address. It is bound to this array whose first element is 5. The value does not change.

    {% highlight clojure %}

(def a [5]) ; no assignment operator, like '=', only functions.
(def b a) ; assigns the value [5] to b
(update-in a [0] inc) ; updates the first element in 'a' by incrementing it
b ; returns [5]
{% endhighlight %}

Test yourself by comparing these two examples from JavaScript. What is the value of b at the end of each code snippet?

    {% highlight javascript %}

var a = "immutable";
var b = a;
a = "value";
b // what is the value of b?
{% endhighlight %}

    {% highlight javascript %}

var a = [5];
var b = a;
a[0] = 6;
b // what is the value of b?
{% endhighlight %}

Why? In the first snippet, b = "immutable". Changing 'a' did not change 'b', because a string is immutable. Whereas in the second example 'b' has been changed to 6 because Arrays are mutable. Strings are immutable and Arrays are not. In ClojureScript, all of the most-often-used data structures are immutable. There are some that are mutable, but you have to be intentional about using them.

### So what?

Why does this matter? Immutability gives predictability. It is easier to reason about your program because you can keep in your head what is it is doing. You know that a variable that you are using is not being changed by some callback that you don't expect.

It is often said and commonly understood that global state is a bad thing. Immutable values help you avoid that. But there is more.

You have heard of the React library. It is a declarative approach to the DOM. There are several ClojureScript wrappers to the library. Not long after it was released, star ClojureScript developer David Nolen announced that his library wrapping React was 2 - 3 times faster than plain JavaScript. How is that possible? Immutable data structures. That's how.

If you want the gritty details...

> Using immutable data structures for the application state means that reference equality can be used for the shouldComponentUpdate implementation of the underlying React library. This improves the performance of React’s Virtual DOM diff operations, a process performed to detect changes that need to be rendered by the browser. This results in the application's performance being two to three times quicker than using standard data types, according to David.
> -- http://www.infoq.com/news/2014/01/om-react

Facebook's explation of this in their documentation of their Immutable.js library is quite good. They also cover two other ideas in ClojureScript, laziness and seq.

### Simple Is Not Easy

Before moving on, I do want to say that this: learning to program with immutable data structures is a challenge. They force you to think about problems and solutions differently. For instance, compare processing some collection of objects in JavaScript with a for loop:

    {% highlight javascript %}
    // JavaScript
    var x;
    for (var i; i < coll.count; i ++) {
        x[i] = doSomethingWith(coll[i]);
    }
    {% endhighlight %}

You create a new variable 'x' and you mutate is. Now see the ClojureScript.

    {% highlight clojure %}
    ;; ClojureScript
    (map do-something-with coll)
    {% endhighlight %}

There is no assignment of new variables, which is more succinct and clean.

But once to you change your thinking, the result is worth it. I have often read statements from people that write Clojure or ClojureScript that when they return to other languages, the thing they miss most are the data structures.

### Google Closure Tools

ClojureScript has to be compiled to JavaScript obviously. The tool that it uses for the job is significant. It is part of Clojure's philosophy to enable the use of the best tools in the ecosystem. So ClojureScript uses the Google Closure Compiler to generate JavaScript.

(Notice the spelling difference. This has thrown me off a number of times. Clojure is something of an acronym, while Google borrowed a term from computer science.)

What is Google Closure? Here is the description from the [wiki](https://github.com/clojure/clojurescript/wiki/Google-Closure):

> The Google Closure tools provides a robust set of libraries, a strong dependency management system, and a sophisticated compiler each working toward an ultimate goal of reducing JavaScript code size. For ClojureScript, Google Closure provides a solution to the "library problem" for JavaScript in three distinct ways:

- Libraries
- Dependency management
- Aggressive code minification

The **libraries** are a large set of functionality developed by Good and used by Google on many of their products (Gmail, Docs, etc). It has utilities for DOM manipulation, server communication, events, and more, and it does so in a cross-browser-compatible way. This serves much of the role that JQuery plays for much of the JavaScript community.

Closure offers **dependency management** through its 'require' and 'provide' functions. You can read about it [here](https://developers.google.com/closure/library/docs/introduction?hl=en), but you don't need to call them directly because the system is used to implement ClojureScript namespaces.

The library offers **minification**, but that massively understates what it offers. There are several options for minification in the JavaScript world. The GC provides dead-code removal. The compiler analyzes your code and if functions are not called, they are no included in the output file. Period. You are simply not sending unused code over the wire to your app.

This is an awesome feature! Why isn't everyone using it? Because you have to write your JavaScript in a certain way so that the compiler can consume it. It's not fun or pretty. The good thing is that ClojureScript handles this for you. It compiles your code into Google Closure-compatible code, so you don't have to.

### Interoperation with JavaScript

One of the goals of the ClojureScript is to be able to take full advantage of all of the JavaScript libraries. Here is a snippet of code to show using some of the Google Closure Library and interop with the DOM.

    {% highlight clojure %}
    (ns cljsworkshop.core
      (:require [goog.events :as events]
            [goog.dom :as dom]))
    (defn main []
    (let [counter (atom 0)
        button  (dom/getElement "button")
        display (dom/getElement "clicksnumber")]
    ;; Set initial value
    (set! (.-innerHTML display) @counter)
    ;; Assign event listener
    (events/listen button "click"
                   (fn [event]
                     ;; Increment the value
                     (swap! counter inc)
                     ;; Set new value in display element
                     (set! (.-innerHTML display) @counter)))))
    (main)
    ;; Taken from https://www.niwi.nz/cljs-workshop/ from 6.4
    {% endhighlight %}

For a more extended comparison, I have ported a simple JavaScript game to ClojureScript, with notes, so you can compare implementations. You can [find it here]({% post_url 2015-08-20-port-js-canvas-game-to-cljs %}).

## Language Features

We are getting down to some miscellanies. I was reading about new features that are coming to JavaScript in ES2015 and beyond. It occurred to me that many of them already exist in the standard library of ClojureScript:

- let - local variable scope - (let [x (rand)] (odd? x))
- Set - data structure - #{1 2 3}
- modules - ClojureScript has namespaces - (ns myapp.main)
- rest ... - variable number of parameters - [x & rest]
- spread ... - `apply` in class - (apply max [1 2 3])
- destructuring - ClojureScript has it - [[x y] point]
- promises - core.async, like go-blocks in Go Lang, is such an awesome way to handle writing asynchronous code as if it is synchronous.

### Benefits of Homoiconicity: Macros

One of the chief benefits of homoiconicity is the power that they give to macros. Macros are able to rewrite code before it is evaluated. This enables you to write cleaner code.

The following JavaScript code uses the 3 functions that put the function in functional programming: map, reduce (sometimes called 'fold'), and filter.

    {% highlight clojure %}
    ; map, reduce, filter in JavaScript
    ;
    ; lets take a collection of numbers, square them, filter out the odds and ; sum the result
    [1, 2, 3, 4, 5, 6].filter((num, i, coll) => {
            return num % 2;
        }).map((num) => {
            return num * num;
        }).reduce((total, num) => {
            return total + num;
        }, 0);
        {% endhighlight %}

Here is the same code in ClojureScript. Remember to read it from the inside out. To my eye it sure looks cleaner.

        {% highlight clojure %}
    ; map, reduce, filter in ClojureScript
    ; take collection of numbers, square them, filter out
    (reduce +
        (map (* 2)
            filter odd? [1 2 3 4 5 6]))
            {% endhighlight %}

But, until you get used to it, there is something odd about reading inside-out, because it feels like you are reading backwards. Enter the 'thread-last' macro, which looks like this: ->> It threads the result of each expression and inserts it as the last parameter of the next expression. Here is the same code but with the 'thread-last' macro.

    {% highlight clojure %}
    (->> [1 2 3 4 5 6]
        (filter odd?)
        (map (fn [x] (* x x))
        (reduce +)))
        {% endhighlight %}

It reads left-to-right, top-to-bottom, and is a lot cleaner than the JavaScript, at least to my eye.

For an even better argument for the power of macros, check out [core.async](http://clojure.com/blog/2013/06/28/clojure-core-async-channels.html), which is made possible, as a language-level feature, entirely by macros.

## Resources

No blog post could adequately cover a language. Heck, most books devoted to a language cannot cover them all. So here is a list of resources to take you further.

- https://github.com/clojure/clojurescript/wiki -- many, many resources
- http://cljs.info – a community site that is quickly increasing in awesomeness

### Videos

These are videos where Rich Hickey explains the design decisions and what they enable:

- http://www.infoq.com/presentations/Value-Values - the value of values
- http://www.infoq.com/presentations/Simple-Made-Easy-QCon-London-2012 simple made easy
- http://www.infoq.com/presentations/Are-We-There-Yet-Rich-Hickey

If you made it to the end, congratulations. Let me know if you have an questions about things that were not clear, or corrections for anything that I may have gotten wrong.

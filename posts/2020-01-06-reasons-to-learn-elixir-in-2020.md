---
title: 7 Reasons to Learn Elixir in 2020
date: 2020-01-06 10:03:14
tags: Elixir
---

I love learning things. The struggle, then the "Ah ha!" moment. It's great. This is what makes programming so great – and often frustrating – there is always more to learn. If you are like me, I want to suggest that you learn Elixir in 2020. The reason is that within this one language and its ecosystem there are a number of different concepts, ideas, and patterns that present new things. And, learning things that are related to one another makes them easier to grok and easier to remember.

So here are seven reasons to learn Elixir.

## 1. Functional Programming

Most of the mainstream programming languages out there are object-oriented, so chances are, you are coming from one of those. If object-oriented is all you know, then it can seem like the only solution. But functional programming has been around as long and has many great benefits. Granted, there is no single definition of functional programming. It is more a collection of ideas and patterns that exist in a family of languages.

Some people equate functional programming with a rigid type system that is enforced at compile time. Think Haskell. These languages can be quite intimidating, although languages like Elm are making this less so. But there are many functional languages out there that are dynamically typed. Elixir is one of those.

The dangers of global, mutable state have become increasingly acknowledged. It makes programs more complex and hard to reason about, which then equates to bugs. To me, functional programming is about writing code in such a way as to be very intentional about mutation and side-effects. Most of the time, in functional programming, you write functions that take data in and return new data out, also known as pure functions. [Here's a great blog post](https://lispcast.com/global-mutable-state/) if you want to read more.

Elixir is great at this. It only has immutable data structures, so you can't have global mutatable state. Programming in Elixir will teach new valuable practices that will save you many headaches.

## 2. Phoenix

[ Phoenix ](https://www.phoenixframework.org/) is to Elixir as Ruby on Rails is to Ruby. It is a framework to build web applications. You may have strong opinions about using a framework versus a collection of libraries (an argument that strikes me as pretty pointless in the abstract, but I digress). But, using a framework is a great way to see the underlying language in action. Rails leverages the power of Ruby to achieve all that it does. As you use it, you learn so much about Ruby that you can't get out of a book. So it is with Phoenix.

Using Phoenix will give you a feel about how Elixir programs are structured. You will see how to program with immutable data structures, using pipelines to flow data through the system.

## 3. LiveView

Ok, so this is cheating a bit because LiveView is actually part of Phoenix, but I wanted to call it out specifically.

On the web, we have two different paradigms. One, web pages served up to the browsers upon request (e.g. Rails or Django) or single page applications (SPA) written in Javascript that get a large initial payload and then update themselves by fetching data from the server (e.g. React or Vue). The tradeoffs are well-documented. [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html) stomps on that clear division.

With very little JavasScript you can achieve most of the benefits of an SPA, but still get all of the dynamism. LiveView does diffing on the state of the page, so that only those elements that have changed will get updated. So there are no full-page reloads and very little data is sent over the wire. How does it accomplish this wonder? Learn Elixir and find out. 😊

I have written a [Trello-clone using LiveView](https://phellow.focusworks.dev) if you want to see it in action.

[Here is an interview](https://player.fm/series/software-engineering-radio/episode-394-chris-mccord-on-phoenix-liveview) with its author, Chris McCord.

## 4. Ecto

[Ecto](https://hexdocs.pm/ecto/Ecto.html) is the library that Phoenix uses to interact with the underlying database, but it can be used without Phoenix as well. Ecto intends to be approachable. According to the authors of [Programming Ecto](https://pragprog.com/book/wmecto/programming-ecto):

> “The query syntax was inspired by LINQ in the .NET framework. The migrations and relation syntax feel a lot like ActiveRecord. Depending on the libraries you’ve used, you’re likely to find parts of Ecto that will make you feel at home. The Ecto developers have tried to bring the best of what has come before, while avoiding some of the known pitfalls. Hopefully, your progress through learning Ecto will be met with responses of “oh, this feels very familiar,” and “wow, that solves a problem that’s been bugging me for years!”

One really interesting aspect of Ecto is the changeset. Changesets are a very flexible way to validate and update data, that also maintains information about the process along the way.

You should definitely check it out.

## 5. Concurrency

One of the main motivations of José Valim to create Elixir was the desire to take advantage of multiple cores on a computer since that is the chief way that computers are trying to get faster. He was working on the Rails core team, and struggling to get Rails to take advantage of more than one core, and struggling to do so. He went looking for other tools to tackle this very challenging problem. He discovered the Erlang programming language and it runtime, which uses functional ideas as well as the Actor model to get a handle on this problem. He build Elixir to run on the Erlang runtime and to take advantage of it.

I highly recommend hearing José tell his story [in this video](https://www.welcometothejungle.com/en/articles/btc-elixir-jose-valim#play-video)

I have read articles about the Actor model, but didn't really grok it. It was only when programming with Elixir that I really begin to understand it, and appreciate how simple it is. This is what learning Elixir can do for you too.

## 6. Nerves

IOT is definitely an exciting frontier now as small chips and computers are becoming quite cheap. The [Nerves Project](https://nerves-project.org/) is an Elixir framework for proramming and controlling embedded devices. The advantage of using Elixir for this again comes primarily from the platform. Erlang was written to run telephone switches for Erik. It was designed for systems with these traits: distributed, fault-tolerant, real-time, highly available, and non-stop applications.[1](<https://en.wikipedia.org/wiki/Erlang_(programming_language)>) This is pretty-much IOT in a nutshell.

If you want to know more about Erlang, there is [a really informative video](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=2ahUKEwij5ofwnO_mAhXDl-AKHX_DDlUQwqsBMAB6BAgKEAQ&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DSOqQVoVai6s&usg=AOvVaw3jUl1S2RBto1GYWdUZ1PNi)

So if you are interested in embedded computer, you won't find better tools than Nerves. It also has a very active community around it.

I haven't done anyting with Nerves yet, but I am hoping to this year.

## 7. Pattern Matching

Pattern matching is a feature of many functinal programming languages. It has shown up more recently in Javascript in [destructuring assignment](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment). Personally, I love it and miss it when writing programs that don't have it.

Elixir doesn't just support it, it is everywhere; it is central to the language. What is simple assignment of a value to a variable in another language, like `a = 1`, is pattern matching in Elixir. You should learn Elixir to get a feel for what pattern matching is like when turned up to 11.

## What now?

So that's it. You are convinced that you should learn Elixir and now you want to know where to start.

You can start learning on the [official site](https://elixir-lang.org/getting-started/introduction.html) for the langauge. The community puts a great value on documentatation.

There is also a [rundown](https://elixir-lang.org/learning.html) of books and other resources to guide you.

**Videos**

I find learning from videos to be very helpful. Here are two that I personally found to be helpful:

[Developing with Elixir/OTP](https://pragmaticstudio.com/elixir) These videos were so good at starting with basic concepts and using them to build up bigger ideas. The instructors to do a great job of pulling away the curtain to show that there is no magic going on.

[The Complete Elixir Phoenix Bootcamp](https://rallycoding.com/courses/the-complete-elixir-and-phoenix-bootcamp/) These videos teach an earlier version of Phoenix because it is a bit easier to understand if you are learning many new things, but the instructor is fantastic, a real master teacher.

Happy learning!

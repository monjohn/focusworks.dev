---
title: The Road to React and Redux
tags: JavaScript, React, Redux, ClojureScript
date: 2019-06-09
---

**This is an adaptation of a Lunch and Learn given for the developmet team at First.io. The purpose of the talk was to help engineers who don't do much frontend work understand the movement of the JavaScript community toward libraries like React and Redux. I am sharing it here in case it might be useful.**

# The Road to React and Redux

Back in the day, one of the largest challenges was writing code that would work across the different browsers. Enter JQuery. JQuery provided cross-browswer capatability in updating the DOM and making network calls.A common pattern was to take the data fetched from the internet and create DOM elements with that data. This worked well, but quickly became a mess once the webpage became more compliated, such as when the data was displayed in more than one place. At which point, updated data meant querying the DOM to find an update all of the places where that data was displayed. It is not hard to see how this could become quite unwieldy.

The problem here is how to deal with state, the data about the system at the current moment. Storing the current state in the view, which is what JQuery did, was not scalable. The next step were the MVC libraries, like Backbone. This design pattern had a history of success on the backend, e.g. Ruby on Rails. MVC stands for Model/View/Controller, where you try be clear and maintain the distinction in your code between the different concerns of the app. The Model here corresponds to the state of the app. The controller handles data access and the conversion of that data for the view. The advantage of this approach is the state of the app is handled explicitly and not stored in the view layer. The challenge that MVC libraries face is how to keep the model and view in sync. The model may change from user action or from a reponse from the network.

The next big advance came from Angular as it handled this synchronization through two-way data-binding. They achieved this by observing the state and observing the Dom and triggering updates to the keep everything in sync. This approach was not without its drawbacks. Views, which were called directives, were quite complicated. Also, updating could get quite expensive on things like large lists. Angular generated a great deal of momentum, such that Object.observe() looked like it was going to make it into Javascript itself. But before this happened, Facebook released React.

## React

React brought functional programming to the front-end. Instead of using observers for keeping the model and the view in sync, React invites you to think about it as a function that takes in data and gives you a view, just as a function from math, takes in input and outputs a value.

`f(data) => View`

The view becomes of a function of your data. Write your view function, pass in your data, and React would render the view. React accomplished this with some fancy diff'ing, so that they would only update the respective components, if the props changed. This led to dramatically increased performance. React uses the virtual DOM, and calculates diffs on the virtual DOM, dramatically cutting down the expensive operations of touching and updating the DOM. There is also the advantage of _composability_. The basic unit of React was the component, and the components were composable. This made it easier to structure a large app and provided reuseability.

# ClojureScript

The next change came from an unexpected front. The lead developer of ClojureScript, the version of Clojure that compiles to JavaScript, named David Nolen, made a wrapper around React. The surprising thing was that it was faster than plain React! How could a wrapper around something be faster? The answer was ClojureScript's immutable data structures. Most of the time you don't touch a React components' method, `ComponentShouldUpdate`, since that is where React's algorithms come in. But that is what David did, because it turns out that determining whether the arguments to the React component changed is really simple if you are using immutable data structures.

This result pushed the React community in a more functional direction. Immutable.js is pretty much a port of Clojure's data structures. React components relied heavily on having local state, but this mudied the waters again when it came to keeping state in sync. More recent efforts, like Elm, do not allow for the possibility of having local state on a component. React introduced Stateless components, which a shallow compare. You don't need a class with life-cycle methods, you can use a function that returns JSX.

React brought great improvements to the View part of MVC. But it didn't help much in managing state.

## Redux

Along came Redux. Redux does for the state what React did for the view. It makes the state a function of the props. It was inspired by Elm, but it is very similar to many functional frameworks. It is the natural result of avoiding global state, having immutable data structures, and not passing state through the app.

### Features of Redux

- Single source of truth, avoiding the challenges with synchronization
- State is read-only, avoiding global state
- Changes to the state are made with pure functions, called reducers

Redux maintains the reference to the current state of the app. It also provides a Dispatcher function. Call the function with an action, which is basically a message. Redux will then pass that message and the relevant data, along with the current state to each of the reducers. Each reducer has option of responding to the message and modifying the state, before returning it. These reducers are pure function, that are called with the action (message + data) along with the current state. They usually have switch statements in them with the different actions that they respond to.

### Cycle

1. User takes an action, and the view dispatches a message/action to Redux. This is often accomplished by a helper funciton..
2. The store receives the action and sends the current state tree and the action to the reducer.
3. Each reducer responds to certain actions, and returns a new copy of it's part of the global state.
4. The root reducer returns all of the state to become the new state
5. The view layer triggers a rerender, and the react components rerender accordingly

No solution is perfect and Redux is criticized for its verbosity. For his reason other solutions have attracted attention for state management such as MobX. The JavaScript community will continue to look for new and better solutions to the problem of building complex UIs, but hardly anyone will suggest we try to go back to a solution like JQuery, as good as it was.

---
title: 'Clojurescript vs Javascript'
date: 2015-05-19
tags: clojurescript, javascript, lisp
---

After spending a lot of time with Clojure and Clojurescript, I went back to coding straight JavaScript, because I wanted to try out React Native. And, I have to confess, the transition was a bit jarring. In reflecting on the the difficultly, I came up with a simple answer: simplicity. This shouldn't be surprising as it is one of the guiding values of Clojure. But for those that don't know Clojure I wanted to offer some specifics as to where the unneeded complexity made itself felt.

## Lists

Learning Clojure means learning lisp, and lisp looks different and is different. It was a eureka moment for me when it clicked. The basic unit of a lisp is the list. I felt a bit dumb later when I learned that the word, lisp, comes from a contraction of 'list processing.' But one keen advantage of this fact is predictability.

When Clojurescript, and other lisps, see a list, e.g. (square 2), it evaluates it with a simple rule: **treat the first symbol as a function and apply the remaining items in the list to it as arguments.**

{% highlight Clojure %}
(str "str is a function which takes any number of arguments "
"and concatenates them into a single string")
{% endhighlight %}

This is straight forward. But you can see how things get simplier if you take the expression `(+ 1 2 3)` . The '+' is a function like any other. It is not an operator as in JavaScript.

{% highlight Clojure %}
; semicolons begin comments
; The '+' function takes one or more arguments and adds them together so...
(+ 1) ; 1
(+ 1 2) ; 3
(+ 1 2 3) ; 6
; And this lists can be nested
(+ 1 (+ 2 3)) ; 6
{% endhighlight %}

The advantage is simplicity. There is less of a mental load when you never have to keep track of a separate type of things called operators and all of the different things that they do. There are Assignment operators, Comparison operators, Arithmetic operators, Logical operators, String operators, Comma operator, and Unary operators. Nor do you have to keep in mind their relative precedences. This has nothing to do with [weird parts](https://charlieharvey.org.uk/page/javascript_the_weird_parts) of JavaScript. In Clojurescript these are all functions. (Clojurescript does have macros, but for the most part you use them just as you would a function.) Simplicity makes it easier to anticipate what your program is going to do.

## Immutable data

A statement that I have heard many times from Clojure(sript) developers is, "If I had to code in another language, the thing I would miss most is the immutable data structures." In JavaScript strings and numbers are immutable. If you call `"wagon".concat("wheel")`, you will get back the new string, "wagonwheel" not a modified version "wagon". In contrast, if you append an item to an array, the array is modified or mutated. In Clojure(script) the regular data structures are immutable and so act like strings and numbers in JavaScript.

This too leads to better predictability. For example, I wanted to write a function to see if the elements of an array were a palindrome, they are the same both forwards and backwards. An easy way to do this is to make a copy and reverse it, then join the arrays into strings to compare. (It is much easier to compare strings because they are immutable.) Here is the code:

{% highlight JavaScript %}
function palindrome (letterArray) {
var arrayCopy = letterArray.reverse();
arrayCopy.reverse();
return arrayCopy.join("") === letterArray.join("");
}

palindrome(["a","b","c","d","e"]) // returns true
palindrome(["r","a","c","e","c","a","r"]) // returns true
{% endhighlight %}

This is obviously not the result I expected. Experienced JavaScript developers will see the problem: `var arrayCopy = wordAsArray` makes arrayCopy point to the same array. So both arrayCopy and wordAsArray both got reversed, because they refer to the same array, thus thwarting my efforts to compare them. The error is [a common one](http://www.markhneedham.com/blog/2009/01/07/javascript-dates-be-aware-of-mutability/). There are several ways to code this so it works[^1]. The point is that, if the array is immutable, you avoid it altogether. The whole thing would work just as with strings in JavaScript, which are immutable.

{% highlight JavaScript %}
var s = "string";
var t = s.toUpperCase();
s === "string" // true
t === "STRING" // true
{% endhighlight %}

For comparison's sake, this is what it would look like in Clojurescript:

{% highlight Clojure %}
(defn palindrome [letterArray] ;defines function
; since 'reverse' is the first item in list, it is called as a function
; 'letterArray' as argument, with the result is assigned to 'arrayCopy'
(let [arrayCopy (reverse letterArray)]
; finally '=' function is called and a boolean is returned
(= arrayCopy letterArray)))

(palindrome ["a" "b" "c" "d" "e"]) ;true
(palindrome ["r" "a" "c" "e" "c" "a" "r"]) ;true
{% endhighlight %}

## Statements vs Expressions

This last example brings us to the third point and that is statements and expressions. Statements in JavaScript are expressions which don't return anything: an 'if' statement, an assignment of a value to a variable, even a function. Unless you explicitly give it the 'return' statement, a function won't return anything.

In Clojurescript, there are no statements; everything is an expression. So in the last example, the last expression is automatically returned. Since the '=' expression returns _true_ or _false_, the function returns true or false. The advantage of this is being recognized as the new "fat arrow" anonymous functions automatically return the expression if there is only one.

Once again, simplicity leads to predictability. The less complexity there is in the language, the easier it is to keep focused on the goal, the functionality you are trying to write.

There is so much more to say and explore on this topic. But let's keep it simple.

[^1]: `var newArray = oldArray.slice();` makes a copy so you can alter the one and not other.

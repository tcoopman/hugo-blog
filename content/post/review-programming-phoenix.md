+++
draft = true
categories = []
date = "2016-06-26T10:49:59+02:00"
description = ""
keywords = ["elixir", "phoenix"]
title = "Programming Phoenix review"

+++

I read a lot of good things about Elixir and Phoenix, and some time ago I followed a tutorial on [building a web framework from scratch](https://codewords.recurse.com/issues/five/building-a-web-framework-from-scratch-in-elixir). Furthermore, I try to play a lot with Elm, and Phoenix with Elm is a very popular combination. So I thought it was time to jump in and read some more about why Phoenix is so hot right now.

So I bought [Program Phoenix](https://pragprog.com/book/phoenix/programming-phoenix) by 
by Chris McCord, Bruce Tate, and José Valim.

{{<figure src="/images/phoenix.jpg" title="Programming Phoenix" link="https://pragprog.com/book/phoenix/programming-phoenix">}}

I've just finished the book (from cover to cover) and I must say I enjoyed it. It's been a long while since I've read a book like this (about a webframework), because, for a webframework, I always wondered what the added value of a book was over some tutorials.

When I started this book, I didn't really know Elixir (I'm still far from being an expert!) but while reading the book I took some detours to explore the language a bit. The [getting-started](http://elixir-lang.org/getting-started/introduction.html) guide in combination with this book were a great start into the language. The Elixir language is great in that is fully functional, runs on the BEAM and is quit easy to get started with. I also has some quirks, I needed some time to get familiar and fluent with the syntax (especially if you compare it with something like Elm) and it has no static types (although [dialyzer](http://erlang.org/doc/man/dialyzer.html) could be a help with that - I haven't explored that yet). 

For me, the added value for this book is:

* Written by the creators of the framework and the language.
* So they show you the best practices and defaults of the language
* You don't have to search for good content, because you know it's written by the creators of the framework and the language. You get the best practices! Everything is bundled together with a solid example application.

My biggest critique with the book is about the testing. While the testing chapters are decent and they go deep enough. I do think that a test driven approach would have been better for some chapters (especially for the OTP chapters). You write quite a bit of code before you can see some results, and doing test first would probably help with the understanding. Although it's my biggest gripe with it, it's not too bad, mostly because of the great interaction with the elixir REPL.

The book covered all content that I wanted, except for deploying the application. Some pointers and best practices into that direction would have been really nice!

Overal a solid book and a good read. If you are interested in doing Phoenix programming, this is a very good starting point.

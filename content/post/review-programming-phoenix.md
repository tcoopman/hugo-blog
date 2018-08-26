+++
categories = []
date = "2016-06-26T10:49:59+02:00"
description = "A short review of the book Programming Phoenix"
tags = ["elixir", "phoenix"]
title = "Programming Phoenix review"
draft = false
+++

Elixir and Phoenix crossed my path multiple times last year. I read a really interesting tutorial on [building a web framework from scratch](https://codewords.recurse.com/issues/five/building-a-web-framework-from-scratch-in-elixir). Furthermore, Phoenix is really popular as an Elm backend, so I decided it was time to dive a bit deeper and learn myself some Phoenix.

It just happens that [Program Phoenix](https://pragprog.com/book/phoenix/programming-phoenix) by
by Chris McCord, Bruce Tate, and José Valim was published recently, so this seemed like a good opportunity to learn more!

{{<figure src="/images/phoenix.jpg" title="Programming Phoenix" link="https://pragprog.com/book/phoenix/programming-phoenix">}}

I enjoyed reading the book from cover to cover. It's been a long while since I've read a book about a web framework, because I always wondered what the added value of a book was over documentation and tutorials. But as this book is written by the creator of framework and the language, I didn't bother looking any further.

When I started this book, I didn't really know Elixir and while reading the book I had to take some detours to explore the language a bit. The [getting-started](http://elixir-lang.org/getting-started/introduction.html) guide in combination with this book were a great start into the language. Elixir is great in that is functional, runs on the BEAM (the Erlang VM) and is easy to get started with. On the other hand, I needed some time to get familiar and fluent with the syntax (especially if you compare it with something like Elm) and there a no static types (although [dialyzer](http://erlang.org/doc/man/dialyzer.html) could be a help with that - I haven't explored that yet).

The first part of the book explains the basic parts of Phoenix as a MCV framework and is what you would expect in a book about web frameworks. The second part covers the fun part of Phoenix, channels and concurrency with Genserver and OTP (read about this if you haven't!).
The second part really invites me to explore Phoenix and Elixir more!

My biggest criticism with the book is about testing. While the testing chapters are decent and they go deep enough. I think that a test driven approach would have been better for some chapters (especially for the OTP chapters). You have to write quite a bit of code before you can see the results. Doing test first would probably help with the understanding. Although the interaction with the elixir REPL helps quite a bit!

The book covered all content that I wanted, except there is nothing about deploying the application. Some pointers and best practices into that direction would have been really nice!

Overall a very solid book and a good read. If you are interested in doing Phoenix programming, this is a very good starting point.

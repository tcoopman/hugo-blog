+++
date = "2017-10-28T08:56:00+01:00"
draft = false
title = "Why I choose Bucklescript"
slug = "post-title"
tags = ["Bucklescript","OCaml", "Elm", "ML", "Frontend"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = "Thomas Coopman"
+++

On the meetups I attend, some people know me as the Elm guy. Yet, when reading the title of this post, you can see that I'm going for Bucklescript lately. 

In this post I'm going to try to explain my choice for Bucklescript. If you are in doubt, maybe some points in this post can help, but my advice would be to just try and research both languages and see for yourself.

## What is Bucklescript

First of all, I'm assuming that you know what [Elm](http://elm-lang.org/) is already. [Bucklescript](https://bucklescript.github.io/bucklescript/Manual.html) on the other hand might be new to you.

This is what the manual says about Bucklescript:

    BuckleScript is a backend for the OCaml compiler which emits JavaScript. It works with both vanilla OCaml and Reason...

Let me try to recap this:

1. [OCaml](https://ocaml.org/) is a functional programming language in the ML family (like for example Haskell, F# and Elm).
2. Bucklescript being a backend for the OCaml compiler means that you write OCaml and it gets compiled into Javascript.
3. [Reason](https://reasonml.github.io/) is a new syntax for OCaml created by Facebook, you can see it as a dialect for OCaml (a bit similar to Elixir and Erlang).

So, you write OCaml code that is transpiled to javascript. *If I use OCaml instead of Bucklescript in the rest of the document you I mean the OCaml syntax. If you don't use bucklescript and use the OCaml compiler your code gets compiled to native code. In fact you can perfectly do that, also with Reason.*

A lot of the things I write below are also valid for Reason, but I'm focusing on the OCaml syntax here.

*Update after feedback:* As you can could read in this section, I should write *why I choose OCaml with Bucklescript* instead of *why I choose Bucklescript*. In the places where I write Bucklescript I mean OCaml with Bucklescript to compile to Javascript.

## Bucklescript over Elm?

A small disclaimer, I'm giving the reasons why I switched to Bucklescript, this means that there are probably more advantages and disadvantages that are not listed.

### Syntax

There is a good reason I started looking to Elm in the first place. Elm is a really nice typed functional language in the ML family for the browser.

The Bucklescript syntax is mostly very close to Elm, as you can see in the example here:

*First the Elm code:*

```elm
type Tree a
    = Empty
    | Node a (Tree a) (Tree a)

  
empty : Tree a
empty =
    Empty

map : (a -> b) -> Tree a -> Tree b
map f tree =
    case tree of
      Empty -> Empty
      Node v left right ->
          Node (f v) (map f left) (map f right)
```

*And this is how this looks in OCaml*

```ocaml
type tree =
  | Empty
  | Node of int * tree * tree
  
 let empty = Empty
 
 let rec map f tree =
   match tree with
   | Empty -> Empty
   | Node (v, left, right) -> Node (f v, map f left, map f right)
```

You can notice some differences, but more similarities in this small example. If I needed to choose purely on syntax, I'd probably give a slight advantage to Elm over OCaml.

### Interop with javascript

Of course choosing for a language is way more than choosing for the syntax. For me, the main selling point of Bucklescript is the great interop with javascript. In bucklescript you have a lot of tools at your disposal to integrate with Javascript (you can read about this in the [manual](https://bucklescript.github.io/bucklescript/Manual.html#_ffi)).

There is some learning curve, but once you get the hang of it, I find it so easy to integrate that I sometimes don't bother to look if there are bindings for something small I need, because writing these yourself is just as easy. I needed some small things of Phoenix websockets and Openlayers maps and wrote the binding myself. Both implementations are incomplete because I only wrote bindings for the things I needed, so it's not something that can be published as a package, but it was more than enough for what I needed.

A point that Elm claims a is that there are no runtime errors in Elm (Elm tries very hard to avoid uncaught runtime errors, but this is just unavoidable, so this point should receive some more nuance).
OCaml doesn't claim this (and in fact some functions of the basic library throw :-(, but you can avoid this most of the time), but if you have some attention you can build programs that are just as safe as Elm.
On the other hand, Elm tries very hard to not get any runtime errors, and for that reason only allows you to interop with Javascript through ports (or with native modules - but it's not very clear what the end goal is with native modules). In Bucklescript you have all the power to interop with Javascript and this means that you can shoot yourself in the foot easily. With great power comes great responsibility, and here your responsibility is to be carefull with the interop, wrap where needed in `Result` or `Option/Maybe` and keep the interactions with javascript at the boundaries. Keep the safety on the inside and have a lot of power to interact with Javascript!

The interop also means that it's really easy to integrate your Bucklescript/Reason app with an [existing Javascript/Typescript application](/blog/2017/09/30/integrating-bucklescript-with-typescript/). You can integrate, or write new parts in Bucklescript, or rewrite parts. It's all up to you to choose.

### The Elm architecture is ported to Bucklescript

A big point in Elm is the Elm architecture, but this is not an advantage for Elm per se, because TEA is [ported to Bucklescript](https://github.com/OvermindDL1/bucklescript-tea) as well! This means that you can port your applications from Elm to Bucklescript without any hassle and this is something I tried successfully with some [small applications](https://github.com/tcoopman/game-of-life-bucklescript).

### In the open

This point is something very personal. Initially I was doubting if I should include it in the post or not. I included it, because it's an important reason for me to choose Bucklescript over Elm. For some of you this point can be completely irrelevant, if so, please ignore it.

As a first point, for the most part I liked what Evan has done with Elm so far. I also think that it's his choice to develop Elm the way he likes (he has always been clear about that). So the point below is not a critique per se, just something I don't agree with and even don't feel very comfortable with.

My current feeling is that Bucklescript and Reason are developed in the open, while Elm is developed a bit after closed doors. It seems like there are more contributors to Bucklescript and the maintainers of the language also feel open to new contributions and this is something I haven't really felt in the time I followed Elm more closely. If you look at the [amount](https://github.com/BuckleScript/bucklescript/commits/master) of [commits](https://github.com/facebook/reason/commits/master), pull requests,.. in both Bucklescript and Reason you can see that a lot is going on by more than 1 person.

Maybe this is a side effect of speed of development, but it rather feels like a design choice, with Bucklescript there are small releases in between, with small fixes and improvements. Elm on the other hand chooses to go for the big releases with long time periods in between. I like to write my software with small incremental improvements and I like that this seems to be the way that Bucklescript is developed.

When you search the Elm mailing list you can find lots of complaints about some of these, and again, I'm not trying to argue with they way Elm is organized, but it doesn't feel very comfortable for me, so it's a point against Elm.

### Others

There are some other things that don't matter that much for me at this point, but are also quite nice:

* It compiles to small javascript files that can be used on web, but also on the server.
* Mostly a lot smaller (doesn't include a complete runtime)
* Compiles to native
* The ecosystem is coming around greatly, if you need help I would say, go take a look at the [discord channel](https://discord.gg/reasonml).

## Where Elm really shines

In the post so far, I focused on my choice for Bucklescript, but there are some parts where Elm really shines and I hope that Bucklescript and Reason also improve these.

### Error messages

This is a big selling point of Elm, and it makes Elm also good for beginners and advanced people, but I've never seen better compiler error messages than in Elm. I've also seen these improve with every version and this is something that is absolutely wonderful about Elm.

It looks like a lot of compilers have been inspired by this and Bucklescript/Reason are also improving this a lot, as you can see in [this](https://reasonml.github.io/community/blog/#way-way-waaaay-nicer-error-messages) post.

### Beginners guide

Elm is very beginner friendly, there is a very good beginners [guide](https://guide.elm-lang.org/) that makes it very easy to get starting even if you don't know any ML languages yet.

On the other hand, if you compare this with the Bucklescript [manual](https://bucklescript.github.io/bucklescript/Manual.html), you'll see that this manual contains probably a lot more information, but it's not that beginner friendly. There is also progress, because the Reason [guide](https://reasonml.github.io/guide/) is way better. The beginning of the guide also has great little section on similar languages if you don't like Reason!

### A small and simple language

You can argue about the fact that Elm is too simple, and I won't go a lot into this, but for me the fact that Elm is a really small, clean and simple language makes it really easy to learn, read and write. I must admit that I've already used more advanced features in OCaml, but I didn't really miss these when I wrote Elm, and I don't think Elm is a lesser language for it, on the contrary!

## Some last finishing thoughts

### Why do I choose the OCaml syntax over Reason

I like the fact that OCaml is and feels like an ML language. I can kind of see how Reason could be more attractive to the Javascript world by having a syntax similar to Javascript, but it is not for me. I tried Reason but switched back to the OCaml syntax again (and the super cool thing is that `refmt` can convert between both :-))

### Other alternatives

I haven't really looked into other alternatives like [Js_of_ocaml](http://ocsigen.org/js_of_ocaml/), [Fable](http://fable.io/), [Purescript](http://www.purescript.org/),...

Mostly because I stumbled into Bucklescript, tried it, and loved it. I took a short look at some of the alternatives, but nothing convinced me at this point, and I'm really happy with Bucklescript and use it in some small parts in production already.

## Conclusion

I hope that I could explain why I made the switch from Elm to Bucklescript. I still think Elm is a great language and a great choice to look at if you're bothered with Javascript/Typescript/Flowtype, but know that there are great other choices as well.

If you ask me to choose a frontend language, my choice would go to Bucklescript!

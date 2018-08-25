+++
title = "The Bank Kata in Ocaml: Part 1 setting everything up"
date = 2018-08-23T16:45:26+02:00
draft = true
tags = ["ocaml", "bank-kata", "kata"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = "Thomas Coopman"
+++

The goal of this small series of blogs is to implement the [Bank kata](https://github.com/sandromancuso/Bank-kata) in OCaml, doing it test and type driven and try to have a clean design. We'll try to implement the kata with outside-in tests. My personal goal is to learn some OCaml along the way. I won't be going into every detail of OCaml, but if you have some experience with an ML language, you should be able to follow along.

I've got the inspiration of doing this from a nice [blog post](https://medium.com/@erik.sacre/clean-architecture-through-outside-in-tdd-64a31de17ccf) from Erik Sacre where he explores outside-in TDD.

This is the outline of the blog posts:

1. Creating the project: ready for tests
2. Implementing a first outside-in test and implemeting it as fast as possible
3. Implementing the clock

## Let's get our system ready

Before we can start, make sure you have `opam 2.0` (the ocaml package manager) installed on your system. If you haven't got it, go over [here](https://opam.ocaml.org/doc/2.0/Install.html) to install it.

If you've already installed opam, make sure to run `opam update` regularly to stay up to date with the packages.

## Creating the project

In our favorite workspace directory we'll go and create a new directory:

```bash
mkdir bank-kata
cd bank-kata
git init # I won't be showing you the commits
```

Now we are ready to initialize everything we need for the ocaml project:

```
opam switch create . 4.07.0
```

This will let us work in the current directory with OCaml 4.07.0. The command has created an `_opam` folder which we want to add to `.gitignore`. Also add `_build` to `.gitignore`.

At the end of the install there will be some command for you to run to update the local variables, for me (I'm using `fish` instead of `bash`) this is `eval (opam env)` so make sure to run that, so all commands are available in your terminal.

Now we are ready to install the base libraries that we need:

```
opam install merlin ocp-indent dune
```

`merlin` and `ocp-indent` are 2 tools so your editor can show you compile errors, type information and have some basic indenting. `dune` is the build tool we'll be using.

_If you've did everything correct, you should have `dune 1.1.1` at least._

Now let's create a new folder `test` with the file `dune` with these contents:

```lisp
(library
    (name test)
    (libraries base stdio)
    (inline_tests)
    (preprocess (pps ppx_expect))
)
```

This creates a [dune](https://dune.readthedocs.io/) library `test`, with a dependency on libraries `base` and `stdio`. The line `inline_tests` marks this as a test library and the last line includes the `ppx_expect` ppx to run [expectation tests](https://github.com/janestreet/ppx_expect)

When we now run `dune runtest` we'll see that library base can't be found. You'll also see that running dune created a `dune-project` file in the root directory.

The error output gives us a hint, running that hint we get to the real solution: `opam install base stdio`.

When we run again we see that `ppx_expect` can't be found either. No more luck with the hints though :-(. Luckely the solution is the same: `opam install ppx_expect`.

Now when we run `dune runtest` again we should have no more errors and no output either (because we haven't written any tests yet).

## Our first sanity test

Create a file `test/test.ml` with these contents:

```ocaml
open! Base
open! Stdio

let%expect_test "Sanity" =
  print_endline "Hello, World!";
  [%expect{||}]
```

The `let%expect_test` construct let's us test output to stdio in the `[%expect{||}]` block. Now when you run `dune runtest` you'll see the error, and you could change the `[%expect{||}]` block manually. But you can also run `dune runtest --auto-promote`, this will automatically change your expect lines in the source code to match the new output. Try to be careful with this, but it can be very useful, especially when all your code is in version control.

Before we can move on to the kata, let's make sure we an other directory `lib` with a `dune` file:

```lisp
(library
    (name lib)
)
```

In `test/dune` add `lib` as a dependency to `libraries`. As a sanity check you can create a file `lib/Sanity.ml` with:

```ocaml
let sanity () =
    print_endline "Hello, World!"
```

and call it from your test:

```ocaml
let%expect_test "Sanity" =
  Lib.Sanity.test ();
  [%expect{| Hello, World! |}]
```

If your tests still work, you can remove the `Sanity` file.
I also removed the `test/test.ml` file so we have a clean setup to start the actual kata.

In the next part we'll actually start implementing the kata

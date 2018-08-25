+++
date = 2018-08-25T14:45:26+02:00
draft = true
title = "The Bank Kata in Ocaml - Part 2: implementing the kata"
tags = ["ocaml", "bank-kata", "kata"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = "Thomas Coopman"
+++

In [part 1]({{< ref "the-bank-kata-in-ocaml.md" >}}) we've set everything up, let's implement the kata now. If we check the [readme](https://github.com/sandromancuso/Bank-kata) we can see a simple acceptance test, let's start with that.

We create a file `test/account_test.ml`:

```ocaml
open! Base
open! Stdio

let%expect_test "Printing the statements should contain all transactions" =
  Lib.Account.create ()
  |> Lib.Account.deposit ~amount:1000.0 ~on:"10/01/2012"
  |> Lib.Account.deposit ~amount:2000.0 ~on:"13/01/2012"
  |> Lib.Account.withdrawal ~amount:500.0 ~on:"14/01/2012"
  |> Lib.Account.print;
  [%expect{|
    date || amount || balance
    14/01/2012 || -500.00 || 2500.00
    13/01/2012 || 2000.00 || 3000.00
    10/01/2012 || 1000.00 || 1000.00
  |}]
```

Let's first see how we can get this test to green as fast as possible.

The simplest way to make this compile is with `lib/account.ml`:

```ocaml
let create () = ()

let deposit _ _ = ()

let withdrawal _ _ = ()

let print _ =
  print_endline "TODO"
```

If you now run your tests, you should get a compiling code, but mismatching output, so let's think about the actual implementation.

Now it's time to start thinking about some types. Let's see, what should create return?

```ocaml
type account = transaction list
and type transaction = {
    date: string;
    amount: float;
}
```

Something like this seems ok for the first iteration of this kata (ofcourse having floats for an amount is serious no-go, but for this kata, we'll ignore it!)
We create an `account` type, that's just a list of transactions, and thus, create can be defined like:

```ocaml
let create () = []
```

So this makes `deposit` and `withdrawal` trivial to implement:

```ocaml
let deposit ~amount ~on account = {date = on; amount} :: account
let withdrawal ~amount ~on account = {date = on; amount = amount *. -1.} :: account
```

And now we're ready to implement the print function to get the tests green.

```ocaml
let print account =
  let calculate account =
    List.fold_right (fun transaction (total, x) -> (total +. transaction.amount, (total +. transaction.amount, transaction) :: x)) account (0., [])
  in
  let buffer = Buffer.create (List.length account * 50) in
  let rec fill_buffer = function
    | [] -> ()
    | (total, transaction) :: tl ->
      Buffer.add_string buffer (Printf.sprintf "%s || %.2f || %.2f\n" transaction.date transaction.amount total);
      fill_buffer tl
  in
  let (_, calculated) = calculate account in
  Buffer.add_string buffer "date || amount || balance\n";
  fill_buffer calculated;
  print_string (Buffer.contents buffer)
```

This is not the most beautiful code, but it makes the tests green. The question is are we happy with it or is it time for refactoring?

We could argue that doing `amount *. -1` in `withdrawal` is not very clean, but that's something I'm going to leave for now.

The `print` function is something else though. Let's see if we can clean this up a bit:

```ocaml
let print account =
  let add_balance account =
    let (_, with_calculated_balance) = List.fold_right (
        fun transaction (total, calculated_transactions) ->
          (total +. transaction.amount, (total +. transaction.amount, transaction) :: calculated_transactions)
      ) account (0., []) in
    with_calculated_balance
  in
  let to_print_statements account_with_balance =
    List.map (fun (total, transaction) ->
        Printf.sprintf "%s || %.2f || %.2f\n" transaction.date transaction.amount total
      ) account_with_balance
  in
  let print_statements_to_string_with_header print_statements =
    let buffer = Buffer.create (List.length account * 50) in
    Buffer.add_string buffer "date || amount || balance\n";
    List.iter (Buffer.add_string buffer) print_statements;
    Buffer.contents buffer
  in

  account
  |> add_balance
  |> to_print_statements
  |> print_statements_to_string_with_header
  |> print_string
```

This feels a lot better, when you start reading the last lines it tells clearly what it is doing. It's a bit more code, but all functions have better names and have one purpose.

Before we're saying we're done, something still feels off. We pass dates into our public API. That's not how a bank works? After looking a bit better at the bank kata, I found [this](https://github.com/sandromancuso/bank-kata-outsidein-screencast) where the dates are not part of the public API.
How can we fix this with OCaml. Let's find out in part 3.

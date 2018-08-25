+++
date = 2018-08-25T15:00:26+02:00
draft = true
title = "The Bank Kata in Ocaml - Part 3: injecting a clock with Functors"
tags = ["ocaml", "bank-kata", "kata"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = "Thomas Coopman"
+++

So at the end of [part 2]({{< ref "the-bank-kata-in-ocaml-part2.md" >}}) we said we don't like that we have to add the date as part of the public API. Which makes sense for a public bank terminal, we do a deposit or withdrawal now.

So we'll want to remove `on` from `deposit` and `withdrawal`. But where do the dates come from now?
Let's introduce a `Clock` module:

Let's see if we can rewrite our test to adapt to this new API

```ocaml
open! Base
open! Stdio

let%expect_test "Printing the statements should contain all transactions" =
  Lib.Account.create ()
  |> Lib.Account.deposit ~amount:1000.0
  |> Lib.Account.deposit ~amount:2000.0
  |> Lib.Account.withdrawal ~amount:500.0
  |> Lib.Account.print;
  [%expect{|
    date || amount || balance
    14/01/2012 || -500.00 || 2500.00
    13/01/2012 || 2000.00 || 3000.00
    10/01/2012 || 1000.00 || 1000.00
  |}]
```

So how do we get a date in.

Let's introduce a `Clock` module that returns a new `Date` upon calling `now ()`

```ocaml
module Clock = struct
  let now () = "SystemClock"
end
```

Well, obviosly, `"SystemClock"` should be replaced by an actually system clock, but that's not part of the exercise. So now our `Account` should use this clock:

```ocaml
let deposit ~amount account = {date = Clock.now (); amount} :: account
let withdrawal ~amount account = {date = Clock.now (); amount = amount *. -1.} :: account
```

That's trivial to write, and now our test should run but they are red of course, because we get `"SystemClock"` as the date. In our tests we don't want to pass a system clock. We want to have a test clock. So `Clock` should be a parameter to the `Account`. Let's turn our `Account` into a [Functor](https://dev.realworldocaml.org/functors.html)

This is almost trivial (once you know how to do it). We transform our module into a functor that takes a Module argument of type `Clock_S`.

```ocaml
module type Clock_S = sig
  val now : unit -> string
end

module Make(Clock: Clock_S) = struct
  (* implementation of the Account here *)
end
```

What is `Clock_S`? We can define it as:

```ocaml
module type Clock_S = module type of Clock
```

I've defined this type in a file `common.ml` and added `open Common` at the top of `account.ml`

So it's basically the type of our clock module. We could have explicitly written it like:

Ok, so we transformed our `Account` into a Functor. How can we use it now in our tests?

In our test we'll need to use `Account.Make` to create a new `Account` module. To call `Make` we pass a Module with type `Clock_S`.
Let's create that module. Ideally, we'll want to pass some dates into the module that will be used in our Account.

```ocaml
module type TestDates = sig
  val dates : string array
end

module TestClock (D : TestDates) = struct
  let i = ref 0
  let now () =
    let date = D.dates.(!i) in
    i := !i + 1;
    date
end
```

`TestClock` is again a functor that takes `TestDates`, this makes it easy to inject the test dates that we want to use in our test.
It keeps a ref `i` to keep track of how many times it has been called, and returns a different date each time. It's important to see that this code will crash with an `index out of bounds` exception when we don't provide the correct values in our test setup, but that's ok, even desired for our test.

Now we can change our test like this to make it green again:

```ocaml
let module Account = Lib.Account.Make(TestClock(struct let dates = [|"10/01/2012"; "13/01/2012"; "14/01/2012"|] end)) in
```

We make a new `Account` with a `TestClock` and pass it in the dates that we want.

Our complete test looks like this:

```ocaml
let%expect_test "Printing the statements should contain all transactions" =
  let module Account = Lib.Account.Make(TestClock(struct let dates = [|"10/01/2012"; "13/01/2012"; "14/01/2012"|] end)) in
  Account.create ()
  |> Account.deposit ~amount:1000.0
  |> Account.deposit ~amount:2000.0
  |> Account.withdrawal ~amount:500.0
  |> Account.print;
  [%expect{|
    date || amount || balance
    14/01/2012 || -500.00 || 2500.00
    13/01/2012 || 2000.00 || 3000.00
    10/01/2012 || 1000.00 || 1000.00
  |}]
```

When we now run our test, they will be green!

We solved our problem of dependency injection with `Functors`. We could also have injected a function in `Account.create` with signature `unit -> string` but by solving it like this we almost had no changes to make to our original code which is a great plus.
Furthermore it's possible to provide a default implementation that we use in our production code like this:

```ocaml
include Make(struct let now () = "SystemClock" end)
```

Where `"SystemClock"` is obviously a real system clock.

## Conclusion

We've used some basic dependency to inject a `Clock` into our `Account`, but we have no other complex design at all.
If you look at the [sample solution of Sandro](https://github.com/sandromancuso/bank-kata-outsidein-screencast/blob/master/src/main/java/com/codurance/Account.java) you'll see that next to the `Clock` there is also a `StatementPrinter` and `Transactions`repository injected. In a real application this would probably be needed, but I don't find that it adds any value at the moment for this simple kata.

A repository might certainly be needed, but for now, you're responsible for keeping the state. If I were to implement a full application I'd probably reverts some thing and transfer `Account` into a pure domain object. I'd remove the clock and add `on` again to `deposit` and `withdrawal`. Also, I'd change the signature of `print` (and rename it as well), to return a list of statements.

This would give me a pure `Account` module with all domain logic that I can use in my Application, where I can inject a `Clock`, `Repository` and `StatementPrinter`.

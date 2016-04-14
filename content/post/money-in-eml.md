+++
date = "2016-04-12T22:28:31+02:00"
tags = ["elm", "modelling", "DDD"]
title = "Modelling money in Elm"
+++

After reading the blog post of Mathias Verraes (@mathiasverraes) on (Type Safety and Money)[http://verraes.net/2016/02/type-safety-and-money/], and after doing a real short modelling attempt in Haskell at Socrates Belgium, I wanted to try to model Money in Elm.

I don't want to go to deep and too far so I've set some basic constraints for myself:

* You cannot add money of different currencies (you need an explicit conversion) - *Add constraint*
* We also want a Price. A Price is a Money and a VAT amount.


The goal is to explore different ways of modelling the money in Elm and to explore how a type safe language can support our constraints.

## Possible type declarations of Money in Elm

Money is an amount (Float) and a currency

If you are doing serious calculations with money, you might want to check if you don't run into precision issues with Float. This is not the goal of the exercise, so we use Float.

There are some different options for modelling the money.

With a Tuple, a Currency and a Float:

``` elm
type alias Money = (Currency, Float)
type Currency = Euro | Dollar
```

Or with union types


```elm
type Money = Euro Float | Dollar Float
```

Both these implementations fulfill the requirement of a `Money` type for the `Price`.

These implementations cannot enforce the *add constraint* at compile time. Although, you can enforce that you don't get wrong results:

```elm
add : Money -> Money -> Maybe Money
```

or, there can be invalid money

```elm
type Money = Euro Float | Dollar Float | Invalid
add : Money -> Money -> Money
```

This last one would be harder to implement with a Tuple. But in most other ways I believe the Tuple and the union types are very similar. I like the union types better, so I won't explore the tuple any further.

When we have the choice between these 2 add type definitions, which one is best?
I prefer `add : Money -> Money -> Maybe Money` for 2 reasons: (1) Invalid is not an actual type of money and (2) returning Maybe makes it very explicit that this an operation that can fail.

Would it be possible to enforce the constraint of adding only the same currencies on compile time? Yes, like this:


```elm
type Euro = Euro Float
type Dollar = Dollar Float
```

Now you have to implement 2 add functions for both types.

This does have some disadvantages, you have to implement add twice. If you want to have them in the same file, the names of the add methods can't be the same, and we need some type to represent money (for our price constraint).
This also means that it's best to implement `Euro` and `Dollar` both in their own module, so that you can create 2 add functions.

But lets see if this is doable.

First the problem of the reimplementation. This is something that is unavailable in Elm (I believe it's possible to avoid this with type classes in Haskell), but it's not that bad.
Suppose we needed to write many functions on money types, then we could write them like this:

```elm
update2 : (Float -> Float -> Float) -> EUR -> EUR -> EUR
update2 f e1 e2 =
	case (e1, e2) of
			(EUR a, EUR a') -> EUR (f a a')

add : EUR -> EUR -> EUR
add = update2 (+)
```

Like this we can avoid writing complex functions twice

```elm
complexOperation : EUR -> EUR -> EUR
complexOperation = update2 complexer

complexer : Float -> Float -> Float
```

The second constraint is that we need a `Price` with a `Money` type. With our first implementations this constraint was already fulfilled, but here we need to implement a `Money` type too.

```elm
type Money = Euro EUR | Dollar USD
type VAT = VAT6 | VAT12 | VAT21
type Price = (Money, VAT)
```

(Here it makes more sense to use a tuple for `Price`, `Price` is a `Money` and a `VAT`, while `Money` is a amount of some currency)

We also need functions to transform a EUR or USD to Money, but these are trivial:

```elm
EURToMoney : EUR -> Money
EURToMoney eur = Euro eur
```

## Extra - Currency Conversions

What if you want to convert a currency. Then you need exchange rates.
With Elm, these conversions can be typed checked too, although it's a bit verbose.

Let's say we want all the `Money` of our `Price`s to be converted to euro.

```elm
type alias EURToUSD = Float
type alias USDToEUR = Float
type alias Exchanges = (EURToUSD, USDToEUR)


moneyToEuro : Money -> Exchanges -> EUR
moneyToEuro mon con =
  case con of
		(euroToUsd, usdToEur) ->
			case mon of
				Dollar usd -> EUR ((Usd.extract usd) * usdToEur)
				Euro eur -> eur
```

Where extract is a function that extracts the amount of the USD.

## Conclusion

Elm doesn't have type classes so some things are extra work and are a bit more verbose. But it is possible to enforce a lot at compile time. Furthermore everything is very readable.

Is it worth it of doing it like this? That totally depends on your use case. A lot of times you will want to use `type Money = EUR Float | USD Float` and use a `Maybe` type to enforce your constraints, but sometimes you will do the extra work to enforce some things at compile time.



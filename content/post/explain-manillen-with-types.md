+++
date = "2016-04-18T21:01:30+02:00"
description = "Let's try to explain the card game Manillen in Elm."
title = "Explain Manillen with types and Elm"
draft = true
tags = ["elm", "modelling", "manillen"]
+++

At [Domain Drive Design Europe](http://dddeurope.com/) I met the wonderful [@Felienne](https://twitter.com/Felienne). In the evening we played the card game bridge (a game the Felienne likes [a lot](http://www.felienne.com/archives/4433)). As a *West-Vlaming* I love the card game *Manillen* more, of course, and we joked about it. Felienne has the ambition to create an AI to compete at the world championship of Computer Bridge, and I have joked about some similar ambitions of mine at Socrates Belgium, but this blog post has a much more humble goal.
I want to try to explain the rules of *Manillen* or *Manille* to you with Elm. If you are to eager and want to find out more about the game (and the rules), see [wikipedia](https://en.wikipedia.org/wiki/Manille).

So lets start.

These are the valid cards:

```elm
type Suit = Spade | Club | Diamond | Heart
type Rank = Manille | Ace | King | Queen | Jack | Nine | Eight | Seven

type alias Card = (Suit, Rank)
```

The `Manille` is the number 10 in a card deck.

The game is played with 32 cards (4 * 8), thus, this is the full deck:

```elm
type alias Deck = List Card

deck : Deck
deck = 
	[ (Spade, Manille), (Club, Manille), (Diamond, Manille), (Heart, Manille)
	, (Spade, Ace),     (Club, Ace),     (Diamond, Ace),     (Heart, Ace)
	, (Spade, King),    (Club, King),    (Diamond, King),    (Heart, King)
	, (Spade, Queen),   (Club, Queen),   (Diamond, Queen),   (Heart, Queen)
	, (Spade, Jack),    (Club, Jack),    (Diamond, Jack),    (Heart, Jack)
	, (Spade, Nine),    (Club, Nine),    (Diamond, Nine),    (Heart, Nine)
	, (Spade, Eight),   (Club, Eight),   (Diamond, Eight),   (Heart, Eight)
	, (Spade, Seven),   (Club, Seven),   (Diamond, Seven),   (Heart, Seven)
	]
```

or shorter we could write it like this:

```elm
suits =
  [ Spade, Club, Diamond, Heart ]


allCardsOfRank rank =
  suits |> List.map (\suit -> ( suit, rank ))


ranks =
  [ Manille, Ace, King, Queen, Jack, Nine, Eight, Seven ]


deck : List Card
deck =
  ranks |> List.concatMap allCardsOfRank
```

but I find the longer version more readable.

So to start playing we need players:

```elm
type Player
  = Front
  | Left
  | Back
  | Right


wulder : ( Player, Player )
wulder =
  ( Front, Back )


zulder : ( Player, Player )
zulder =
  ( Left, Right )
```

We play in 2 teams, *wulder* vs *zulder* (West-Flemish for *we* and *them*)

Before we start playing, I'm going to explain how the scoring works and how you can win a game.

```elm
points : Rank -> Int
points rank =
  case rank of
    Manille ->
      5

    Ace ->
      4

    King ->
      3

    Queen ->
      2

    Jack ->
      1

    _ ->
      0


score : List Card -> Int
score cards =
  let
    ranks =
      List.map snd cards

    allpoints =
      List.map points ranks
  in
    List.sum allpoints
```

With elm-test we can see a constraint

```elm
[ test "A full deck scores always 60" ((score deck) `assertEqual` 60) ]
```

And with elm-check (a toolkit for writing property based tests) we see these properties:



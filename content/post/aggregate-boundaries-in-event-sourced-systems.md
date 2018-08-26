+++
categories = []
date = "2017-02-08T20:44:40+01:00"
description = ""
tags = ["modelling", "DDD"]
title = "Exploring aggregate boundaries in event sourced systems"
draft = false
+++

In this post I'm exploring some ways of modelling aggregate boundaries in an event sourced system. This is mostly to crystallise some thoughts that I had after some event storming sessions, but it might be interesting to someone else.

The domain I'm using in this post is the domain that [Michel Grootjans](https://twitter.com/michelgrootjans) and I have created for the workshop _Playing with projections_ (We already gave it a few times, for example at [DDD Europe][dddeu] and will also give a session at [I T.A.K.E.][itake])

## The domain: An online quiz platform

In the online quiz platform:

- a player can create a new quiz
- they can add questions to the quiz
- they can publish the quiz
- once a quiz has been published, a game can be opened. A game is an instance of a quiz
- Many games of a quiz can be opened (there is no limit)

A game, once it is opened looks like this:

- players can join a game
- after some time the game is started
- once the game is started, every question that is part of the quiz will be asked
- players get a limited time to answer the question, if they are too late, a timeout passes
- once all players have answered, or the timeout has passed a new question is asked
- once all questions have been asked, the game is finished
- if no players joined the game, the game will be cancelled

## How can we model the domain?

Now we will take a look at how we can model parts of the domain.

The first way to model could be by having one aggregate: the quiz. A quiz can handle its whole life cycle and so it's very easy to enforce all rules in this design. But we can see some problems with this design:

- Our quiz aggregate stream can grow to huge sizes. When lots of games are played, there will be lots of events.
- An aggregate, because it should keep its invariants, is a synchronization point. So when there are many games played, this could be a performance issue.

Furthermore, at the moment the life cycle of the quiz seems a bit incomplete. The defined business rules don't tell anything about ways of changing the quiz, archiving one, or preventing new games to be started. Suppose in a couple of weeks, business asks us to add these new features:

- A player can change a quiz (add new questions) after it's been published.
- A player can archive a quiz. No games can be started for archived quizzes.

Of course we will ask business:

> "What happens to running games when a player changes something?"

> "Running games must not be affected by changes"

This provides a bit of a challenge in the current design. If we model this as one aggregate, we will need to provide extra logic to handle changed questions.

Suppose we have a quiz with currently open games and change some questions of the quiz. We know that started games should not be affected. To solve this we would could save the old questions. But because multiple games can be started at different times, it's not enough to solve the previous set of questions. A better solution would be to copy the questions to the game when it is started.

At this point we can see a new design emerging. We can split our domain into 2 aggregates. A quiz and a game.
This can solve the problem of the changing questions and also solves our initial problem of performance and a huge aggregate. The quiz will still be long lived, but will almost always be very small. A game on the other hand will be short lived. The performance will be solved because each game is now independent.

The design with splitting the quiz and game aggregates introduces a new challenge though. A game can only be started for a quiz in the correct state. A game cannot be opened if the quiz isn't published yet or if it is archived. But the game doesn't have this information, the quiz has.

So the solution is simple: _the quiz creates a new aggregate; the game_ ([aggregates create other aggregate][2]).

In pseudo code this could look like:

```elixir
quiz.open_game(game_id)
    case quiz_is_published
        game = new Game(game_id, quiz_id, copy(questions))
        # game contains unsaved event game_was_opened
        return game
    case _
        return DomainError("A game can only be opened for published quizzes")
```

### Exploring a different implementation

Instead of the quiz aggregate that creates a new aggregate, we could also try something like this: The quiz handles the `open_game_request` command and returns an event `game_open_requested`. A process manager listens to this event and dispatches a `open_game` command. The `open_game` command is handled by a game. The `game_open_requested` means that it is allowed to open the game.

So `open_game` is now an internal command and should not be exposed to users. Users can only request to open a game.

This adds some complexity and is probably not always a good solution. But sometimes we might need a solution like this. Let's say that the we have some problems with copyrighted materials in our quizzes and that we are enforced to terminate all quizzes and corresponding games immediately (I know, this is probably far fetched, but it is to explore the solution further).

How could this look?

```elixir
quiz.terminate_due_to_copyright
# returns quiz aggregate with unsaved event (quiz_was_terminated)
```

A process manager could listen to `quiz_was_terminated` and dispatch a `terminate_game` command to all open games for that quiz. But _how does the process manager know what games are open for the quiz_? Well if we modelled our solution to have the process manager open the games, then it can also keep the state of all the open games for the quiz. So in this final solution we have a process manager that listens to `game_open_requested`, `quiz_was_terminated`, `game_was_closed`.

## Closing thoughts

Although the problem and the domain seems simple, exploring the solution was fun. Furthermore, I only listed some probable solutions, more possible solutions can be found.

One thing I didn't touch yet, but might in an other post, is how frameworks or programming styles can force you into some solution. I had some trouble trying to implement the aggregate that creates an other aggregate in at least one framework and have seen some other frameworks where this solution is not obvious to implement.

[dddeu]: https://dddeurope.com/2017/speakers/thomas-coopman/#handson
[2]: https://groups.google.com/forum/#!searchin/dddcqrs/aggregate$20instance|sort:relevance/dddcqrs/B6kxs7FK8_I/F_xcEdkOnHwJ
[itake]: http://itakeunconf.com/

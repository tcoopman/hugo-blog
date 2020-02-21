+++
date = "2019-07-04T14:54:24+02:00"
draft = true
title = "Event sourcing from the ground up"
slug = "event-sourcing-from-the-ground-up"
tags = ["ddd", "event sourcing", "event store", "event storming"]
image = ""
comments = false	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= "workshop"		# set "main" to add this content to the main menu
author = "Thomas Coopman"
+++

Starting with a some rabbling while reading the source of [elixir eventstore](https://github.com/commanded/eventstore)

My original idea was to first start with some event storming and then go into programming.
But I think it will be very important to have a very clear structure for this workshop so that everyone can follow.
Not only that, it will also be very to have a why would you do that.
When starting with event storming, maybe we are missing some basics.
So maybe start with what event sourcing is. Event sourcing + CQRS. Define some of the mathematical functions, and relate to what we are going to implement.
We can also simplify some things.
We should set up goals. What do we want to reach, understanding over implementation,...

```
aggregate: f(c, [e]) => [e] || can be transformed to f(internal_state, c) => [e] + f(internal_state, e) => internal_state

query: f(q, [e]) => result || can be transformed to f(q, internal_state) => result + f(internal_state, e) => internal_state

process_manager: f([e]) => c|e|side_effect
```

It is to learn to know the basics of event sourcing. Not being an expert, but having clear knowledge about why you want to use it, how you want to use it....


An other idea I had was to build the memory game (match the picture), but this is game. A clearer business case would be more useful/relevant I think.
For this I could do a brainstorm to list some ideas:
- banking
- workflow of a restaurant/bed&breakfast/healthybrooddozen/...
- transport company

We will build everything from the ground up, but not in a huge amount of detail. In 2 days you can't write a lot of code. On the other hand, if you start from simple principles, in memory,... you can go fast.

We can also ignore some problems up front: concurrency,...
We can also provide queries, limit ourself to 1 database, have a docker image prepared,...


enveloppe:
- event_id
- event_type
- causation_id
- correlation_id
- data
- metadata
- created_at

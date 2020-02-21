+++
date = "2014-07-11T10:54:24+02:00"
draft = false
title = "Post title"
slug = "post-title"
tags = ["tag1","tag2"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = ""
+++

written with https://maebert.github.io/themostdangerouswritingapp/#/write?limit=5&type=minutes

How to make illegal states impossible with Event Sourcing. The problem is that with event sourcing, you don't have any rules on what commands can be send out. Well, you have those rules in the domain, but it's hard to make them explicit in the software.

That doesn't mean that it's impossible to enforce the domain rules per se.
A possible solution is to make your core domain logic, based on the making illegal states impossible and to have your commands validated through this core domain logic.
An example in the memory (find the same picture) game is that on your first turn, you can turn any card, on your second turn you turn a card again, but you can't turn a third card. Neither can you turn a card that was already open or that is outside of the coordinates of possible cards.
Some of these things are hard to represent, even in a statically typed language, but they are validations on the command. Not turning cards that have already been turned, is something really hard to make illegal. It might be possible though. Not sure.
But what is possible is that you can only turn two cards and then the turn goes to someone else. This is possible with union types.

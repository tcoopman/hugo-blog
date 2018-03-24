+++
date = "2018-03-21T15:16:24+02:00"
draft = false
title = "Elixir and Nerves beginner workshop"
slug = "elixir-and-nerves-beginner-workshop"
tags = ["elixir", "nerves", "raspberry pi", "rbp"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= "workshop"		# set "main" to add this content to the main menu
author = "Thomas Coopman"
+++

## What?

Have you ever played looked at elixir and thought, this looks like a cool language with nice features. This is a language that I want to know?
Have you ever thought about toying with a raspberry pi or an arduino, playing with some leds, buttons, but never got around to it, or thought it would take too much time to start with it.
Maybe you're just interested in functional programming, or you want to learn a new programming language?

This is your chance to do all of this! In this beginner friendly elixir workshop we will learn the basics of elixir by building our own [pomodoro timer](https://en.wikipedia.org/wiki/Pomodoro_Technique).
If you this sounds like something you want to change, then come to this one day, *high intensity* workshop.

You want a bit more convincing, you want to know what this elixir or nerves is? Read on to see if this is something for you!

### Elixir

> Elixir is a dynamic, functional language designed for building scalable and maintainable applications.
> Elixir leverages the Erlang VM, known for running low-latency, distributed and fault-tolerant systems, while also being successfully used in web development and the embedded software domain.
> ([https://elixir-lang.org/](https://elixir-lang.org/))

If you read this description from the elixir website than you should already have a good grasp of what it can leverage for you, but let's jump a bit deeper:

* a dynamic, functional language: dynamic yes, but also compiled, with pattern matching, immutability,...
* Elixr runs on the Erlang VM (BEAM) and this enables you to build highly distributed fault-tolerant systems. In the workshop we won't be able to go deep into the distributed part, but we will touch upon it, as well as on the fault-tolerant system.
* The default web framework is [Phoenix](http://phoenixframework.org/) which allows you to build fast, scalable web applications.
* Something that's also important is that it's gives a lot of importance to developer happiness.

### Nerves

You might have read it but Erlang is well known in the embedded software domain, and Nerves is that project that leverages this power for Elixir.

> Nerves lets you craft and deploy bulletproof embedded software in Elixir.
> ([https://nerves-project.org/](https://nerves-project.org/))

Nerves lets you very easily build a custom minimal firmware for your hardware. You have the full power of Elixir at your fingertips and are able to do anything you want with some hardware projects. Nerves also provides you with over the air firmware updates, a fallback to the previous version if your new firmware version fails,...

In other words, a rock solid platform for building your hardware projects!

### Hardware projects in a professional environment

Maybe you're thinking, a pomodoro timer is fun, but that's not very useful for me (You already know when to take breaks!), what can I do with the hardware in a professional environment? Anything you can imagine I would say, but here are some concrete and simple projects:

* A buzzer and light when the build is broken
* A button to deploy to production
* A status board that displays the sprint progress
* A buzzer when something breaks in production
* Create a moodboard, for example visualize the number of commits made to master today
* ...

## Convinced?

Then read on, for all practical information!

### You'll walk away with

* Basic knowledge of Elixir
* Understanding of OTP (actor model)
* A tiny bit of electronics
* Some functional programming concepts
* Some hardware to play with - Your own pomodoro timer (a raspberry pi, some leds, some buttons,...) to play with at home
* Enough knowledge and hardware to keep playing at home/work, learn more and improve.

### Target audience

* Interested in Elixir but no or not a lot of prior knowledge
* Loves to play and tinker with hardware
* Ready for an intensive day of coding, thinkering and learning!

### Prerequisites

* Programming knowledge in any language
* You will need a laptop with linux or a mac. If you have a windows machine you will need a linux virtual machine. Your laptop needs to be able to read a micro sd or regular sd card.
* Some instructions will be send up front
* You will work on your own solution, but be prepared to pair/mob on some parts
* Make sure you have plenty of energy, it will be intense!

### Agenda

You can expect these steps:

* Introduction to elixir
* Basic concepts of elixir
* Playing in the REPL
* Basics of OTP (GenServers!)
* Installing nerves on a raspberry pi
* Lighting a led with elixir
* Implementation of a pomodoro timer
* Creating a circuit for the pomodoro timer

If the time allows it:

* Adding an api/web application to configure the pomodoro timer
* Think about testing the nerves hardware implementation
* Distributed team pomodoro timer

Did I say it will be an intense workshop?

There is enough material to fill a 2 day workshop, but to lower the entry cost, we're doing this in a one day workshop and cut some of the more advanced topics. This means that the one day workshop will cover more than 8 hours, probably something like 10, so be prepared for this!

We'll start at 09:00 sharp, we will have regular breaks and expect the end around 18:30 - 19:00.

### When

To be defined, probably somewhere in the second half of May.

### Where

The location is not yet known, but it will be in the broad area of Gent/Antwerpen.

### Cost and what's included

The price for the 1 day training is (VAT not included): 580 euro.

Included in the price:

* 1 day training
* Hardware: raspberry pi with micro sd card and power adaptor, some leds, some buttons, a breadboard (yes you can take this with you!)
* Lunch
* Water and coffee and some snacks

Enrollment closes 2 weeks up front.
There are a limited amount of 16 places, so be quick!

### Tickets

You can buy a ticket by clicking the button below. Please fill in your company details if you wish to receive an invoice.

**Coming soon**

Tickets are non-refundable, but can be transferred to another person if you choose to do so (enrollments are not bound to a specific person). If you have a good reason why you can't make it, please contact me and we'll see what can be done.
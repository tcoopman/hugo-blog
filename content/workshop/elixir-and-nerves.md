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

Have you ever looked at Elixir and thought, this looks like a nice language with great features. This is a language that I want to know!
Have you ever thought about toying with a raspberry pi or an arduino, playing with some leds, buttons, but never got around to it thinking it would take too much time to start with it.
Maybe you're just interested in functional programming or you want to learn a new programming language?

This is your chance to do all of this! In this beginner friendly Elixir workshop we will learn the basics of Elixir by building our own [pomodoro timer](https://en.wikipedia.org/wiki/Pomodoro_Technique).

If this sounds like something you want to learn, then come to this one day, *high intensity* workshop.

Want more convincing, you want to know what this Elixir or Nerves is? Read on to see if this is something for you! ([Convinced](#convinced))

### Elixir

> Elixir is a dynamic, functional language designed for building scalable and maintainable applications.
> Elixir leverages the Erlang VM, known for running low-latency, distributed and fault-tolerant systems, while also being successfully used in web development and the embedded software domain.
> ([https://elixir-lang.org/](https://elixir-lang.org/))

If you read this description then you should already have a good grasp of what it can bring for you, but let's jump a bit deeper:

* A dynamic, functional language: dynamic yes, but also compiled, with pattern matching, immutability,...
* Elixir runs on the Erlang VM (BEAM) and this enables you to build highly distributed fault-tolerant systems. In the workshop we won't be able to go deep into the distributed part, but we will touch upon it, as well as on the fault-tolerant system.
* The default web framework is [Phoenix](http://phoenixframework.org/) which allows you to build fast, scalable web applications.

### Nerves

You might have read it but Erlang is well known in the embedded software domain, and Nerves is that project that leverages this power for Elixir.

> Nerves lets you craft and deploy bulletproof embedded software in Elixir.
> ([https://nerves-project.org/](https://nerves-project.org/))

Nerves lets you very easily build a custom minimal firmware for your hardware. You have the full power of Elixir at your fingertips and are able to do anything you want with some hardware projects. Nerves also provides you with over the air firmware updates, a fallback to the previous version if your new firmware version fails,...

In other words, a rock solid platform for building your hardware projects!

### Hardware projects in a professional environment

Maybe you're thinking, a pomodoro timer is fun, but that's not very useful for me, what can I do with the hardware in a professional environment? *Anything you can imagine* I would say, but here are some concrete and simple projects:

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
* Ready for an fun and intensive day of coding, thinkering and learning!
* Any of the above

### Prerequisites

* Programming knowledge in any language
* You will need a laptop with linux or a mac. If you have a windows machine you will need a linux virtual machine. Your laptop needs to be able to read a micro sd or regular sd card.
* Some instructions will be send up front
* You will work on your own solution, but be prepared to pair/mob on some parts
* Make sure you have plenty of energy, it will be intense!

### Agenda

You can expect these steps:

* Introduction to Elixir
* Basic concepts of Elixir
* Playing in the REPL
* Basics of OTP (GenServers!)
* Installing Nerves on a raspberry pi
* Creating a simple circuit
* Lighting a led with Elixir
* Implementation of a pomodoro timer
* Creating a circuit for the pomodoro timer

If the time allows it:

* Adding an api/web application to configure the pomodoro timer
* Think about testing the Nerves hardware implementation
* Distributed team pomodoro timer

Did I say it will be an intense workshop?

There is enough material to fill a 2 day workshop, but to lower the entry cost, we're doing this in a one day workshop and cut some of the more advanced topics. This means that the one day workshop will cover more than 8 hours, probably something like 10, so be prepared for this!

We'll start at 09:00 sharp, we will have regular breaks and expect the end around 18:30 - 19:00.

### When

Friday May 25th from 09:00 to 19:00

### Where

The location is not yet final, but it will be in the broad area of Gent/Antwerpen.

### Cost and what's included

The price for the 1 day training is (VAT not included): 560 euro.

Included in the price:

* 1 day training
* Hardware: raspberry pi with micro sd card and power adaptor, some leds, some buttons, a breadboard (yes you can take this with you!)
* Lunch
* Water and coffee and some snacks

Enrollment closes 2 weeks up front.
There are a limited amount of 16 places, so be quick!

### Tickets

<!-- Ticket Tailor Widget. Paste this in to your website where you want the widget to appear. Do no change the code or the widget may not work properly. -->
<div class="tt-widget"><div class="tt-widget-fallback"><p><a href="https://www.tickettailor.com/new-order/157073/21a4/ref/website_widget/" target="_blank">Click here to buy tickets</a><br /><small><a href="http://www.tickettailor.com?rf=wdg" class="tt-widget-powered">Sell tickets online with Ticket Tailor</a></small></p></div><script src="https://dc161a0a89fedd6639c9-03787a0970cd749432e2a6d3b34c55df.ssl.cf3.rackcdn.com/tt-widget.js" data-url="https://www.tickettailor.com/new-order/157073/21a4/ref/website_widget/" data-type="inline" data-inline-minimal="true" data-inline-show-logo="false"  data-inline-bg-fill="false"></script></div>
<!-- End of Ticket Tailor Widget -->

Please fill in your company details if you wish to receive an invoice.

Tickets are non-refundable, but can be transferred to another person if you choose to do so (enrollments are not bound to a specific person). If you have a good reason why you can't make it, please contact me and we'll see what can be done.
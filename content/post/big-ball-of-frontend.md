+++
date = "2017-09-27T14:39:00+01:00"
draft = false
title = "A big ball of frontend"
slug = ""
tags = ["frontend","microservices"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = "Thomas Coopman"
+++

Tonight I'm giving a talk at [Fronteers](https://fronteers.nl/bijeenkomsten/2017/teamleader) about Frontend microservices. Mind you, I don't want to go into what a microservice is, so a talk about Frontend services is fine as well.

What is important for me is that we're not building a big ball of frontend. We're paying so much attention to having a good architecture on the backend, with lots of (micro)services but at the same time, we're building one huge single page application (SPA). The talk I'm giving is about how we can prevent that, and what alternatives are for the huge SPA.

This blog is a real short introduction into the talk. You can find the slides below, hopefully they give you enough of information, and if you still want to know more, just ask me!

There is no reason why you can't apply architectual patterns to a frontend application as well. Don't just go out building whatever if you would not do that for your backend as well. There are a lot of questions you can ask yourself, do we really need a SPA or does this only benifit some parts of our application?
If you do decide that you need a SPA, are you ready to commit on one frontend framework/library, maybe ~~in a couple of years~~, ~~in a year~~, ~~next month~~, tomorrow there will be a cooler, faster, better library available that you want to use, and now your whole application is written in *enter framework here*.

How many people are working on your frontend, do you have multiple teams working on the backend, why not on the frontend as well? So let's split our frontend in multiple services/applications so multiple teams can work on it.

The talk below goes into some techniques that can be used to do this. The slides are low on detail, most of the meat is in the talk, but if I get poked enough I might write more details down or give an other talk. The important thing is that this is not rocket sience, it's not that hard. If you're able to create architecture for your backend, you should be able to do it for your frontend as well.

Go to the [slides](https://tcoopman.github.io/big-ball-of-frontend-talk/)!
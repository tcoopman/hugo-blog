+++
date = "2014-09-29"
tags = ["other"]
title = "Creating this site"
description = "Why, but mostly how I've created this site."
draft = false
+++

_This is not valid anymore. The site is build with hugo_

This blogpost will be a about the why, but mostly about how I've created
this site.

I've created this site mostly for these reasons:

- Make myself visible on the web.
- Practice my design and web-development skills.
- Practice my writing (blog).
- Record things I've learned for myself. Maybe someone else will find
  something useful here.

# Content

The contents of this site contain information about me, to make me more
visible on the web. The site includes a blog with primarly technical content. In
the first place javascript and web-development although this can change
depending on my interests at that moment and what I'm working about.

Secondly, I'll try to blog about some of my hobbies (hiking for example),
but that will be very occasional.

# Framework

I've created this site in [Reactjs](http://facebook.github.io/react/), my
current favorite javascript framework that I like for the same reasons everyone
else likes it. There are lots of blogs
about react so I'll try to keep the redundancy low and only talk about the new
things.

I'm using [react-router](https://github.com/rackt/react-router) for the routing.
At the moment of writing there are some shortcomings
(mostly no server-side rendering<sup>1</sup>), but these guys are working
on that and we can expect it shortly. As soon as server side rendering is
supported, I'll add it so this site can be easily searched with
Google, and then it should also be mostly useful without javascript.

For the css I'm using the [stylus](http://learnboost.github.io/stylus/) preprocessor.
I've tried Less and Sass in the past but I like stylus, and this site is a
good way of exploring it. I try to keep the site low on css and don't
use a framework like bootstrap or foundation.

# Blog

The blog is written with my own implementation of a React markdown component
that I've [published](https://github.com/tcoopman/markdown-react)<sup>2</sup>. In short, it uses an existing markdown parser,
but instead of rendering a html string, it renders React components. The cool
thing about this is that you can have full control over the React components, so
you can do all kind of cool things with. For example add a custom subscript
to every image or parse different html than what you normally want (like I do in
this blog. Here I render &lt;h2&gt; elements instead of &lt;h1&gt;). Of course you can do
all these things if you know something about parsing, but this component makes this
super easy if you know React, just substitute the main component for your own and
you're started. I'm planning on writing a short blog post about this component too.

Stay tuned!

# Hosting and deploying

I build this site with gulp and webpack. My boilerplate package
can be found at [boilerplate-webpack-react](https://github.com/tcoopman/boilerplate-webpack-react).
This site uses a very similar build, with some adaptations for the blog.

This website is hosted on [DigitalOcean](https://www.digitalocean.com/) with Nginx.
At the moment it's just a static app, but as soon as react-router supports server
rendering I'm going to implement it. I need to set up automatic deployment, probably with git.
I don't build my site on the server. I push the build to the server.
When server side rendering is implemented, the way I deploy my code will change
and I also have a blog about that in the pipeline.

# Conclusion

A custom implementation of a blog, custom css and hosted on a vps. And that for
a static site. It's a bit more work, and you could say it's not a best practice
to do things this way, but it's a good way to experiment and try new things and
that's exactly what I want to do with this site.

---

<sup>1</sup> This has been fixed in a recent version.

<sup>2</sup> I've switched to [remarkable](https://github.com/jonschlinkert/remarkable)

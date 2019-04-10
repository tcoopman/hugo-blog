+++
title = "The Ergodox Ez Keyboard"
date = 2019-04-06T10:01:59+02:00
draft = false
tags = ["Ergonomic", "Ergodox"]
comments = true
share = true
+++

I think it was somewhere last year that I felt some pain in some of the fingers of my right hand for the first time. Mostly my thumb and pink felt uncomfortable.
Around the same period I also felt some pain in my right shoulder. It wasn't exactly at the same time but I found it a little disturbing knowing that as a developper these are things to watch out for.
Before last year I never had any issues, so I wasn't worried too much and felt that some attention to it would hopefully make it better.

One of the things I tried to do was to be careful with my smartphone usage and after a short while my hand started getting better. My shoulder took a bit longer, but at the time I didn't link it
to my posture and mouse usage yet, because I thought I strained it a bit during sports.
I'm already using a high/low desk, and I try to change positions throughout the day, so after that episode I didn't give this any further attention.

Jump to a week or two ago and the shoulder pain was back. I doesn't feel very bad and I don't feel it all the time, but it might be time to be more careful with it, I need it for a long time still. I started thinking and went on to look for possible solutions. I bought a more ergonomic mouse and bought the Ergodox EZ keyboard. It's very expensive, especially after paying the import costs (+400 euro).
Yesterday it arrived after paying the import rights, making sure that I had a valid number for the douane. It was the first time I tried a keyboard in 2 parts.

{{% figure src="/images/ergodox/ergodox.jpg" caption="*What a weird feeling to type on a disconnected keyboard.*" %}}

My first impression was that it felt super weird to type on a disconnected board. I had to force my brain to into typing. Because of the disconnection it didn't feel like a keyboard at all to my brain (and it took some hours to get over this - altough it still feels a bit weird today, but it's a lot better than yesterday.) It felt that my hands weren't working together anymore like they are on a regular keyboard, but because I forced myself, I noticed that that worked as well.
The second thing I noticed is that a lot of the thumb keys feel too far to reach in regular typing. Luckely there is something super awesome about this keyboard and that's the [configurator](https://configure.ergodox-ez.com/layouts/default/latest/0). With this tool you can configure your keys and up to 32 layers of different keyboard layouts. So you can basically do anything you want.

```bash
# flash a new firmware
teensy-loader-cli -w -v -mmcu=atmega32u4 ~/path/to/firmware.hex
# after you execute this command, press the reset button on the upper right of your keyboard and watch it reload
```
{{% figure src="/images/ergodox/lights.jpg" caption="*red and orange are special keys, also notice how so thumb keys are too far to use regularly*" %}}

I've immediatly started taking notice for what keys were hard to reach and started remapping for the start. For example I've put *ESC* close by and created a layer for navigation my i3 window manager. This is probably something that will be really useful, and I'm already thinking about adding some mappings for tmux and vim as well. To really use this well, I think I will need to pay close attention to what kind of keys that are hard to reach or that I mistype a lot (I'm not happy yet with the position of all the types of brackets `[({...`). 

A keylogger that creates a hotspot map on my own keyboard layout would be super useful for this. Thinking this wouldn't exist yet, so I've searched and see the first result for *ergodox heatmap* in google: https://github.com/naps62/ergodox-heatmap-generator. This is something I'm going to check out.

{{% figure src="/images/ergodox/example_heatmap.png" caption="*this could be useful in improving my layouts*" %}}

The keyboard has an orthogonal layout and although it takes some getting used to, I don't feel like that will hamper my typing speed a lot. After some hours of typing and on the second day, I feel that I'm sometimes already reaching 60-70% of my original typing speed on regular text. Code and navigation will probably be slower.

To test this I've done some tests on https://keyhero.com/ and https://typing.io/. For regular text I got 75WPM for my old keyboard (that was directly after switching back from some hours of the ergodox so that probably can be quite a bit higher) and with the Ergodox I got 52 and 54WPM on the first and second day. For typing code, I got 50WPM with the regular and 27WPM with the Ergodox. So this is surely some loss in efficiency and that is to be expected. And althoug I agree that *typing speed is not the bottleneck for producing software*, I've always found it important to be fluent at typing and not have it hamper me all the time. For now with the Ergodox, this is still a the case. Regular typing feels already quite good, but the problem is that when I make a mistake, sometimes I have to think for a second about what is the fastest key (and key location) to fix it. Probably this will improve fast if I use the keyboard a lot.

Switching back to a regular keyboard already felt a bit weird, so I'm not sure how that will go daily, I won't buy a second Ergodox and won't take it everyday to work, but I'm confident that switching between keyboards will become natural after a while (I'm still pretty capable of switching to Azerty if needed).

My last remark about the keyboard is that it's a mechanical keyboard and I'm not yet sure if I like that 100% (The second day this already feels better than the first day, but it makes more noise than I'm used to).

All in all it's a little early to give solid feedback on the keyboard, but it is fun to play with, feels good and some change of position won't hurt I hope.

For the pain in my shoulder and fingers. I think the pain in the pink should get better because I won't have to reach that far anymore with my right hand on the new keyboard. The shoulder should also have some improvement. Because of how I place my arms but that is still something I will need to experiment with, how it feels in a standing and sitting position at my high-low desk.

I also think that my mouse usage is the biggest issue for the shoulder, and I'm thinking that maybe using a trackball can help further. for example something like the [Elecom Wireless Trackball Mouse](https://www.amazon.com/ELECOM-M-HT1DRBK-Wireless-Trackball-Mouse/dp/B0735584RM). Also not using the mouse a lot should help, but I'm already doing that with keyboard navigation for about everything (window manager i3 and vimperator).

As a last thought these things might also help:

1. Regular exercise. I've noticed that in periods that I excercise/fitness, my shoulder got better. If only I didn't find fitness such a dread.
2. I could try to switch my mouse usage between left and right hand. I'm left handed and use my mouse in my right hand, switching should not be that hard if I have a left handed mouse as well.
3. Have more attention for pain and stop and switch positions when I feel things that don't feel right.

We'll see how it goes from here. I've finally written a blog post again (I need practice with the new keyboard anyway) and maybe some of you have other solid advice.

One small last thing. After a night of sleep, the keyboard feels a lot more natural already. It's awesome how the brain works!

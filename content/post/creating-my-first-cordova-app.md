+++
date = "2014-09-29"
draft = true
tags = ["blog", "cordova", "react"]
title = "Creating my first cordova app"
description = "Getting started with cordova and React."
+++

# installation on ubuntu 14.04

## prerequisites

`sudo apt-get install default-jdk`

`sudo apt-get install ant`

npm install -g cordova
android sdk http://developer.android.com/sdk/index.html

# creating a project

in folder
`cordova create test-app`
`cd test-app`

set the android emulator
`PATH=$PATH:~/Software/android-sdk-linux_x64/platform-tools/:~/Software/android-sdk-linux_x64/tools/
`
`android`
installed Android 4.4.2 (API 19)

add a platform
`cordova platform add android`

# set everything in www

# run

connect device in debugg

`cordova run android`

# emulate

android
tools
`cordova emulate android`

# webview

`chrome://inspect/#devices`
https://developer.chrome.com/devtools/docs/remote-debugging#debugging-webviews

https://issues.apache.org/jira/browse/CB-5487
http://www.raymondcamden.com/2014/1/2/Apache-Cordova-33-and-Remote-Debugging-for-Android

# install

`cordova build android`

# The project

React website with React-Router. Make sure you don't set history for location or it will not start.


# Resources

[0](https://www.npmjs.org/package/cordova)
[1](http://cordova.apache.org/)

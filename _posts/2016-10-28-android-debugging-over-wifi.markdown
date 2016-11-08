---
layout: post
title:  "Android debugging over wifi"
author: axhm3a
date:   2016-10-25 10:14:00
description: Android debugging over wifi
categories:
- blog
- android
- tooling
permalink: android-debugging-over-wifi
---

while i was working in office i just wanted to put a new apk build on my mobile device.
unfortunately i missed to grab my usb cable at home.

luckily a colleague of mine borrowed my his cable for a minute. so how to setup adb debugging over wifi?

* Connect the device via USB and make sure debugging is working.

* let your device listen on port 5555: `adb tcpip 5555`

* find the IP address of your phone in the details of your wifi connection

* connect your debugger to your device over network:
  `adb connect <PHONE_IP_ADDRESS>:5555`

* Disconnect your USB cable and let electromanic waves do their thing while debugging :)

[credits goes to Daniele Segato @ stackoverflow](http://stackoverflow.com/a/10236938)

---
layout: post
title: "Orange PI Zero"
date: "2019-05-08 21:31:35 +1000"
author: wouter
layout: post
tags: {"orange pi", "armhf"}

categories:
  - raspberry pi
  - orange pi
---
Recently I got one of those tiny computers for some home projects. After some research in what's available I decided to go for one of those [Orange pi zero](http://www.orangepi.org/orangepizero/) devices.
The main reason to go for this one, is that is comes with build in wifi and a reasonable amount of memory for my intention, has a faster chip than the raspberry pi and a better price tag.

The ordering was straight forward via ebay, as there are no resellers in Australia. And after lot's of waiting it finally arrived.

Before the Orange Pi arrived, a sd-card and a power adapter already where there, so I could start immediately (I thought). This became eventually quite a bit of a struggle, as the no-brand class 10 sd-card I got, turned out to be to slow for the uboot / boot sequence. The image I am using is the Ubuntu server from [Armbian](https://www.armbian.com/orange-pi-zero/)

This meant that I had to wait another day or 2 before a got hold on a decent sandisk sd-card, that worked flawlessly.

I did find one nice feature that came with the 'broken' sd-card, and that is, that it will allow me to boot from a usb memory stick. That is, the boot loader is loaded from the sd-card (no way around that) and as the card is to slow in presenting the kernel, the boot loader will continue and find one on the usb-stick. So this effectively means that I can boot from a usb stick, which is helping me with setting up an encrypted root filesystem.

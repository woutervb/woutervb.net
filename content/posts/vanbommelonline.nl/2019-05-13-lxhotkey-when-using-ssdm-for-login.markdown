---
layout: post
title: "lxhotkey when using ssdm for login"
date: "2019-05-13 09:53:36 +1000"
categories:
  - lubnutu
  - ubuntu
tags: {"lxqt"}
---
Recently I switched DE (desktop environment) from Plasma to lxqt. The change itself is quite simple, it basically means executing: `sudo apt install lubuntu-desktop`

Once the installation is complete, only an desktop environment is giving that is really limited in the way it is setup. The most annoyn thing for me was the fact that my keyboard sound (volume) buttons did not work. So I started looking on the internet what might be the cause for this.

Eventually is boils down to the fact that you have to setup this yourself, usind the lxhotkey application. And that was giving me constant problems.
Everytime I launched it, I would get an dialog with the title: `error` and the text `Sorry, cannot configure keys remotely.` When looking to a github [ticket](https://github.com/lxde/lxhotkey/issues/2) I to noticed that I was lacking the file `/tmp/.X0-lock`.

The solution, to get the application working was eventually the following 2 commands from a terminal:
~~~~ bash
touch /tmp/.X0-lock
lxhotkey
~~~~

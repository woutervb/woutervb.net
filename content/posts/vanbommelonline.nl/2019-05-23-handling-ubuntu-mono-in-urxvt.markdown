---
layout: post
title: "Handling Ubuntu Mono in Urxvt"
date: "2019-05-23 16:45:49 +1000"
categories:
  - ubuntu
tags: {"Ubuntu Mono", "Urxvt"}
---

When working with urxvt the 'default' way of working with the powerline font's does not appear to be working.
The work around is, installing a patched version of the font in your local home directory.

This can be done using the following lines of code:

~~~~bash
cmd=$(pwd)
tmp=$(mktemp -d)
cd ${tmp}
wget https://github.com/powerline/fonts/archive/master.zip
unzip master.zip
mv fonts-master/* ~/.local/share/fonts/
cd ${cmd}
rm -r ${tmp}
fc-cache -vf ~/.local/share/fonts
~~~~

And now, use the following line in your ~/.Xresource file:

     URxvt*font: xft:ubuntu mono derivative powerline:pixelsize=12:antialias=true:hinting=true

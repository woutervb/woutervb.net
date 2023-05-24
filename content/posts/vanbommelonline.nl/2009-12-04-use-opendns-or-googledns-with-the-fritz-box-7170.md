---
id: 32
title: Use Opendns or Googledns with the fritz box 7170
date: 2009-12-04T19:11:00+00:00
author: wouter
layout: post
guid: http://vanbommelonline.nl/?p=32
permalink: /2009/12/04/use-opendns-or-googledns-with-the-fritz-box-7170/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter
blogger_permalink:
  - /2009/12/use-opendns-or-googledns-with-fritz-box.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/6551498662601604741
categories:
  - fritzbox
  - googledns
  - opendns
  - xs4all
---
Like one of the many xs4all customers I am the (proud) owner of a fritzbox 7170 to facilitate my internet connection.

One of the issues with this modem is the absence of overriding all settings. One of the things that cannot be changed are the dns server that are used by the fritz box itself or the clients served via the fritz box dnsmasq.

However there is a solution, which goes via the following steps:

  1. Enable the telnet daemon by dailing: `#96*7*`
  2. login the fritz model using telnet (use either the dns name `fritz.box`, or the ip adress, default `192.168.178.1`)
  3. `nvi /var/flash/ar7.cfg`
  4. use the / to search for overwritedns1 & overwritedns2
  5. fill in the ip addresses of the servers from opendns or google (resp. `208.67.222.222` & `208.67.220.220` or `8.8.8.8` & `8.8.4.4`)
  6. repeat steps 4 & 5 once (both entries should occur twice)
  7. save the file and quit nvi (:wq)
  8. reboot the modem by the command reboot

Check if the settings are active. Dns lookups should be faster and when using opendns more control is available.
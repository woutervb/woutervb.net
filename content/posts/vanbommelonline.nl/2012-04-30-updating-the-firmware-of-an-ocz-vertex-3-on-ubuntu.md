---
id: 19
title: Updating the firmware of an OCZ Vertex 3 on ubuntu
date: 2012-04-30T12:32:00+00:00
author: wouter
layout: post
permalink: /2012/04/30/updating-the-firmware-of-an-ocz-vertex-3-on-ubuntu/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2012/04/updating-firmware-of-ocz-vertex-3-on.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/2877053130942233978
categories:
  - debian
  - linux
  - ssd
  - SuSE
  - ubuntu
---
Updating a SSD firmware might seem like a big step on linux, as the biggest audience for the ssd manifacturers are windows users.

This means that a lot of tooling and documentation is around on the internet explaing on how todo this on a windows based system.

In the case of OCZ the tool used to update the firmware is linux based, or at least there is a linux based version available. This tool can be used to update the ssd from (Ubuntu) linux, even if it is the primairy disk drive. The steps involved are simple:

  1. Download the tool from OCZ http://www.ocztechnology.com/files/ssd\_tools/fwupd\_v2.12.05.tar.gz<a href="http://www.ocztechnology.com/files/ssd_tools/fwupd_v2.12.05.tar.gz" target="_self" title=""></a>
  2. Unpack the tool: tar xfvz fwup*
  3. Execute the tool as root: sudo ./linux[32|64]/fwupd
  4. Reboot the machine

&nbsp;
---
id: 21
title: Simple restore of an debian based linux installation
date: 2012-04-20T06:48:00+00:00
author: wouter
layout: post
permalink: /2012/04/20/simple-restore-of-an-debian-based-linux-installation/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2012/04/simple-restore-of-debian-based-linux.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/7780548855805547184
categories:
  - backup
  - debian
  - package management
  - python
  - restore
  - ubuntu
---
Some time ago I had to reinstall a deb based system, which meant installing the packages and configure them.

During the configuration I had to rethink how the system was originally configured, without having a proper backup of the system. Some of issues where that the backup contained some configuration files, but files referenced where not included.

To overcome this problem I started creating a small piece of code (and placed it on github) which implements the following idea:

  1. make a listing of all package files installed
  2. for every package file check if the configuration files are changed in relation to the packager provided ones
  3. for some special packages check the configuration files and include any referenced locations
  4. Combine the above information to a &#8216;restore&#8217; script. This script will contain all information to reinstall the packages and configuration, based on this information. The only requirement is a basic bootable (compatible) OS installation.
  5. Optionally this can be used to update a systtem to a newer version, using a clean installation.

For those interested, have a peek at the work-in-progress on github:  
<https://github.com/woutervb/deb-dr>
---
id: 30
title: Building puppet for SLES 10 (SP4)
date: 2011-04-19T12:58:00+00:00
author: wouter
layout: post
guid: http://vanbommelonline.nl/?p=30
permalink: /2011/04/19/building-puppet-for-sles-10-sp4/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter
blogger_permalink:
  - /2011/04/building-puppet-for-sles-10-sp4.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/4152238875461413830
categories:
  - configuration management
  - puppet
  - sles
  - SuSE
---
It turns out to be surprisingly easy to create a basic puppet client package.

The steps involved are:  
 - download ruby from the opensuse ([ruby-1.8.6.p36-4.1.i586.rpm](http://software.opensuse.org/search/download?base=ALL&file=openSUSE%3A%2Finfrastructure%2FSLE_10%2Fi586%2Fruby-1.8.6.p36-4.1.i586.rpm&query=%22ruby%22),&nbsp;[ruby-1.8.6.p36-4.1.src.rpm](http://software.opensuse.org/search/download?base=ALL&file=openSUSE%3A%2Finfrastructure%2FSLE_10%2Fsrc%2Fruby-1.8.6.p36-4.1.src.rpm&query=%22ruby%22),&nbsp;[ruby-1.8.6.p36-4.1.x86_64.rpm](http://software.opensuse.org/search/download?base=ALL&file=openSUSE%3A%2Finfrastructure%2FSLE_10%2Fx86_64%2Fruby-1.8.6.p36-4.1.x86_64.rpm&query=%22ruby%22))  
 - download facter from opensuse ([facter-1.5.7-1.1.i586.rpm](http://software.opensuse.org/search/download?base=ALL&file=system%3A%2Fmanagement%2FSLE_10%2Fi586%2Ffacter-1.5.7-1.1.i586.rpm&query=facter),&nbsp;[facter-1.5.7-1.1.src.rpm](http://software.opensuse.org/search/download?base=ALL&file=system%3A%2Fmanagement%2FSLE_10%2Fsrc%2Ffacter-1.5.7-1.1.src.rpm&query=facter),&nbsp;[facter-1.5.7-1.1.x86_64.rpm](http://software.opensuse.org/search/download?base=ALL&file=system%3A%2Fmanagement%2FSLE_10%2Fx86_64%2Ffacter-1.5.7-1.1.x86_64.rpm&query=facter))  
 - download the puppet src.rpm from opensuse ([puppet-0.25.5-1.1.src.rpm](http://software.opensuse.org/search/download?base=ALL&file=system%3A%2Fmanagement%2FSLE_10%2Fsrc%2Fpuppet-0.25.5-1.1.src.rpm&query=puppet))  
 - download the puppet tar from puppetlabs (2.6.7 is the current one,&nbsp;<http://puppetlabs.com/downloads/puppet/puppet-2.6.7.tar.gz>)

Install the ruby & facter package for the desired architecture (i586 = 32bit, x86_64 = 64bit).  
Install the `puppet src.rpm`  
Move the `puppet-2.6.7.tar.gz` file to `/usr/src/packages/SOURCES`

Edit the `puppet.spec` file located in `/usr/src/package/SPECS`, change the lines Version and Release so that the read:

    Version: 2.6.7  
    Release: 1.2

  rebuild the puppet package with the following command:

     rpmbuild -ba puppet.spec

 Install the puppet.*arch*.rpm found in `/usr/src/packages/RPMS/<arch>/`

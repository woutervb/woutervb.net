---
id: 34
title: Subversion and SLES 10
date: 2009-08-20T15:10:00+00:00
author: wouter
layout: post
guid: http://vanbommelonline.nl/?p=34
permalink: /2009/08/20/subversion-and-sles-10/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter
blogger_permalink:
  - /2009/08/subversion-and-sles-10.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/3143689211028465390
categories:
  - python
  - sles
  - subversion
  - SuSE
  - svn
---
<span style="font-weight: bold;">Introduction</span>  
Starting with Subversion on SLES* 10 SP 2 is not trivial. The problem is that this version of SuSE comes with an ancient version on an unsupported SDK.  
The version works with respect to the commandline options, the basic functions like add / update / delete / checkout are all fine.

<span style="font-weight: bold;">The problem</span>  
But the issue lies in the usage of the python bindings. The supplied bindings are the swig one&#8217;s. This effectively means that writing some python script that uses svn is just as hard work as writing the same application in C.

This is really a shame so I went out to look for a solution so that the pysvn python interface can be used. This (up to date) interface uses more familiar concepts like object to represent svn stuctures and command.

<span style="font-weight: bold;">The solution</span>  
The only way that (until now) seems to work is using the search function on <http://software.opensuse.org/search>. With this function the following packages can be found (they are all needed for client side update&#8217;s):  
&#8211; libapr1-1.3.8-1.1.*  
&#8211; libapr-util1-1.3.9-1.1.*  
&#8211; neon-0.26-1.10.*  
&#8211; python-pysvn-1.7.0-1.7.*  
&#8211; subversion-1.6.4-1.1.*  
&#8211; subversion-python-1.6.4-1.1.*

These combination of packages seem to give a working environment, now some coding can start.

*SLES is an acronym for SuSE Linux Enterprise Server, the commercial supported variant of opensuse
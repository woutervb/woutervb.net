---
id: 20
title: 'SuSE linux Enterprise server rpm&#8217;s for Git'
date: 2012-04-28T15:13:00+00:00
author: wouter
layout: post
permalink: /2012/04/28/suse-linux-enterprise-server-rpms-for-git/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2012/04/suse-linux-enterprise-server-rpms-for.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/5127024093919996551
categories:
  - buildservice
  - git
  - opensuse
  - rpm
  - sles
  - SuSE
  - svn
---
Git (<http://git-scm.com/>) is one of the modern version management systems available at the moment. This tool is still changing a lot in features from version to version, so having an older version available can be a problem for Enterprise environments.

One issue I encountered myself was the lack of (or introduction of) the smart-http transport released in version 1.6.6 (<http://progit.org/2010/03/04/smart-http.html>). Extremely useful in an Enterprise environment as it is simpler to manage usernames and passwords then ssh key&#8217;s and operating system users.

Unfortunately SuSE Linux Enterprise Server 11 (up to Service Pack 2) does not go any further an version 1.6.0. This meant I had to build my own updated rpm&#8217;s.

To build these rpm&#8217;s I used the OpenSuSE buildserver, which means that they are available for everybody.  
The build rpm&#8217;s (with the SuSE patches applied) can be found at:&nbsp;<https://build.opensuse.org/package/repositories?package=git&project=home%3Awvanbommel%3Agit-scm>

Packages are provided for:

  * SLES 11
  * SLES 11 SP 1
  * SLES 11 SP 2

<div>
  At the time of this write, version 1.7.10 is in the making and will be published in a short time.
</div>
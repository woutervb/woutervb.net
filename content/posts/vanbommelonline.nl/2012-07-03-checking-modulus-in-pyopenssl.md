---
id: 15
title: Checking modulus in pyOpenSSL
date: 2012-07-03T14:14:00+00:00
author: wouter
layout: post
permalink: /2012/07/03/checking-modulus-in-pyopenssl/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2012/07/checking-modulus-in-pyopenssl.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/6035054492807844641
categories:
  - c
  - launchpad
  - patch
  - pyOpenSSL
  - python
---
More then a year ago I wrote a small patch for pyOpenSSL.

This patch makes it possible to compare the modulus of both the private key and a public key, in order to confirm a cryptographic match between them.  
As I have not (yet) made some unit tests, this code is not in them main release.

But as the code is in use in my companies systems, this blog will make it a bit more findable, and maybe more people are interested in this interface addition.

Details can be found using the link below. <https://bugs.launchpad.net/pyopenssl/+bug/735449>
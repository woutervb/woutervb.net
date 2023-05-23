---
id: 16
title: Using uniquely defined key-value on a central server in puppet
date: 2012-06-29T13:24:00+00:00
author: wouter
layout: post
permalink: /2012/06/29/using-uniquely-defined-key-value-on-a-central-server-in-puppet/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2012/06/using-uniquely-defined-key-value-on.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/5464902857502330176
categories:
  - configuration management
  - git
  - github
  - hiera
  - puppet
---
In the [previous post](http://vanbommelonline.nl/?p=17) I wrote about an application capable of storing key-value pairs in an hierarchical way.

As this application has an rest interface to request the elements I also wrote an pupper hiera backend. This backend does allow one to use the key-value pairs defined in the application to be used in puppet manifests.

This plugin can be found on github <https://github.com/woutervb/hiera-central_property>.

The installation is quite simple, using the following steps:

  1. git clone&nbsp; https://github.com/woutervb/hiera-central_property.git
  2. cd hiera-central*
  3. rake
  4. cd pkg
  5. gem install *.gem

After these steps the regular hiera call&#8217;s can be used in manifests to retrieve the data.

Have fun
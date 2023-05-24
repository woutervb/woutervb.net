---
id: 17
title: Central application to store key-value pairs
date: 2012-06-29T13:15:00+00:00
author: wouter
layout: post
permalink: /2012/06/29/central-application-to-store-key-value-pairs/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2012/06/central-application-to-store-key-value.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/1868665303592503646
categories:
  - Django
  - git
  - github
  - key-value
  - python
---
For a project I needed to have a central server that could hold key-value pairs.  
These key-value pairs are meant to be defined once in a hierarchie and have to potential to be overruled higher up in the hierarchie.

So if we take a simple tree, using reverse dns names we get something like this:

    1. nl
    2.  vanbommelonline
    3.   hostname 

At each of these levels I want to be able to define a parameter, which can be overwritten when the tree becomes more host specific.

E.g. a key-value pair called dnsservers defined at 1 is global, but redefining this at 3 means that this host can have a host specific setting.

Another requirement is that if a request is made for an host that does not exist no errors are produced, but the collection of defined key-value pairs up to the last defined element are returned.  
So calling all key-value pairs for a host with the name: `www.vanbommelonline.nl`, which is not defined in the example above, will return all key-value pairs defined at the level of `nl`, combined with those at `vanbommelonline`.

As key-value pair definitions are unique. It is possible to assign them at multiple locations in the tree.

This whole project is written in Django and can be found on github at:  
[https://github.com/woutervb/central_property.](https://github.com/woutervb/central_property)

I hope that this project is useful for more people.
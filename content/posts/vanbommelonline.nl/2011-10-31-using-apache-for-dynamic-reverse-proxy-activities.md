---
id: 23
title: Using apache for dynamic reverse proxy activities
date: 2011-10-31T15:09:00+00:00
author: wouter
layout: post
permalink: /2011/10/31/using-apache-for-dynamic-reverse-proxy-activities/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2011/10/using-apache-for-dynamic-reverse-proxy.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/7927161013767081508
categories:
  - apache
  - mass reverse proxy
  - mass virtual hosting
  - mod_proxy
  - mod_rewrite
---
Apache can be configured as a reverse proxy, using the mod\_proxy and mod\_proxy_http modules.

Using mod_rewrite it is possible to create a simple method to proxy http requests based on the hostname. This does assume that there is a logical (programmatically) relation between the hostname used on the proxy and the hostname of the system that is intended to be reached.

We can create a mapping like the one below:

    system1.pre-proxy => system1.realwebserver:8080
    system2.pre-proxy => system2.realwebserver:8080

In the above example we arrange dns in such a way that all requests pointing to the domain .pre-proxy land on our machine running apache (with the setup mentioned below) and that the domain realwebserver points to the real systems.

The config snipped required on apache to get this running is:

    <VirtualHost *:80>
      RewriteEngine On
      RewriteCond %{HTTP_HOST} ^(.*).pre-proxy
      RewriteRule ^/(.*) http://%1.realwebserver:8080/$1 [P
    </VirtualHost>
---
id: 28
title: Radius authentication on a Nexus 5k (5548) using ldap as radius backend
date: 2011-06-09T11:33:00+00:00
author: wouter
layout: post
guid: http://vanbommelonline.nl/?p=28
permalink: /2011/06/09/radius-authentication-on-a-nexus-5k-5548-using-ldap-as-radius-backend/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2011/06/radius-authentication-on-nexus-5k-5548.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/3579110684359521962
categories:
  - Uncategorized
---
Radius authentication on a Nexus 5k (5548) using ldap as radius backend

In the our current setup we are using radius with an ldap backup. Against this solution we found a way to configure the radius daemon in such a way that it is possible to gain admin rights. In this setup no changes to ldap where made.

The trick to get this up and running is the followin:

1. In freeradius edit the default site, so that authorize looks like:

<pre><br />   authorize { file ldap }<br /></pre>

2. edit the file users to contain the following lines:

<pre><br />DEFAULT<br />  Service-Type := Administrative-User,<br />  Cisco-AVPair += "shell:roles=network-admin"<br /></pre>

Restarting the radius daemon now makes it possible for everybody that can authenticate to login and have admin privileges.
---
id: 11
title: Samba as DC with LDAP authentication and one annoying error
date: 2013-07-29T07:45:00+00:00
author: wouter
layout: post
permalink: /2013/07/29/samba-as-dc-with-ldap-authentication-and-one-annoying-error/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2013/07/samba-as-dc-with-ldap-authentication.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/4794682725814723701
categories:
  - ldap
  - samba
  - ubuntu
---
Recently I changed a Samba installation from using the &#8216;classic&#8217; file based backend to a newer ldap based backend, in a production environment.

Following one of the many guides in the internet helped a lot, for this task I used most information from: https://help.ubuntu.com/community/LDAPClientAuthentication & http://raerek.blogspot.hu/2012/05/samba-pdc-on-ubuntu-1204-using-ldap_28.html

The biggest problem I faced was that one error showed up during domain login from a terminalserver which prevented roaming profiles to work. The error was:  
<span style="font-family: &quot;Courier New&quot;,Courier,monospace;">_netr_ServerAuthenticate2: netlogon_creds_server_check failed. Rejecting auth request from client WINDOWS7 machine account WINDOWS7$</span>

<pre>&nbsp;</pre>

I tested a lot of options and scenario&#8217;s to get rid of this error. Removed the computer account from the ldap a number of times, made sure that the computer account could be seen when the command <span style="font-family: &quot;Courier New&quot;,Courier,monospace;">getent passwd</span> was issued, but none helped.

At last I started checking the SID in the ldap I found that it did not match with the one that <span style="font-family: &quot;Courier New&quot;,Courier,monospace;">sudo net getlocalsid</span> gave me.  
Syncing al the SID entries manually and making sure that smbldaptools where correctly configured solved this problem for me.
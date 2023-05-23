---
id: 26
title: 'Puppet &#038; ubuntu &#038; svn &#8211; part 2'
date: 2011-08-11T14:59:00+00:00
author: wouter
layout: post
permalink: /2011/08/11/puppet-ubuntu-svn-part-2/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2011/08/puppet-ubuntu-svn-part-2.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/3720173423828766713
categories:
  - configuration management
  - puppet
  - ubuntu
---
This is the second article of a triology. The first article can be found here: <http://vanbommelonline.nl/?p=29>.

In the first article the installation of puppet on ubuntu was discussed. In this article we talk about making a trust between a puppet client and a puppet server.  
This is the crucial step that is needed in order te let an client obtain the puppet recipies for processing.

The first step is installing the puppet client on a (new) server. The steps involved are:

<pre>sudo apt-get install puppet</pre>

Now we need to make an connection between the client and the server. On the client we do this by issuing the following command (assuming that the server is reachable by the name puppet).:

<pre>sudo puppetd --verbose</pre>

This command will end with the message that no valid certificate is recieved. But this command does give the puppet master (the server) sufficient information to continue the trust process.

At the puppet master server the following command can be issued to determine the names of the client dat attempted to make an connection.

<pre>sudo puppetca --list</pre>

To make a trust between the master and one of the above mentioned clients issue the following command on the server.

<pre>sudo puppetca --sign &lt;clientname as listed by puppetca --list&gt;</pre>

On the client the command 

<pre>sudo puppetd --verbose</pre>

will now continue as expected without the message that no valid certificate could be found. But any errors in recipes will still result in failure messages.
---
id: 25
title: Enable data=writeback for root filesystem (linux)
date: 2011-09-12T14:30:00+00:00
author: wouter
layout: post
permalink: /2011/09/12/enable-datawriteback-for-root-filesystem-linux/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2011/09/enable-datawriteback-for-root.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/4797588143154419905
categories:
  - ext3
  - ext4
  - linux
  - ubuntu
---
Some people already found out the hard way that simply changing the /etc/fstab to make the root filesystem use the journal writeback modus will break the system.

The trick to enable this feature is relative simple and involves 1 aditional step to editing the /etc/fstab

Lets use the below /etc/fstab snippet to illustrate the steps involved

<pre>/dev/sda5 / defaults 0 0</pre>

We change this /etc/fstab snippet to:

<pre>/dev/sda5 / data=writeback 0 0</pre>

And we execute the following command:

<pre>tune2fs -O journal_data_writeback /dev/sda5</pre>
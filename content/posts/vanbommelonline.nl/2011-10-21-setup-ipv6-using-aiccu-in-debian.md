---
id: 24
title: Setup ipv6 using aiccu in debian
date: 2011-10-21T13:06:00+00:00
author: wouter
layout: post
permalink: /2011/10/21/setup-ipv6-using-aiccu-in-debian/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2011/10/setup-ipv6-using-aiccu-in-debian.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/6142942325054475531
categories:
  - debian
  - ipv6
  - ubuntu
---
With Debian it is relative easy to setup ipv6 using aiccu.

This can be done using the following steps (assuming you already have an account at [www.sixxs.net](http://www.sixxs.net/)):  
1. install aiccu

    ```
    sudo apt-get install aiccu
    ```

2. edit de `/etc/network/interfaces` add the following entries:

    ```
    auto sixxs
    iface sixxs inet6 manual
    up ip link set mtu 1480 dev $IFACE
    pre-up invoke-rc.d aiccu start
    post-down invoke-rc.d aiccu stop
    ```

3. disable the automatic start of aiccu
  
    ```
    sudo update-rc.d aiccu disable
    ```

4. bring the interface up using the command

    ```
    sudo ifup sixxs
    ```

---
id: 31
title: Getting ipv6 using linksys e2000, dd-wrt, sixxs and a regular ipv4 internet connection
date: 2011-02-25T09:10:00+00:00
author: wouter
layout: post
guid: http://vanbommelonline.nl/?p=31
permalink: /2011/02/25/getting-ipv6-using-linksys-e2000-dd-wrt-sixxs-and-a-regular-ipv4-internet-connection/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter
blogger_permalink:
  - /2011/02/getting-ipv6-using-linksys-e2000-dd-wrt.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/7449305034754971364
categories:
  - e2000
  - ip6tables
  - ipv6
  - Linksys
  - radvd
  - sixxs
---
<div style="margin-bottom: 0in;">
  Currently most providers do not yet support ipv6, the major new internet protocol. But there are way&#8217;s to get an static ipv6 prefix independent of the ipv4 internet connection. The steps involved to get this enabled are the following. Obviously the limited amount of risk of breaking your internet connection using this guide are for the reader.
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  <b>Step 1. Install dd-wrt on a linksys e2000</b>
</div>

<div style="margin-bottom: 0in;">
  While the linksys e2000 is not yet officially supported there is a version available that does work. Detailed instructions can be found at: <a href="http://www.dd-wrt.com/wiki/index.php/Linksys_E2000">http://www.dd-wrt.com/wiki/index.php/Linksys_E2000</a>. With the term trailed build a build ending on e2000 is meant!
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  <b>Step 2. Configure jffs</b>
</div>

<div style="margin-bottom: 0in;">
  As the installed package does not contain all the software we need, jffs should be enabled. This can be done using the admin section in the webinterface. Simply select the proper radio button to enable, save and apply settings. A reboot will follow, which can take a considerate amount of time. Be patient as the jffs filesystem is initialized.
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  <b>Step 3. Install additional software / modules</b>
</div>

<div style="margin-bottom: 0in;">
  To enable proper ipv6 firewalling additional kernel modules are needed. In my case (using firmware DD-WRT v24-sp2 (08/12/10) std-usb-ftp &#8211; build 14929) I Could use the kernel packages mentioned in post: <a href="http://www.dd-wrt.com/phpBB2/viewtopic.php?p=485980#486262">http://www.dd-wrt.com/phpBB2/viewtopic.php?p=485980#486262</a> . Downloading the kernel modules to my regular computer and upload them using scp(!) to the linksys. Please be carefull to use scp, as sftp is not supported.
</div>

<div style="margin-bottom: 0in;">
  It is also needed to install the ipv6 firewall management package. This can be done by logging in on the router and issue the command:&nbsp;
</div>

> ipkg update && ipkg -force-depends install http://downloads.openwrt.org/kamikaze/7.09/brcm47xx-2.6/packages/ip6tables\_1.3.7-1\_mipsel.ipk .

<div style="margin-bottom: 0in;">
  Other versions of ip6tables don&#8217;t seem to work as expected.
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  <b>Step 4. Get an ipv6 tunnel with an tunnel broker.</b>
</div>

<div style="margin-bottom: 0in;">
  In order to make an ipv6 connection without provider support a so called tunnel is used. This ipv6 tunnel needs an endpoint with an ipv6 provider. This guide assumes that the tunnel is requested bij sixxs (<a href="http://www.sixxs.net/">http://www.sixxs.net/</a>). Follow the website www..sixxs.net and signup there for an tunnel. Make sure that you select an ayiya type tunnel, as it wil work in almost any situation (and this guide uses this setting as wel).
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  <b>Step 5. Configure the linksys router, part 1.</b>
</div>

<div style="margin-bottom: 0in;">
  Now the fun part starts, bringing it all together en get an working ipv6 setup.
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  Create a file in /tmp/ with the name crontab and the following content:
</div>

> \* \* \* \* * root /usr/sbin/ntpclient -s -h nl.pool.ntp.org

<div style="margin-bottom: 0in;">
  obviously replace the nl prefix in the name with a prefix that is more suitable for your setup. This is needed to ensure that the linksys routers stays on time.
</div>

<div style="margin-bottom: 0in;">
  (Due to unkown reasons I also have a copy of this file located in the directory /jffs/etc)
</div>

<div style="margin-bottom: 0in;">
  Next create a file in /tmp/ with the name .rc_startup (watch the starting dot!) and the following content
</div>

<div style="margin-bottom: 0in;">
</div>

> insmod /jffs/lib/modules/2.6.24.111/ip6_tables.ko  
> insmod /jffs/lib/modules/2.6.24.111/ip6table_filter.ko  
> insmod /jffs/lib/modules/2.6.24.111/ip6t_multiport.ko  
> insmod /jffs/lib/modules/2.6.24.111/nf\_conntrack\_ipv6.ko  
> insmod /jffs/lib/modules/2.6.24.111/ip6t_rt.ko
> 
> \# AICCU doesn&#8217;t set up the tunnel properly but it will maintain the heartbeat for you  
> /usr/sbin/ntpclient -s -h nl.pool.ntp.org  
> /jffs/usr/sbin/aiccu start /jffs/etc/aiccu.conf  
> \# Start IPv6 forwarding on the router. Enable the 3 lines below once you have a subnet  
> #ip -6 addr add 2001:xxxx:1/64 dev br0 # replace xxxx with your subnet prefix!  
> #/bin/echo 1 > /proc/sys/net/ipv6/conf/all/forwarding  
> #radvd -C /tmp/radvd.conf  
> #set path variables  
> export IP6TABLES\_LIB\_DIR=/jffs/usr/lib/iptables  
> PATH=&#8221;$PATH&#8221;:/jffs/usr/sbin  
> \# Default rule DROP for all chains  
> ip6tables -P INPUT DROP  
> ip6tables -P OUTPUT DROP  
> ip6tables -P FORWARD DROP  
> \# Prevent being a rh0 (routing header type 0) host (DROP before we could accept these buggy ones)  
> ip6tables -I INPUT -m rt &#8211;rt-type 0 -j DROP  
> ip6tables -I OUTPUT -m rt &#8211;rt-type 0 -j DROP  
> ip6tables -I FORWARD -m rt &#8211;rt-type 0 -j DROP  
> \# Allow traffic on loopback interface  
> ip6tables -A INPUT -i lo -j ACCEPT  
> ip6tables -A OUTPUT -o lo -j ACCEPT  
> \# Allow traffic from local host to the IPv6-tunnel  
> ip6tables -A OUTPUT -o sixxs -s 2001::/16 -j ACCEPT  
> ip6tables -A INPUT -i sixxs -d 2001::/16 -m state &#8211;state RELATED,ESTABLISHED -j ACCEPT  
> \# Allow traffic from local network to local host  
> ip6tables -A OUTPUT -o br0 -j ACCEPT  
> ip6tables -A INPUT -i br0 -j ACCEPT  
> \# Allow traffic from local network to tunnel (IPv6 world)  
> ip6tables -A FORWARD -i br0 -s 2001::/16 -j ACCEPT  
> ip6tables -A FORWARD -i sixxs -d 2001::/16 -m state &#8211;state RELATED,ESTABLISHED -j ACCEPT  
> \# Allow some special ICMPv6 packettypes, do this in an extra chain because we need it everywhere  
> ip6tables -N AllowICMPs  
> \# Destination unreachable  
> ip6tables -A AllowICMPs -p icmpv6 &#8211;icmpv6-type 1 -j ACCEPT  
> \# Packet too big  
> ip6tables -A AllowICMPs -p icmpv6 &#8211;icmpv6-type 2 -j ACCEPT  
> \# Time exceeded  
> ip6tables -A AllowICMPs -p icmpv6 &#8211;icmpv6-type 3 -j ACCEPT  
> \# Parameter problem  
> ip6tables -A AllowICMPs -p icmpv6 &#8211;icmpv6-type 4 -j ACCEPT  
> \# Echo Request (protect against flood)  
> ip6tables -A AllowICMPs -p icmpv6 &#8211;icmpv6-type 128 -m limit &#8211;limit 5/sec &#8211;limit-burst 10 -j ACCEPT  
> \# Echo Reply  
> ip6tables -A AllowICMPs -p icmpv6 &#8211;icmpv6-type 129 -j ACCEPT  
> \# Link in tables INPUT and FORWARD (in Output we allow everything anyway)  
> ip6tables -A INPUT -p icmpv6 -j AllowICMPs  
> ip6tables -A FORWARD -p icmpv6 -j AllowICMPs

<div style="margin-bottom: 0in;">
  This file, including the firewall configuration is generic enough to work with ipv6 connections that have a prefix starting with 2001. If your prefix is different, make adjustments at the location where 2001::/16 is mentioned.
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  We also need to configurate the aiccu client. This is done by creating a file in /jffs/etc/aiccu.conf with the following content (Obviously enter your details from the&nbsp;<a href="http://www.sixxs.net/">http://www.sixxs.net/</a>&nbsp;website)
</div>

> \# AICCU Configuration  
> \# Login information  
> username <your as="" login="" sixxs.net="" username="">  
> password <your as="" login="" password="" sixxs.net="">  
> \# Protocol and server listed on your tunnel  
> protocol ayiya  
> server tic.sixxs.net  
> \# Interface names to use  
> ipv6_interface sixxs  
> \# The tunnel_id to use  
> tunnel_id <enter tunnel="" your="">  
> \# Be verbose?  
> verbose true  
> \# Daemonize?  
> daemonize true  
> \# Require TLS?  
> requiretls true  
> \# Set default route?  
> defaultroute true</enter></your></your>

<div style="margin-bottom: 0in;">
  As the last action, go to the webinterface of the router, and select the admin tab. Here enable ipv6 support, but keep radvd disabled.
</div>

<div style="margin-bottom: 0in;">
  Save configuration and reboot the router.
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  Login after some time (5 minutes) on&nbsp;<a href="http://www.sixxs.net/">http://www.sixxs.net/</a>&nbsp;and check your tunnel latency. If some is registerd you do have completed the first part of getting ipv6 on your local netwerk.
</div>

<div style="margin-bottom: 0in;">
  If there is no latency mentioned you&#8217;l have to start debugging.&nbsp;
</div>

<div style="margin-bottom: 0in;">
</div>

  * Try to run the startup script by hand and check the output.
  * Does ntpclient work (time should be less than 120 seconds off).
  * Is aiccu running?



<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  <b>Step 5. Configure the linksys router, part 2.</b>
</div>

<div style="margin-bottom: 0in;">
  After 2 weeks of running the tunnel sucessfully you should be able to get an subnet. This is importand as that will funally make it possible for every computer in your lan to use ipv6.
</div>

<div style="margin-bottom: 0in;">
  Go to the website&nbsp;<a href="http://www.sixxs.net/">http://www.sixxs.net/</a>&nbsp;and request a tunnel. Once approved login the webinterace of the router and visit the admin page.
</div>

<div style="margin-bottom: 0in;">
  Het enable radvd and past a confiruation like the one below (but with your subnet details at the location of the xxxx&#8217;s)
</div>

> interface br0 {  
> AdvSendAdvert on;  
> AdvHomeAgentFlag on;  
> AdvLinkMTU 1480;  
> MinRtrAdvInterval 3;  
> MaxRtrAdvInterval 10;  
> prefix 2001:xxxx:xxxx::/64 {  
> AdvOnLink on;  
> AdvAutonomous on;  
> AdvRouterAddr on;  
> };  
> };

<div style="margin-bottom: 0in;">
  Save the configuration, but do not apply the changes.
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  In the file /tmp/.rc_startup now enable the lines where radvd is mentioned and enter your prefix at the location of the xxxx&#8217;s. This is needed to have an ip adress on the lan side.
</div>

<div style="margin-bottom: 0in;">
  Now reboot the router.
</div>

<div style="margin-bottom: 0in;">
</div>

<div style="margin-bottom: 0in;">
  After the reboot ipv6 should be available for all lan devices. A simple check is to try to access&nbsp;<a href="http://www.sixxs.net/">http://www.sixxs.net/</a>&nbsp;website. It should mention in the top right corner that you are making an ipv6 connection.
</div>

<div style="margin-bottom: 0in;">
  Another option is to visit&nbsp;<a href="http://www.kame.net/">http://www.kame.net/</a>&nbsp;which should show a moving turtle in high-res.
</div>

<div style="margin-bottom: 0in;">
</div>
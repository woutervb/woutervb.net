---
id: 9
title: Adding cacert.org root certificates to javakeystore (on non windows systems)
date: 2014-01-16T15:14:00+00:00
author: wouter
layout: post
permalink: /2014/01/16/adding-cacert-org-root-certificates-to-javakeystore-on-non-windows-systems/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2014/01/adding-cacertorg-root-certificates-to.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/6699156063180260207
categories:
  - cacert.org java
---
As an active user of cacert.org certificates I found that it can be quite cumbersome to have to repeat the adding of these certificates to the list of default trusted certificates in Java.

Especially since this procedure has to be repeated every java update. To easy this burden I wrote a small script which I want to share with everyone.

The script assumes that java is installed (somewhere) in the /usr directory and that the keytool command is in the active path. Please run this command as root, so that there will be no permission problems.

<pre><br />#!/bin/sh -e<br /><br />check_result () {<br />  if [ $1 -ne 0 ] ; then<br />    echo "Command ended with failure, stopping"<br />    delete_tmp<br />    exit 1<br />  fi<br />}<br /><br />delete_tmp () {<br />  rm -r ${tmp_dir}<br />}<br /><br />update_keystore () {<br />  keystore=$1<br /><br />  # get listing of all keys<br />  keys=`keytool -list -keystore ${keystore} -storepass changeit | grep cacertclass`<br />  if [ "${keys}"x = ""x ] ; then<br />    echo "Could not find any cacert keys, updating keystore"<br />    keytool -keystore ${keystore} -storepass changeit -import -trustcacerts -v -alias cacertclass1 -file ${tmp_dir}/root.crt<br />    keytool -keystore ${keystore} -storepass changeit -import -trustcacerts -v -alias cacertclass3 -file ${tmp_dir}/class3.crt<br />  fi<br />}<br /><br />echo "This script will search the system for cacerts file"<br />echo "And if they are valid java keystores, it will check"<br />echo "and if needed update the keystore so that it will"<br />echo "contain the cacert root & class3 CA certificates"<br />echo ""<br /><br /># create a temp directory to store the downloaded certificates<br />tmp_dir=`mktemp -d`<br /><br />echo ""<br />echo "Downloading certificates from cacert"<br />wget -q -O ${tmp_dir}/root.crt http://www.cacert.org/certs/root.crt<br />check_result $? <br /><br />wget -q -O ${tmp_dir}/class3.crt http://www.cacert.org/certs/class3.crt<br />check_result $? <br /><br />echo ""<br />echo ""<br />echo "Searching the system (/usr) for cacerts file(s)"<br />keystores=`find /usr -name cacerts -type f -print`<br />check_result $? <br /><br />echo ""<br />echo ""<br /><br />for keystore in ${keystores} ; do<br />    update_keystore ${keystore}<br />done<br /><br />delete_tmp<br /></pre>
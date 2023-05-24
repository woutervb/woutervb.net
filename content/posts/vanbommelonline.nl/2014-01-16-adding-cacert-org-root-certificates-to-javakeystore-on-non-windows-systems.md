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

    #!/bin/sh -e
    
    check_result () {
      if [ $1 -ne 0 ] ; then
        echo "Command ended with failure, stopping"
        delete_tmp
        exit 1
      fi
    }
    
    delete_tmp () {
      rm -r ${tmp_dir}
    }
    
    update_keystore () {
      keystore=$1
      
      # get listing of all keys
      keys=`keytool -list -keystore ${keystore} -storepass changeit | grep cacertclass`
      if [ "${keys}"x = ""x ] ; then
        echo "Could not find any cacert keys, updating keystore"
        keytool -keystore ${keystore} -storepass changeit -import -trustcacerts -v -alias cacertclass1 -file ${tmp_dir}/root.crt
        keytool -keystore ${keystore} -storepass changeit -import -trustcacerts -v -alias cacertclass3 -file ${tmp_dir}/class3.crt
      fi
    }
    
    echo "This script will search the system for cacerts file"
    echo "And if they are valid java keystores, it will check"
    echo "and if needed update the keystore so that it will"
    echo "contain the cacert root & class3 CA certificates"
    echo ""
    
    # create a temp directory to store the downloaded certificates
    tmp_dir=`mktemp -d`

    echo ""
    echo "Downloading certificates from cacert"
    
    wget -q -O ${tmp_dir}/root.crt http://www.cacert.org/certs/root.crt
    check_result $?
    
    wget -q -O ${tmp_dir}/class3.crt http://www.cacert.org/certs/class3.crt
    check_result $?
    
    echo ""
    echo ""
    echo "Searching the system (/usr) for cacerts file(s)"
    keystores=`find /usr -name cacerts -type f -print`
    check_result $?
    
    echo ""
    echo ""
    
    for keystore in ${keystores} ; do
      update_keystore ${keystore}
    done
    
    delete_tmp
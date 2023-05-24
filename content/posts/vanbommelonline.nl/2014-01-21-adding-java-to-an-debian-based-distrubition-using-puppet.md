---
id: 8
title: Adding java to an debian based distrubition using puppet
date: 2014-01-21T21:55:00+00:00
author: wouter
layout: post
permalink: /2014/01/21/adding-java-to-an-debian-based-distrubition-using-puppet/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2014/01/adding-java-to-debian-based.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/1706013415164044192
categories:
  - debian
  - java
  - puppet
  - ubuntu
---
During some experiments I wanted to check if it is possible to install java, using puppet.

This turned out to be quite simple. All that was needed where 2 simple scripts.

The first shell script simply installs the puppet and a depended puppet module.

    #!/bin/sh
    
    sudo apt-get install puppet
    sudo puppet module install puppetlabs/apt
    sudo puppet apply java.puppet

The second file (called java.puppet) should be placed in the same directory and will update apt, accept the java license and install java7, and make it the default java version.


    include apt
    
    apt::source { 'java_webupd8team':
      location   => 'http://ppa.launchpad.net/webupd8team/java/ubuntu',
      repos      => 'main',
      key        => 'EEA14886',
      key_server => 'pgp.mit.edu',
    }
    
    exec {
       'set-licence-selected':
          command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections'
        }
        
    exec {
      'set-licence-seen':
          command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections'
    }
    
    package { "oracle-java7-set-default":
      ensure => "installed",
      require => [
        APT::SOURCE[ 'java_webupd8team' ],
        Exec[ 'set-licence-selected' ],
        Exec[ 'set-licence-seen' ],
      ]
    }
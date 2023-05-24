---
id: 29
title: 'Puppet & ubuntu & svn - part 1'
date: 2011-05-04T13:29:00+00:00
author: wouter
layout: post
guid: http://vanbommelonline.nl/?p=29
permalink: /2011/05/04/puppet-ubuntu-svn-part-1/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter
blogger_permalink:
  - /2011/05/puppet-ubuntu-svn-part-1.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/6499839267577848919
categories:
  - configuration management
  - puppet
  - ubuntu
---
This blog entry is meant as a quick lookup on how to setup an initial puppet environment on linux.

The goal is to have puppet installed in a client master relationship, in which the master configuration files are stored in svn. The client is, except for the initial certificate trust, completely automated. In this part the focus is on the central server setup. As a base os for the central master ubuntu (11.04) is used.

Initial step is to install a machine with Ubuntu 11.04 in a regular way. If this is a new step, please use one of the available manuals found on the internet.

Installation of the required software can be done using the following apt command:  

    sudo apt-get install puppetmaster-passenger subversion  

Once the packages and the dependencies are installed a local svn repository can be created with the command, we make a world accessible directory for the purpose of this manual, in realworld scenario's a better subversion setup should be used:

    sudo mkdir /subversion
    sudo chmod 777 /subversion
    svnadmin create /subversion

Now we have this repository we van import the default puppet configuration as a starting point.

    cd /etc
    sudo svn import puppet file://localhost/subversion

Make a copy of the current directory

    cd /etc
    sudo mv puppet puppet.old

And checkout the 'latest' version from svn

    cd /etc
    sudo svn checkout file://localhost/subversion/puppet

Now create a crontab entry like the one below to do an update of the tree every minute

    * * * * * root cd /etc && svn checkout file://localhost/subversion/puppet > /dev/null 2>&1

As a regular user you can now checkout the same project at a convenient location e.g. your home directory.

    cd ~
    svn checkout file://localhost/subversion/puppet

The first thing(s) that have to be done is add some directories and change some configuration parameters in order for the installation to work. The steps involved are:


    cd ~/puppet
    for dir in files plugins templates ; do mkdir ${dir} ; done
    svn add *
    vi fileserver.conf

edit add a section called `[modules]`
Now we are ready commit our first version to the revision control

    cd ~/puppet
    svn commit -m "Putting directory structure in place"

To add the first recipe proceed with the following steps:

    cd ~/puppet/manifests
    
`vi site.pp`
    
    import "nodes"
    
    File { backup => main }
    filebucket { main: server => "puppet"; } # replace puppet with fqdn of the puppet server
    
    
`vi nodes.pp`

    node 'default' {
      include test
    }

Add the files to svn

    cd ~/puppet/manifests
    svn add *

Create the first recipe called test

    cd ~/puppet/modules
    mkdir -p test/manifests
    
`vi test/manifests/init.pp`

    class test {
      warn { 'do something useful' }
    }

`svn add test`

And commit them all to the repository

    cd ~/puppet
    svn commit -m "first recipe for default nodes"

Within one minute the crontab will do a checkout of these changes and once a remote puppet client connects it will process the changed data.
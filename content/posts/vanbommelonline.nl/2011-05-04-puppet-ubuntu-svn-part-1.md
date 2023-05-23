---
id: 29
title: 'Puppet &#038; ubuntu &#038; svn &#8211; part 1'
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
This blog entry is meant as a quick lookup on how to setup an intial puppet environment on linux.  
The goal is to have puppet installed in a client master relationship, in which the master configuration files are stored in svn. The client is, except for the initial certificate trust, completely automated. In this part the focus is on the central server setup. As a base os for the central master ubuntu (11.04) is used.  
Initial step is to install a machine with Ubuntu 11.04 in a regular way. If this is a new step, please use one of the available manuals found on the internet.  
Installation of the required software can be done using the following apt command:  
sudo apt-get install puppetmaster-passenger subversion  
Once the packages and the dependencies are installed a local svn repository can be created with the command, we make a world accessible directory for the purpose of this manual, in realworld scenario&#8217;s a better subversion setup should be used:

<pre><br />sudo mkdir /subversion<br />sudo chmod 777 /subversion<br />svnadmin create /subversion</pre>

Now we have this repository we van import the default puppet configuration as a starting point.

<pre><br />cd /etc<br />sudo svn import puppet file://localhost/subversion</pre>

Make a copy of the current directory

<pre><br />cd /etc<br />sudo mv puppet puppet.old</pre>

And checkout the &#8216;latest&#8217; version from svn

<pre><br />cd /etc<br />sudo svn checkout file://localhost/subversion/puppet</pre>

Now create a crontab entry like the one below to do an update of the tree every minute

<pre><br />* * * * * root cd /etc && svn checkout file://localhost/subversion/puppet &gt; /dev/null 2&gt;&1</pre>

As a regular user you can now checkout the same project at a convenient location e.g. your home directory.

<pre><br />cd ~<br />svn checkout file://localhost/subversion/puppet</pre>

The first thing(s) that have to be done is add some directories and change some configuration parameters in order for the installation to work. The steps involved are:

<pre><br />cd ~/puppet<br />for dir in files plugins templates ; do mkdir ${dir} ; done<br />svn add *<br />vi fileserver.conf</pre>

edit add a section called [modules]  
Now we are ready commit our first version to the revision control

<pre><br />cd ~/puppet<br />svn commit -m "Putting directory structure in place"</pre>

To add the first recipe proceed with the following steps:

<pre><br />cd ~/puppet/manifests<br />vi site.pp<br />import "nodes"<br /><br />File { backup =&gt; main }<br />filebucket { main: server =&gt; "puppet"; } # replace puppet with fqdn of the puppet server<br /><br />vi nodes.pp<br />node 'default' {<br />   include test<br />}</pre>

Add the files to svn

<pre><br />cd ~/puppet/manifests<br />svn add *</pre>

Create the first recipe called test

<pre><br />cd ~/puppet/modules<br />mkdir -p test/manifests<br />vi test/manifests/init.pp<br />class test {<br />   warn { 'do something usefull' }<br />}<br />svn add test</pre>

And commit them all to the repository

<pre><br />cd ~/puppet<br />svn commit -m "first recipe for default nodes"</pre>

Within one minute the crontab will do a checkout of these changes and once a remote puppet client connects it will process the changed data.
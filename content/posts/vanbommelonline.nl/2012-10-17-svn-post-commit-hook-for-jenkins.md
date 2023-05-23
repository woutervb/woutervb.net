---
id: 13
title: SVN post-commit hook for jenkins
date: 2012-10-17T18:02:00+00:00
author: wouter
layout: post
permalink: /2012/10/17/svn-post-commit-hook-for-jenkins/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2012/10/svn-post-commit-hook-for-jenkins.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/6952820676281226457
categories:
  - ci
  - hook
  - jenkins
  - jenkins-ci
  - post-commit
  - subversion
  - svn
---
Assume that you have a svn repository with branches, tags and trunk and you only want to run your jenkins-ci runs on the trunk repository.

In that case you want te be sure that commits to branches / tags do not trigger a testrun, so the commit hook needs to take care of that.

Below is an (yet untested) version of an commit hook that should take care of that. It will only trigger jenkins in the case of commits to a trunk subdirectory of a svn repo. 

<pre brush:bash><br />#!/bin/bash<br /><br />REPOS="$1"<br />REV="$2"<br />UUID=`svnlook uuid $REPOS`<br />SERVER='http://localhost'<br />JENKINS_USER='jenkins'<br />JENKINS_PASSWORD='wachtwoord'<br /><br />svnlook dirs-changed -r $REV $REPOS | grep trunk | while read line<br />do<br />    /usr/bin/wget <br />        --auth-no-challenge <br />        --no-check-certificate <br />        --http-user=${JENKINS_USER} <br />        --http-password=${JENKINS_PASSWORD} <br />        --header "Content-Type:text/plain;charset=UTF-8" <br />        --post-data "`svnlook changed -r $REV $REPOS`" <br />        --output-document "-" <br />        --timeout=2 <br />        ${SERVER}/subversion/${UUID}/notifyCommit?rev=$REV<br />    [ $? -ne 0 ] && exit 1<br />done<br /></pre>

This script does make use of authentication. To remove this, omit the &#8211;http- lines of the wget command.
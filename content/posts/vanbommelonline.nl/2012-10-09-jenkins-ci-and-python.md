---
id: 14
title: Jenkins-ci and python
date: 2012-10-09T19:03:00+00:00
author: wouter
layout: post
permalink: /2012/10/09/jenkins-ci-and-python/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2012/10/jenkins-ci-and-python.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/9022767010130132653
categories:
  - ci
  - jenkins
  - jenkins-ci
  - nosetests
  - pip
  - python
  - virtualenv
---
On the internet it is easy to find several references on how to use [Jenkins-ci](http://jenkins-ci.org/) in combination with python.  
But most of the blogs that you can find depend on an &#8216;older&#8217; module called SetEnv. This module does not exists anymore.

But the bright side of this all is, that there is a new module that can be used with the name [ShiningPanda Plugin](http://wiki.jenkins-ci.org/display/JENKINS/ShiningPanda+Plugin)  
This plugin does allow you to make a virtualenv environment to install the dependent modules is e.g. using pip. The setup of this module is done by choosing &#8216;Virtualenv Builder&#8217; as the buildstep of the project.  
Any code written in the &#8216;dialog box&#8217; below with the name: **Command** will be executed in the virtualenv environment. The commando&#8217;s that I issue are: 

<pre><br /> pip install -r pip-requires.txt<br /> nosetests --with-xunit<br /></pre>

This does also mean that I include a file pip-requirements.txt in the version control software which lists all the modules that are needed for this project to work.  
I hope that this information is helpfull for those that want to use the power of jenkins for python development.  
Using nosetests with the &#8211;with-xunit means that a junit compatible xml file will be generated. This file can be parsed by jenkins when using _**/nosetests.xml_ as the junit input file in the Post-Build action step.
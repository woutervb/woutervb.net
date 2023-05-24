---
id: 33
title: Assigning values to dynamic determined (global) variable names in python
date: 2009-08-21T15:41:00+00:00
author: wouter
layout: post
guid: http://vanbommelonline.nl/?p=33
permalink: /2009/08/21/assigning-values-to-dynamic-determined-global-variable-names-in-python/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter
blogger_permalink:
  - /2009/08/assigning-values-to-dynamic-determined.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/4359942840072083008
categories:
  - python
showtoc: false
---
# Introduction

Once in a while one wishes to make a variable globally in python. This normally is done using the *global* keyword. But what if the name of the variable is not known beforehand, or one wants to make all the keys of a dictionary into a global variable?

# Problem  

The problem is that the global keyword can only be used for variables known at development time. But as suggested above there can be situation in which it is makes life a lot simpler if e.g. all entries of a dictionary can be made available as a global variable. The case in which I have used this solution is with parsing global settings.  

In my application global settings are read using the ConfigParser object. Using this approach I end up with a list containing key, value pairs (sub)lists.  

These key, value pairs are first converted into a dictionary (makes it easy to update a dictionary that contains the defaults for each of the values) and than I make them globally available. This is done to prevent parsing the dictionary around in all other functions that (might) require them.  
Obviously it is important that the making the values globally available is done before accessing them, but that is up to the developer (and Exceptions if done wrong).

# Solution

Below a snipped of code can be found that converts the keys of the dictionary into a globally available variable, containing the value of the key value pair.


    def makeConfigGlobal(config):
      '''This function will make the settings read from the config file
      available in global variables.
      Variable name used will be based on the key name.
      '''

      for keys in config.iterkeys():
      globals()[keys] = config[keys]
      log(LVL_DEBUG, 'Made variable `%s` globally available' % keys)
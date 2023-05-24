---
id: 35
title: Migrating mail to Google Apps
date: 2009-08-17T17:08:00+00:00
author: wouter
layout: post
guid: http://vanbommelonline.nl/?p=35
permalink: /2009/08/17/migrating-mail-to-google-apps/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter
blogger_permalink:
  - /2009/08/migrating-mail-to-google-apps.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/6510173267232465622
categories:
  - gmail
  - google
  - google apps
  - security
  - ssl
---
It might seem something trivial. Migrating all your personal mail to google apps.  
Well eventually it all is trivial, the quick steps are:

  1. Subscribe to Google Apps
  2. Setup your domain
  3. change MX records
  4. Add a cname
  5. per user enable imap
  6. upload the mail archive(s) using imap

In more details follow the steps below.

First step is to subscribe to the google apps personal service. The following link should be of some help: http://www.google.com/apps/intl/en/group/index.html

The rest of the steps are excellently written on http://www.hanselman.com/blog/MigratingAFamilyToGoogleAppsFromGmailThunderbirdOutlookAndOthersTheDefinitiveGuide.aspx and so it is nonsense to rewrite the whole text.

One important advice is to disable imap access if not needed, and to ALWAYS ENABLE SSL. This is done via the Dashboard -> 'Domain Settings' -> Checkbox enable SSL and 'Save Changes'
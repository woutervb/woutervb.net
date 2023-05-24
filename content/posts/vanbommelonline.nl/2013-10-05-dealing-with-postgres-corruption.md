---
id: 10
title: Dealing with postgres corruption
date: 2013-10-05T19:40:00+00:00
author: wouter
layout: post
permalink: /2013/10/05/dealing-with-postgres-corruption/
blogger_blog:
  - www.vanbommelonline.nl
blogger_author:
  - Wouter van Bommel
blogger_permalink:
  - /2013/10/dealing-with-postgres-corruption.html
blogger_internal:
  - /feeds/4111162102602764339/posts/default/2860813406844506996
categories:
  - corruption
  - OID
  - postgres
---
It can happen that a postgres backup using `pg_dump` (or `pg_dumpall`) fails with a message like:

    pg_dump: schema with OID 849375 does not exist

This can once in a while when data is not flushed properly between the transaction logs and the filesystem.  
The only way to solve them (after making a file level backup, for the just in case situations) is to search and delete the offending OID from the database.

Connect to the database using `psql c <database name>`.  
Search in the following tables (this list might not be complete)

    select * from pg_type where typnamespace = 849375;
    select * from pg_proc where pronamespace = 849375;
    select * from pg_class where relnamespace = 849375;

If there are results, then run deletes below for the matching tables

    delete from pg_type where typnamespace = 849375;
    delete from pg_proc where pronamespace = 849375;
    delete from pg_class where relnamespace = 849375;

Be sure that you run the deletes only on the right database with the right OID do not copy the lines from this blog entry without changing them.
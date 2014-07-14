---
layout: post
status: publish
published: true
title: ! 'Improving Zentyal performance: Redis'
author:
  display_name: exekias
  login: exekias
  email: exekias@gmail.com
  url: ''
author_login: exekias
author_email: exekias@gmail.com
wordpress_id: 290
wordpress_url: http://www.thebigbugtheory.com/?p=290
date: !binary |-
  MjAxMC0xMi0xMiAyMDowMToxMiArMDEwMA==
date_gmt: !binary |-
  MjAxMC0xMi0xMiAxOTowMToxMiArMDEwMA==
categories:
- free software
- ebox
- zentyal
tags: []
comments:
- id: 15
  author: Jorge Bernal
  author_email: jbernal@gmail.com
  author_url: http://koke.me/
  date: !binary |-
    MjAxMC0xMi0xNyAxMjozMjo0OSArMDEwMA==
  date_gmt: !binary |-
    MjAxMC0xMi0xNyAxMTozMjo0OSArMDEwMA==
  content: ! 'Redis is cool! I''ve used in the past with resque for background job
    queues.


    Farewell GConf, you probably won''t be missed :)'
---
<p>Now that we have some time after our <a href="http:&#47;&#47;trac.zentyal.org&#47;wiki&#47;Document&#47;Announcement&#47;2.0">2.0 release<&#47;a> I want to start a series of post about how to improve Zentyal performance (what we've done, what we will do, and what you can do). In this first post I'm going to talk about one of the new <a href="http:&#47;&#47;www.zentyal.org">Zentyal<&#47;a> features. <a href="http:&#47;&#47;code.google.com&#47;p&#47;redis&#47;">Redis<&#47;a> as config backend.<br />
<img src="&#47;wp-content&#47;uploads&#47;2010&#47;12&#47;82.png" alt="redis" title="redis" width="513" height="197" class="aligncenter size-full wp-image-295" &#47;><br />
<a href="http:&#47;&#47;code.google.com&#47;p&#47;redis&#47;">Redis<&#47;a> is a persistent key-value database written with performance in mind, it stores the whole database in memory and syncs to disk asynchronously.</p>
<h3>Previous backend: GConf<&#47;h3></p>
<p>Before <a href="http:&#47;&#47;code.google.com&#47;p&#47;redis&#47;">Redis<&#47;a>, <a href="http:&#47;&#47;www.zentyal.org">Zentyal<&#47;a> stored configuration in <a href="http:&#47;&#47;projects.gnome.org&#47;gconf&#47;">GConf<&#47;a>, the engine that <a href="http:&#47;&#47;www.gnome.org&#47;">Gnome Desktop<&#47;a> uses to store user preferences. Besides few minor problems, our main issue with <a href="http:&#47;&#47;projects.gnome.org&#47;gconf&#47;">GConf<&#47;a> was it is intended for desktop applications and does not provide much performance. We searched for alternatives that would be fast, lightweight and easy to use (protocol, api...) and finally chose <a href="http:&#47;&#47;code.google.com&#47;p&#47;redis&#47;">Redis<&#47;a> as it had all this and more!</p>
<h3>Integration with Zentyal<&#47;h3></p>
<p>Migrating from <a href="http:&#47;&#47;projects.gnome.org&#47;gconf&#47;">GConf<&#47;a> to <a href="http:&#47;&#47;code.google.com&#47;p&#47;redis&#47;">Redis<&#47;a> was not a trivial task, <a href="http:&#47;&#47;projects.gnome.org&#47;gconf&#47;">GConf<&#47;a> keys are organized into a hierarchy while <a href="http:&#47;&#47;code.google.com&#47;p&#47;redis&#47;">Redis<&#47;a> is a flat key-value store. <a href="http:&#47;&#47;gitorious.org&#47;~juruen">Javier Uruen<&#47;a> did most of the work as a <a href="http:&#47;&#47;trac.zentyal.org&#47;wiki&#47;Contribute">Zentyal contributor<&#47;a>, he rewrote our backend to be compatible with old code! For those interested in the internals you can see <a href="http:&#47;&#47;trac.zentyal.org&#47;browser&#47;trunk&#47;client&#47;ebox&#47;src&#47;EBox&#47;Config&#47;Redis.pm">Redis.pm<&#47;a>, for example:</p>
<pre><code>sub all_entries<br />
{<br />
    my ($self, $key) = @_;</p>
<p>    my $length = length $key;<br />
    my @dirs;<br />
    for my $path ($self->_redis_call('keys', "$key&#47;*")) {<br />
        push (@dirs, $path) if (index($path, '&#47;', $length + 1) == -1);<br />
    }<br />
    return @dirs;<br />
}<&#47;code><br />
<&#47;pre></p>
<h3>Future work<&#47;h3></p>
<p>There are some features that can take advantage of Redis and will use in some moment: make a better use of its <a href="http:&#47;&#47;code.google.com&#47;p&#47;redis&#47;wiki&#47;CommandReference">rich instruction set<&#47;a> or benefit from its replication features, <a href="http:&#47;&#47;planet.zentyal.org&#47;">stay tuned<&#47;a> for future updates!</p>
<p>If you also want to contribute you can do it! You can translate, test, help people using Zentyal... Visit <a href="http:&#47;&#47;trac.zentyal.org&#47;wiki&#47;Contribute">our contribute page<&#47;a> for more info!</p>

---
layout: post
status: publish
published: true
title: ! 'Zentyal new feature: Captive Portal'
author:
  display_name: exekias
  login: exekias
  email: exekias@gmail.com
  url: ''
author_login: exekias
author_email: exekias@gmail.com
wordpress_id: 546
wordpress_url: http://www.thebigbugtheory.com/?p=546
date: !binary |-
  MjAxMS0wOC0yOCAyMToyMTo0MyArMDIwMA==
date_gmt: !binary |-
  MjAxMS0wOC0yOCAyMDoyMTo0MyArMDIwMA==
categories:
- free software
- zentyal
tags: []
comments:
- id: 22
  author: Big Bro
  author_email: big_bro51@yahoo.com
  author_url: ''
  date: !binary |-
    MjAxMS0wOS0wOSAwNjo0MzozMiArMDIwMA==
  date_gmt: !binary |-
    MjAxMS0wOS0wOSAwNTo0MzozMiArMDIwMA==
  content: Just what i've been waiting for. you rock Zentyal!!
- id: 23
  author: Basheer Olakara
  author_email: basheer@olakara.com
  author_url: ''
  date: !binary |-
    MjAxMS0wOS0xMiAxNTo0MjozMiArMDIwMA==
  date_gmt: !binary |-
    MjAxMS0wOS0xMiAxNDo0MjozMiArMDIwMA==
  content: is there any option that we can select user expire date ?
- id: 24
  author: exekias
  author_email: exekias@gmail.com
  author_url: http://www.thebigbugtheory.com
  date: !binary |-
    MjAxMS0wOS0xMiAyMzoyNTo1MyArMDIwMA==
  date_gmt: !binary |-
    MjAxMS0wOS0xMiAyMjoyNTo1MyArMDIwMA==
  content: ! '@Basheer: No, that would be a nice feature but by the moment you can
    only configure the bandwidth limit.


    Anyway you can create a script to delete expired users each few minutes :)'
- id: 25
  author: Jesus
  author_email: jesus_24.12@hotmail.com
  author_url: http://www.interjet.com.ve
  date: !binary |-
    MjAxMS0wOS0xNSAxNjoxMjo1MiArMDIwMA==
  date_gmt: !binary |-
    MjAxMS0wOS0xNSAxNToxMjo1MiArMDIwMA==
  content: ! 'Hello good morning, I am from Venezuela i used  Zentyal from for two
    years in my company de telecommunications which provides wireless internet access
    and proved to be a robust tool for access control and stability in the internal
    network. Imnumerables are the characteristics that have this fabulous software.
    Although would me like to know  whether  have a configuration module to control
    bandwidth for each user and not how user groups existing  in previous versions?


    Thanks ...'
- id: 26
  author: kmnair
  author_email: kmnair@gmail.com
  author_url: ''
  date: !binary |-
    MjAxMS0wOS0xOSAwOTo1MDoxMCArMDIwMA==
  date_gmt: !binary |-
    MjAxMS0wOS0xOSAwODo1MDoxMCArMDIwMA==
  content: ! "Hello,\n\nI had looked at eBox last year, but kept it aside in favpur
    of PFSense &amp; Untangle since eBox did not have the CP feature. I will try again.
    Good job Zentyal. Now I can perhaps live with a single box.\n\nIs it possible
    to redirect the login page to another page, say, giving a login declaration with
    \"I agree\" tickbox or something?\n\nRegards\n \nkmnair"
---
<p><a href="http:&#47;&#47;www.zentyal.org&#47;beta&#47;" title="Zentyal 2.2 Release Candidate 2">Zentyal 2.2 RC2<&#47;a> was <a href="http:&#47;&#47;www.zentyal.org&#47;archives&#47;2011&#47;08&#47;25&#47;768-zentyal-2-2-rc2-available-for-download&#47;">released<&#47;a> on Thursday, so we are almost there, <strong>Zentyal 2.2 stable version will be ready in a few weeks<&#47;strong>. One of the new features that was not present in 2.0 is the new Captive Portal module. We raised enough money in our <a href="http:&#47;&#47;trac.zentyal.org&#47;wiki&#47;Document&#47;Development&#47;Fundraising" title="Zentyal Fundraising">fundraising initiative<&#47;a> so finally the module was included in 2.2 release :)</p>
<p>Official doc is still in the oven so I'm going to explain how to use the module, this will help you if you want to join <a href="http:&#47;&#47;forum.zentyal.org&#47;index.php&#47;board,10.0.html" title="Beta Testing Zentyal forum">testing efforts<&#47;a>.</p>
<h3>What is a Captive Portal?<&#47;h3><br />
A captive portal limits users access to the Internet redirecting any web request to a login page. When the user correctly authenticates he&#47;she is allowed to navigate and use any of the network services.</p>
<p>Captive portals are typically used at WiFi hotspots but also in wired networks at hotels, schools, airports...</p>
<h3>Basic configuration<&#47;h3></p>
<p>Zentyal Captive Portal is very easy to configure, you just need to select interfaces where you want to control access and the group of users who will be allowed to log in:</p>
<p><img src="&#47;wp-content&#47;uploads&#47;2011&#47;08&#47;main-bwmonitor.png" alt="" title="Configuration with bandwidth limitation" width="797" height="589" class="aligncenter size-full wp-image-569" &#47;></p>
<p>Also, if you installed <strong>Bandwidth Monitor<&#47;strong> module, you can setup a bandwidth usage quota. This will measure and control bandwidth usage for each connected user, forbidding access to those who exceed it.</p>
<h3>Accessing trough Captive Portal<&#47;h3></p>
<p>From the user point of view this is what will happen:</p>
<p>First time you connect through a captive interface your web browser will redirect to a login for any request:</p>
<p><img src="&#47;wp-content&#47;uploads&#47;2011&#47;08&#47;login.png" alt="" title="Login portal" width="489" height="293" class="aligncenter size-full wp-image-567" &#47;></p>
<p>Once you have logged in, a popup window will open. This window is in charge of keeping your session alive. It's used by Zentyal to know if you left just closing the web browser without logging out.</p>
<p><img src="&#47;wp-content&#47;uploads&#47;2011&#47;08&#47;popup.png" alt="" title="Captive Portal Popup WIndow" width="352" height="306" class="aligncenter size-full wp-image-570" &#47;></p>
<h3>Conclusions<&#47;h3></p>
<p>I think Captive Portal has been a very requested feature and I'm glad Zentyal finally has it! This was a good example on how the community helped us to make a decision about a new feature we should include and crowdsourcing made the funding possible.<br />
If you liked this tutorial, give the module a try and <a href="http:&#47;&#47;forum.zentyal.org&#47;index.php&#47;board,10.0.html" title="Beta Testing Zentyal forum">give us feedback<&#47;a>! Zentyal 2.2 is just around the corner!</p>

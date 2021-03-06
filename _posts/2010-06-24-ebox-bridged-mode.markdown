---
layout: post
status: publish
published: true
title: eBox bridged mode
author:
  display_name: exekias
  login: exekias
  email: exekias@gmail.com
  url: ''
author_login: exekias
author_email: exekias@gmail.com
wordpress_id: 105
wordpress_url: http://www.thebigbugtheory.com/?p=105
date: !binary |-
  MjAxMC0wNi0yNCAxMjo1OTowNCArMDIwMA==
date_gmt: !binary |-
  MjAxMC0wNi0yNCAxMTo1OTowNCArMDIwMA==
categories:
- free software
- ebox
tags: []
comments:
- id: 8
  author: yet another blog, try 3 / Improving service integration in eBox
  author_email: ''
  author_url: http://bq.cauterized.net/2010/06/27/improving-service-integration-in-ebox/
  date: !binary |-
    MjAxMC0wNi0yNyAyMToyNjoxNSArMDIwMA==
  date_gmt: !binary |-
    MjAxMC0wNi0yNyAyMDoyNjoxNSArMDIwMA==
  content: ! '[...] exekias published a few days a post on eBox new feature: bridged
    mode, I also wanted to share with you latests improvements I&#8217;ve been doing
    on service integration. [...]'
---
<p><a href="http://www.ebox-platform.com/"><img class="alignleft size-full wp-image-111" style="margin: 0 10px;" title="eBox Platform" src="/wp-content/uploads/2010/06/ebox.png" alt="eBox Logo" width="140" height="112" /></a></p>
<p>As many of you know, recently I started to work in <a href="http://www.ebox-technologies.com/">eBox Technologies</a>. In this post I will show my first development for <a href="http://www.ebox-platform.com/">eBox Platform</a>: Network bridged mode, now available in <a href="http://trac.ebox-platform.com/wiki/Document/Announcement/1.5">eBox 1.5</a>.</p>
<p>But, what does bridge mode mean?</p>
<h3 style="clear: left">Bridging</h3><br />
A bridge is a way to connect two network segments, but unlike routing, in a bridge packets are forwarded at Layer 2 (Ethernet), so all protocols can go transparently through it. This is very useful if you want to insert a firewall into an already working network without reconfiguring anything (clients IP addresses nor gateway).</p>
<p>A typical scenario for a bridge is filtering traffic from one network segment (internal LAN) to another (Internet), for example, firewall and content filtering on web access through a HTTP proxy.</p>
<h3>eBox as bridge</h3><br />
Let's see some screenshots on how to set up a bridge using eBox. First of all we have to configure network interfaces that will be bridged. When doing this on the first interface a new bridge will be automatically created (br1).</p>
<p><a href="/wp-content/uploads/2010/06/bridged1.png"><img src="/wp-content/uploads/2010/06/bridged1-300x165.png" alt="Bridged mode config screenshot 1" title="Bridged mode config screenshot 1" width="300" height="165" class="aligncenter size-medium wp-image-131" /></a></p>
<p>After that all you need is to add the other interfaces to the bridge. Don't forget to mark whether they are external or internal!</p>
<p><a href="/wp-content/uploads/2010/06/bridged2.png"><img src="/wp-content/uploads/2010/06/bridged2-300x197.png" alt="" title="bridged2" width="300" height="197" class="aligncenter size-medium wp-image-133" /></a></p>
<p>Now you can configure the bridge interface in the same way than any other interface, this process is well described in <a href="http://doc.ebox-platform.com/en/intro.html#network-configuration-with-ebox-platform">Network configuration with eBox Platform</a> section of <a href="http://doc.ebox-platform.com/en/index.html">eBox documentation</a>.</p>
<p><a href="/wp-content/uploads/2010/06/bridged3.png"><img src="/wp-content/uploads/2010/06/bridged3-300x220.png" alt="" title="bridged3" width="300" height="220" class="aligncenter size-medium wp-image-134" /></a></p>

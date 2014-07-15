---
layout: post
status: publish
published: true
title: Integrating Subsonic with Zentyal
date: !binary |-
  MjAxMS0wMy0wNiAyMzo1NjozMiArMDEwMA==
date_gmt: !binary |-
  MjAxMS0wMy0wNiAyMjo1NjozMiArMDEwMA==
categories:
- free software
- zentyal
---
I really love services like <a href="http://www.spotify.com/es/">Spotify</a> but I feel like loosing my freedom when I get used to them. Because of this lately I have been looking for open source alternatives to (eventually) replace these services with ones hosted by myself. This is the case of <a href="http://www.subsonic.org/pages/index.jsp">Subsonic</a>, which lets you to listen all your music from a web browser or even from an Android phone. Also this is a very good example on how easy it is to integrate 3th party software with <a href="http://www.zentyal.org">Zentyal</a>. Let's see how to do it:

<a href="http://www.subsonic.org"><img src="/wp-content/uploads/2011/03/subsonic.png" alt="Subsonic - Easy listening" title="Subsonic" width="478" height="99" class="aligncenter size-full wp-image-428" /></a>

First step: Installation
------------------------

We will start from a working Zentyal server and install Subsonic on top of it. You will need to follow <a href="http://www.subsonic.org/pages/installation.jsp#debian">installation guide</a> for Debian/Ubuntu. Basically these are the steps:

Install Java and the previously <a href="http://www.subsonic.org/pages/download.jsp">downloaded</a> Subsonic .deb package:

{% highlight bash %}
sudo apt-get install openjdk-6-jre
sudo dpkg -i subsonic-x.x.deb
{% endhighlight %}

It is also recommended to install typical multimedia transcoders: <code>sudo apt-get install lame flac faad vorbis-tools ffmpeg</code>

After installing, open the Subsonic web page on <strong>http://zentyal-ip:4040</strong>. A wizard will show up letting you configure basic Subsonic features.

Remember that you may need to configure Zentyal's firewall to open 4040 port. <a href="http://doc.zentyal.org/en/firewall.html">Firewall section</a> of documentation is a good source for that.

Second step: LDAP configuration
-------------------------------

Subsonic includes a LDAP backend, so you can configure it to bind to Zentyal's one. Go to <strong>Settings > Advanced</strong> and fill LDAP info as seen on the image:

<code>LDAP URL: ldap://localhost:389/ou=Users,dc=zentyal,dc=com<br />
LDAP Search Filter: (uid={0})</code>

If your Zentyal Users and Groups module is configured as <strong>slave</strong> you will need to change the port in the URL to <strong>1389</strong>.

<a href="/wp-content/uploads/2011/03/subsonic-ldap.png"><img src="/wp-content/uploads/2011/03/subsonic-ldap.png" alt="Subsonic LDAP configuration" title="Subsonic LDAP configuration" width="550" height="140" class="aligncenter size-full wp-image-468" /></a>

Congratulations, it's done! Now your Zentyal users can login into Subsonic and play and share music!

<a href="/wp-content/uploads/2011/03/subsonic1.png"><img src="/wp-content/uploads/2011/03/subsonic1-1024x549.png" alt="" title="Subsonic on Zentyal" width="550" class="aligncenter size-large wp-image-498" /></a>

Bonus track (Optional): File Sharing
------------------------------------

You can take advantage of <a href="http://www.samba.org/">Samba</a> based File Sharing module. By configuring a share pointing to the place where the music is stored users will be able to upload and organize their music. In the following screenshots you can see a share and its access list configuration, giving read and write permissions to developer's group.

<a href="/wp-content/uploads/2011/03/zentyal-samba-subsonic.png" ><img src="/wp-content/uploads/2011/03/zentyal-samba-subsonic-300x222.png" alt="" title="Zentyal Samba Configuration" width="270" class="size-medium wp-image-484" /></a><a href="/wp-content/uploads/2011/03/zentyal-samba-acl.png" ><img src="/wp-content/uploads/2011/03/zentyal-samba-acl-300x222.png" alt="" title="ACL&#039;s setup" width="270" class="size-medium wp-image-486" /></a>

As you see it's very easy to integrate Zentyal with other applications through <a href="http://doc.zentyal.org/en/directory.html">LDAP</a>, service <a href="http://doc.zentyal.org/en/develop.html?highlight=hooks#service-advanced-customisation">hooks</a> or even <a href="http://trac.zentyal.org/wiki/Document/Development">writing your own module</a>! If you have any doubts I'm sure you can find help in Zentyal <a href="http://lists.zentyal.org/cgi-bin/mailman/listinfo">mailing lists</a> or <a href="http://forum.zentyal.org">community forum</a>.

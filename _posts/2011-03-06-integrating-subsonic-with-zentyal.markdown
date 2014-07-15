---
layout: post
status: publish
published: true
title: Integrating Subsonic with Zentyal
author:
  display_name: exekias
  login: exekias
  email: exekias@gmail.com
  url: ''
author_login: exekias
author_email: exekias@gmail.com
wordpress_id: 426
wordpress_url: http://www.thebigbugtheory.com/?p=426
date: !binary |-
  MjAxMS0wMy0wNiAyMzo1NjozMiArMDEwMA==
date_gmt: !binary |-
  MjAxMS0wMy0wNiAyMjo1NjozMiArMDEwMA==
categories:
- free software
- zentyal
tags: []
comments:
- id: 18
  author: Pascal Bach
  author_email: pascal.bach@nextrem.ch
  author_url: http://pascal.nextrem.ch
  date: !binary |-
    MjAxMS0wMy0wOCAwMToxODoxOCArMDEwMA==
  date_gmt: !binary |-
    MjAxMS0wMy0wOCAwMDoxODoxOCArMDEwMA==
  content: ! 'Hi nice article.


    I have one question. Is it possible to change the LDAP filter expression to only
    allow users of a certain group?


    Regards

    Pascal'
- id: 19
  author: exekias
  author_email: exekias@gmail.com
  author_url: http://www.thebigbugtheory.com
  date: !binary |-
    MjAxMS0wMy0wOCAwMTo0NToxMSArMDEwMA==
  date_gmt: !binary |-
    MjAxMS0wMy0wOCAwMDo0NToxMSArMDEwMA==
  content: ! 'Thank you for your response Pascal!


    As far as I know you cannot do this by just changing the filter.


    You would need to enable <strong>Reverse Group Membership Maintenance</strong>
    (see <a href="http://www.openldap.org/doc/admin24/overlays.html#Reverse
    Group Membership Maintenance" rel="nofollow">OpenLDAP''s Manual on this</a>.
    After enabling this and setting "groupOfNames" objectclass to the group you could
    use a filter like this:


    <code>

    (&(uid={0})(memberOf=cn=GroupName,ou=Groups,dc=yourcompany,dc=com))

    </code>


    <a href="http://serverfault.com/questions/73213/how-do-i-configure-reverse-group-membership-maintenance-on-an-openldap-server-m"
    rel="nofollow">Here</a> you can find some tips & tricks.


    :)'
- id: 20
  author: Pascal Bach
  author_email: pascal.bach@nextrem.ch
  author_url: http://pascal.nextrem.ch
  date: !binary |-
    MjAxMS0wMy0wOCAxMTozNToxMyArMDEwMA==
  date_gmt: !binary |-
    MjAxMS0wMy0wOCAxMDozNToxMyArMDEwMA==
  content: ! 'Thank you for the hints.


    How would this change interfere with the LDAP management of Zentyal? Will it still
    be possible to use Users &amp; Groups as before?'
- id: 21
  author: exekias
  author_email: exekias@gmail.com
  author_url: http://www.thebigbugtheory.com
  date: !binary |-
    MjAxMS0wMy0wOCAxNzo1MDo0MiArMDEwMA==
  date_gmt: !binary |-
    MjAxMS0wMy0wOCAxNjo1MDo0MiArMDEwMA==
  content: ! 'Yes, but you can have problems in future upgrades of the module, especially
    if it change LDAP schema, anyway I don''t think so, and if it happens you can
    revert your changes by hand before upgrade.


    Of course if you try first do it in a testing deploy ;)


    Another option is to try to merge necessary code for this into our development
    tree, by sending a patch. I''m sure it will be welcomed!'
---
<p>I really love services like <a href="http://www.spotify.com/es/">Spotify</a> but I feel like loosing my freedom when I get used to them. Because of this lately I have been looking for open source alternatives to (eventually) replace these services with ones hosted by myself. This is the case of <a href="http://www.subsonic.org/pages/index.jsp">Subsonic</a>, which lets you to listen all your music from a web browser or even from an Android phone. Also this is a very good example on how easy it is to integrate 3th party software with <a href="http://www.zentyal.org">Zentyal</a>. Let's see how to do it:</p>
<p><a href="http://www.subsonic.org"><img src="/wp-content/uploads/2011/03/subsonic.png" alt="Subsonic - Easy listening" title="Subsonic" width="478" height="99" class="aligncenter size-full wp-image-428" /></a></p>
<h3>First step: Installation</h3></p>
<p>We will start from a working Zentyal server and install Subsonic on top of it. You will need to follow <a href="http://www.subsonic.org/pages/installation.jsp#debian">installation guide</a> for Debian/Ubuntu. Basically these are the steps:</p>
<p>Install Java and the previously <a href="http://www.subsonic.org/pages/download.jsp">downloaded</a> Subsonic .deb package:<br />
<code>sudo apt-get install openjdk-6-jre<br />
sudo dpkg -i subsonic-x.x.deb<br />
</code></p>
<p>It is also recommended to install typical multimedia transcoders: <code>sudo apt-get install lame flac faad vorbis-tools ffmpeg</code></p>
<p>After installing, open the Subsonic web page on <strong>http://zentyal-ip:4040</strong>. A wizard will show up letting you configure basic Subsonic features.<br />
Remember that you may need to configure Zentyal's firewall to open 4040 port. <a href="http://doc.zentyal.org/en/firewall.html">Firewall section</a> of documentation is a good source for that.</p>
<h3>Second step: LDAP configuration</h3></p>
<p>Subsonic includes a LDAP backend, so you can configure it to bind to Zentyal's one. Go to <strong>Settings > Advanced</strong> and fill LDAP info as seen on the image:</p>
<p><code>LDAP URL: ldap://localhost:389/ou=Users,dc=zentyal,dc=com<br />
LDAP Search Filter: (uid={0})</code></p>
<p>If your Zentyal Users and Groups module is configured as <strong>slave</strong> you will need to change the port in the URL to <strong>1389</strong>.</p>
<p><a href="/wp-content/uploads/2011/03/subsonic-ldap.png"><img src="/wp-content/uploads/2011/03/subsonic-ldap.png" alt="Subsonic LDAP configuration" title="Subsonic LDAP configuration" width="550" height="140" class="aligncenter size-full wp-image-468" /></a></p>
<p>Congratulations, it's done! Now your Zentyal users can login into Subsonic and play and share music!</p>
<p><a href="/wp-content/uploads/2011/03/subsonic1.png"><img src="/wp-content/uploads/2011/03/subsonic1-1024x549.png" alt="" title="Subsonic on Zentyal" width="550" class="aligncenter size-large wp-image-498" /></a></p>
<h3>Bonus track (Optional): File Sharing</h3></p>
<p>You can take advantage of <a href="http://www.samba.org/">Samba</a> based File Sharing module. By configuring a share pointing to the place where the music is stored users will be able to upload and organize their music. In the following screenshots you can see a share and its access list configuration, giving read and write permissions to developer's group.</p>
<p><a href="/wp-content/uploads/2011/03/zentyal-samba-subsonic.png" style="float: left"><img src="/wp-content/uploads/2011/03/zentyal-samba-subsonic-300x222.png" alt="" title="Zentyal Samba Configuration" width="270" class="size-medium wp-image-484" /></a><a href="/wp-content/uploads/2011/03/zentyal-samba-acl.png" style="float: left"><img src="/wp-content/uploads/2011/03/zentyal-samba-acl-300x222.png" alt="" title="ACL&#039;s setup" width="270" class="size-medium wp-image-486" /></a></p>
<p style="clear: left"></p></p>
<p>As you see it's very easy to integrate Zentyal with other applications through <a href="http://doc.zentyal.org/en/directory.html">LDAP</a>, service <a href="http://doc.zentyal.org/en/develop.html?highlight=hooks#service-advanced-customisation">hooks</a> or even <a href="http://trac.zentyal.org/wiki/Document/Development">writing your own module</a>! If you have any doubts I'm sure you can find help in Zentyal <a href="http://lists.zentyal.org/cgi-bin/mailman/listinfo">mailing lists</a> or <a href="http://forum.zentyal.org">community forum</a>.</p>

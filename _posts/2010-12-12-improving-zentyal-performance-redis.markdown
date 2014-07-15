---
layout: post
published: true
title: "Improving Zentyal performance: Redis"
categories:
- free software
- ebox
- zentyal
tags: []
---
Now that we have some time after our [2.0 release](http://trac.zentyal.org/wiki/Document/Announcement/2.0) I want to start a series of post about how to improve Zentyal performance (what we've done, what we will do, and what you can do). In this first post I'm going to talk about one of the new [Zentyal](http://www.zentyal.org) features. [Redis](http://code.google.com/p/redis/) as config backend.

<img src="/wp-content/uploads/2010/12/82.png" alt="redis" title="redis" width="513" height="197" class="aligncenter size-full wp-image-295" /><br />

[Redis](http://code.google.com/p/redis) is a persistent key-value database written with performance in mind, it stores the whole database in memory and syncs to disk asynchronously.

Previous backend: GConf
-----------------------

<p>Before <a href="http://code.google.com/p/redis/">Redis</a>, <a href="http://www.zentyal.org">Zentyal</a> stored configuration in <a href="http://projects.gnome.org/gconf/">GConf</a>, the engine that <a href="http://www.gnome.org/">Gnome Desktop</a> uses to store user preferences. Besides few minor problems, our main issue with <a href="http://projects.gnome.org/gconf/">GConf</a> was it is intended for desktop applications and does not provide much performance. We searched for alternatives that would be fast, lightweight and easy to use (protocol, api...) and finally chose <a href="http://code.google.com/p/redis/">Redis</a> as it had all this and more!</p>



Integration with Zentyal
------------------------

<p>Migrating from <a href="http://projects.gnome.org/gconf/">GConf</a> to <a href="http://code.google.com/p/redis/">Redis</a> was not a trivial task, <a href="http://projects.gnome.org/gconf/">GConf</a> keys are organized into a hierarchy while <a href="http://code.google.com/p/redis/">Redis</a> is a flat key-value store. <a href="http://gitorious.org/~juruen">Javier Uruen</a> did most of the work as a <a href="http://trac.zentyal.org/wiki/Contribute">Zentyal contributor</a>, he rewrote our backend to be compatible with old code! For those interested in the internals you can see <a href="http://trac.zentyal.org/browser/trunk/client/ebox/src/EBox/Config/Redis.pm">Redis.pm</a>, for example:</p>

{% highlight perl %}
sub all_entries
{
    my ($self, $key) = @_;
    my $length = length $key;
    my @dirs;
    for my $path ($self->_redis_call('keys', "$key/*")) {
        push (@dirs, $path) if (index($path, '/', $length + 1) == -1);
    }
    return @dirs;
}
{% endhighlight %}

Future work
-----------

There are some features that can take advantage of Redis and will use in some moment: make a better use of its <a href="http://code.google.com/p/redis/wiki/CommandReference">rich instruction set</a> or benefit from its replication features, <a href="http://planet.zentyal.org/">stay tuned</a> for future updates!

If you also want to contribute you can do it! You can translate, test, help people using Zentyal... Visit <a href="http://trac.zentyal.org/wiki/Contribute">our contribute page</a> for more info!

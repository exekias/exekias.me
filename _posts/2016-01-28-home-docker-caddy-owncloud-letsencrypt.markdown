---
title: Host your own data with Docker, Owncloud, Caddy and Let's Encrypt
date: 2016-01-28 18:46
layout: post
---
Recently I have been playing with [Caddy](https://caddyserver.com/). I wanted
to host my own [Owncloud](https://www.owncloud.org) instance on my home NAS, so I
can sync & backup all my pictures and docs from my phone and laptop.

In order to improve isolation and make it easier to maintain I'm using
[Docker](https://www.docker.com), making the whole thing more portable and
easy to bootstrap.

So let's have fun!

Docker Compose
--------------
In Feb 2015 Docker [moved fig functionality into Docker Compose](http://blog.docker.com/announcing-docker-compose/),
it is a handy tool to deploy and manage small scenarios with multiple containers. You can
define containers in a YAML file and use the tool to bring them up. It takes
care of building/downloading images, and managing their lifecycle.

So as a requirement for next steps, you will have to [install Docker](https://docs.docker.com/engine/installation/)
if it's not present in your system.

Owncloud
--------
We will be using the officially supported [Owncloud image from Docker Hub](https://hub.docker.com/_/owncloud/),
it provides several ways of deploying Owncloud, we will be using the default one (Apache).
Our `docker-compose.yml` will look like this:

{% highlight yaml %}
owncloud:
  image: owncloud
  restart: always
  expose:
   - 80
  volumes_from:
    - owncloud-data
  domainname: your.hostname.com  # REPLACE THIS WITH YOUR HOSTNAME

owncloud-data:
  image: owncloud
  # DATA CONTAINER, exit after container is created
  # Also fix permissions on data folders (33 is www-data UID)
  command: /bin/bash -c "/bin/chown -R 33 /var/www/html/config"
  volumes:
    - /var/www/html/data
    - /var/www/html/config
{% endhighlight %}

This file basically defines two containers, one Owncloud stateless instance, serving the web, and
one data volume container, holding the persistent data. You can read more about data
volume containers in [Docker's documentation](https://docs.docker.com/engine/userguide/dockervolumes/).

Exposing the 80 port makes it accessible from other
containers. Just note that `expose` doesn't publish the port to the host machine, it
just makes it accessible if you reach the container host.

`restart` setting will ensure that Owncloud container is restarted if, for some reason,
it crashes.

Also, through the use of `volumes_from`, we mount volumes from `owncloud-data` container
into the `owncloud` one.

Now it's time to bring it up, running:

{% highlight sh %}
$ docker-compose up -d
{% endhighlight %}

It will bring the containers up (in detached mode). You can check the logs with:

{% highlight sh %}
$ docker-compose logs owncloud
{% endhighlight %}

If you want to know more usefult commands check [Docker Compose doc](https://docs.docker.com/compose/).


Caddy
-----
With Owncloud running, it's time to put a proxy in front of it, facing the Internet (or
your LAN). This proxy will provide routing between all your internal services and will add a
security layer with SSL termination.

[Caddy](https://caddyserver.com/) provides an easy way to configure HTTP server and
proxy, with some goodies, like HTTP/2 support or automated SSL certificates deployment
with [Let's Encrypt](https://letsencrypt.org/).

I've created my own [docker image for Caddy](//github.com/exekias/docker-caddy), feel
free to fork it if you want :)

To add Caddy to our scenario just add this to the `docker-compose.yml` file:

{% highlight yaml %}
caddy:
  image: exekias/caddy
  ports:
    - 80:80
    - 443:443
  volumes:
    - ./Caddyfile:/Caddyfile
  restart: always
  links:
    - owncloud
{% endhighlight %}


We are using the `ports` setting this time, unlike `expose`, this will publish the ports
to the host machine, so you can access http[s]://your.host.ip

The `links` setting is also important: It will create a `/etc/hosts` entry with an alias for the IP
of the configured container(s).

Most probably you have noticed the `Caddyfile` volume, we use that for exposing
a Caddy settings file inside the container.

My `Caddyfile` contains::

{% highlight text %}
# Permanent redirect to HTTPS
0.0.0.0:80 {
  log stdout
  errors stderr
  redir https://your.hostname.com{uri} 301
}

https://your.hostname.com {
  log stdout
  errors stderr
  tls your@email.address
  proxy / http://owncloud:80 {
    proxy_header Host {host}
  }
}
{% endhighlight %}

This syntax is quite straight forward but if you are looking at more complex set ups,
check [caddy docs](https://caddyserver.com/docs/getting-started).


The SSL configuration is just the `tls` line. This sole line tells Caddy to automatically
follow Let’s Encrypt ACME protocol and get a valid certificate for your site,
including the automated renewal.

Run `docker-compse up -d` again to bring Caddy up, the command will not affect the
containers that already running.

Now you should be able to access your site through HTTPS too! go to https://your.hostname.com
and check it!

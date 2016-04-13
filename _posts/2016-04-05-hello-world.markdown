---
layout: post
title:  "Hello World"
date:   2016-04-05 11:32:00
description: Hello World
categories:
- blog
permalink: hello-world
---

Finally the Mothership arrives...

Build it with:

`docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll   -it -p 127.0.0.1:4000:4000 jekyll/jekyll:pages`


---
layout: post
title:  "Zehn Dinge über Docker"
date:   2016-04-05 11:32:00
description: Zehn Dinge über Docker
categories:
- blog
permalink: zehn-dinge-ueber-docker
---

10 Dinge die ich über Docker gelernt habe
=========================================

1) Docker und CentOS
--------------------
*Das Standart-Filesystem für Docker ist aufs.
*Die CentOS Kernel bietet keine aufs Unterstützung.
*Devicemapper seit linux 2.6
*Devicemapper mit default loop0 ineffizient
*Devicemapper auf Blockdevice zeigen lassen

2) Docker und Kaspersky for Linux Fileservers
---------------------------------------------
*Kaspersky hängt sich weg beim Scannen der Devices
*Semaphornen werden nicht freigegeben, dadurch hängt Docker
*Devicemapper olé
*


3) Demokratie mit Consul

4) Docker mit Corporate Proxy

5) Der vergessliche Registrator
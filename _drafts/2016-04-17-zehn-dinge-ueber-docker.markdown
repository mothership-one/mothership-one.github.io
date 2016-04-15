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
*gefunden durch dmesg und udev
*Ausnahme für /lib/var/docker und /dev hinzugefügt

3) Demokratie mit Consul
*Raft Protokoll
*Majority / Leader Eltecion
*Beispiel 3 -2 und 5 - 3
*Unterscheide dev und prod

4) Docker mit Corporate Proxy
-----------------------------
* pear
* container build
* container run
* docker machine
* etc

5) Der vergessliche Registrator
-------------------------------
*registrator Ausfall
*container stop event wird nicht verarbeitet und registrator prüft nicht proaktiv
*ttl für services sorgen dafür karteileichen aufzuräumen
*lange ttl für self healing system über nacht
*healthchecks für kurzfristiges umrouten

6) Lokal mit Virtualbox und docker machine
------------------------------------------
* instant docker swarm mit consul


Fazit:
------

dev to prod docker klippe
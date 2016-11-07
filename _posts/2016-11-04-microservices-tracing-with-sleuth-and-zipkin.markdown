---
layout: post
title:  "Tracing in verteilten Systemen mit Spring Cloud Sleuth und Zipkin"
author: pg2000
date:   2016-11-04 15:27:00
description: Tracing in verteilten Systemen mit Spring Cloud Sleuth und Zipkin
categories:
- Microservices
- Tracing
- Spring
- Spring Boot
permalink: tracing-distributed-services-with-spring-cloud-sleuth-and-zipkin
---

Wie lange benötigt ein Request der mehrere (Micro-)Services durchläuft und wie finde ich
Flaschenhälse, die zu einem schlechten Laufzeitverhalten führen.

Dies sind häufig Fragen, die man sich stellt wenn man bereits einige Services entwickelt hat und
dann nicht mehr genau nachvollziehen kann wie sich eine Anfrage durch
mehrere Systeme verhält und wie man wieder Herr über diese Situation wird.

Da wir sehr stark auf Spring Boot setzen und mit Sleuth eine einfache Lösung existiert
möchte ich euch hier [Spring Cloud Sleuth][1] vorstellen.

Die Demo dazu findet ihr unter: [https://github.com/PG2000/spring-boot-sleuth-zipkin-demo][3]

## Was ist Spring Cloud Sleuth?

Mit Spring Cloud Sleuth ist es möglich Requests über Systemgrenzen hinaus zu markieren
und Traces an ein Aggregationsystem zu versenden.

Wie gewohnt ist die Integration in Spring Boot Projekten sehr einfach gehalten.

Unter Gradle genügt folgende Dependency:

{% highlight groovy %}
compile('org.springframework.cloud:spring-cloud-starter-sleuth')
{% endhighlight %}

Um die Traces auch zu einem Zipkin Server senden zu können muss
noch folgende Abhängigkeit geladen werden:

{% highlight groovy %}
compile('org.springframework.cloud:spring-cloud-starter-sleuth')
{% endhighlight %}

Damit hat man dann auch die Möglichkeit einen lokalen Zipkin Server zu starten.
Dieser wird in meiner Demo aber als eigener Docker Container gestartet.

Für Maven gibt es unter [https://cloud.spring.io/spring-cloud-sleuth/](https://cloud.spring.io/spring-cloud-sleuth/) die Quick Start Konfiguration.

In der application.yml muss noch der (spring.application.name) konfiguriert werden

```yml
spring:
  application:
    name: mothership-service-one
```

um eine sinnvolle Ausgabe im Trace zu erhalten.

Das war es dann auch schon.

Die Traces werden nun für folgende Spring Komponenten mit Zero-Configuration Aufwand erstellt.

- Runnables und Callables
- Logging
- Hystrix (Commands)
- RXJava
- HTTP Integration (HTTP Filter, HandlerInterceptor etc.)
- HTTP Client Integration (RestTemplate, AsyncRestTemplate)
- Feign
- Asynchronous Communication (@Async, @Scheduled etc.)
- Messaging
- Zuul

### Wie ist ein Trace aufgebaut?:

Der Aufbau des Trace ist relativ simpel und sieht in der Console in etwa so aus.

{% highlight bash %}
mothership-service-one_1  | 2016-11-04 15:27:43.303  INFO [mothership-service-one,a379156c77b387b7,5a9b9c7ce64a6275,true] 1 --- [nio-8080-exec-1] one.mothership.MothershipOneResource     : ....
{% endhighlight %}

die eigentlich interessante Information ist nun folgende:

{% highlight javascript %}
[mothership-service-one,a379156c77b387b7,5a9b9c7ce64a6275,true]
{% endhighlight %}

Die Felder haben folgende Bedeutung:

| Wert                    | Bedeutung                                                                |
| ----------------------- |:------------------------------------------------------------------------:|
| mothership-service-one  | Spring Application Name (spring.application.name) in der application.yml |
| a379156c77b387b7        | Die Trace ID                                                             |
| 5a9b9c7ce64a6275        | Die Span ID                                                              |
| true                    | Gibt an ob der Trace an den Zipkin Server gesendet werden soll           |

Dieser Trace wird - falls konfiguriert - dann auch an den Zipkin Server gesendet.

Schematisch betrachtet funktioniert dies in etwa so:

![Image](/assets/img/sleuth-and-zipkin-spring-boot/sleuth-simple.svg)

Die Aggregation der Daten erfolgt in Zipkin und sieht dannfolgendermaßen aus:

![Image](/assets/img/sleuth-and-zipkin-spring-boot/zipkin-trace-view.png)

Zipkin kann auch die Abhängigkeiten zwischen Systemen visualiseren.

![Image](/assets/img/sleuth-and-zipkin-spring-boot/zipkin-dependency.png)

was bei einer Vielzahl von Services sehr praktisch sein kann um
Kommunikationswege nachzuvollziehen.

In der Default Konfiguration wird nicht jede Aktion getraced um einen Overhead in
hochfrequentierten Services zu vermeiden.
Für die Demo wollte ich jedoch jeden Aktion tracen.
Dies ist mit folgendem Bean möglich.

{% highlight java %}
@Bean
public Sampler defaultSampler() {
  return new AlwaysSampler();
}
{% endhighlight %}

Weitere Sampling Strategien findet ihr [hier][4].

### Fazit:

Mit Spring Cloud Sleuth erhaltet ihr im Spring Boot Umfeld eine schnelle Lösung um
in verteilten Systemen aussagefähige Traces zu erstellen. Ein Nachteil ist es jedoch wenn die Service
Landschaft polyglott entwickelt wurde und dadurch Lücken im Trace entstehen.

Dazu entwickelt sich gerade eine Vendor unabhängie Alternative unter [opentracing.io](http://opentracing.io/)

Übrigens gibt es einen schönen Nebeneffekt wenn ihr ein zentralisiertes Logging betreibt:
Beim Logging wird die Trace Id ebenfalls verwendet. Daher ist es auch möglich z.B.
im Graylog oder Kibana danach zu suchen und systemübergreifend Logs zu verfolgen.
Dies funktioniert sogar wenn Zipkin deaktiviert ist.

Die ausführliche Dokumentation zu Spring Cloud Sleuth findet ihr [hier][2].

[1]: https://cloud.spring.io/spring-cloud-sleuth/
[2]: http://cloud.spring.io/spring-cloud-sleuth/spring-cloud-sleuth.html
[3]: https://github.com/PG2000/spring-boot-sleuth-zipkin-demo
[4]: http://cloud.spring.io/spring-cloud-sleuth/spring-cloud-sleuth.html#_sampling

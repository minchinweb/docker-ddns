# Dynamic DNS

Update DDNS at [Domain-DNS.com](https://domain-dns.com/)

[![Docker Pulls](https://img.shields.io/docker/pulls/minchinweb/ddns.svg?style=popout)](https://hub.docker.com/r/minchinweb/ddns)
[![Size & Layers](https://images.microbadger.com/badges/image/minchinweb/ddns.svg)](https://microbadger.com/images/minchinweb/ddns)
[![GitHub issues](https://img.shields.io/github/issues-raw/minchinweb/docker-ddns.svg?style=popout)](https://github.com/MinchinWeb/docker-ddns/issues)
<!--
![MicroBadger Layers](https://img.shields.io/microbadger/layers/layers/minchinweb/ddns.svg?style=plastic)
![MicroBadger Size](https://img.shields.io/microbadger/image-size/image-size/minchinweb/ddns.svg?style=plastic)
-->

## How to Use This

This is only useful if you have your DNS at
[Domain-DNS.com](https://domain-dns.com/), which is only an option if you use
[BareMetal.com](http://baremetal.com/) as your domain register.

For the URL you want to update, there will be a "Remote IP Key" listed.

Then, supply the needed environmental varaibles in your `docker-compose.yaml`
file:

      ddns:
        image: minchinweb/ddns
        restart: unless-stopped
        environment:
          - PUID=${PUID}
          - PGID=${PGID}
          - DDNS_DOMAIN_NAME=<<your domain name>
          - DDNS_KEY=<<Remote IP Key>>
        volumes:
          - /etc/localtime:/etc/localtime:ro

Adding `localtime` as a volume will make the timestamps on your log files match
your host timezone.

Then, on start up and about every 5 minutes afterwards, the IP address of your
server will be checked. If it's the same as it was before, nothing happens; if
it's changes, an update request is submitted.


## Why I Created This

or, *What Problems is This Trying to Solve?*

I have a dynamic IP address and a URL for my Docker server. Automation seems
like the smart way to keep the URL pointing to that IP address, even if that IP
address changes.

## Prior Art

This is based on my [Python base
image](https://github.com/MinchinWeb/docker-python).

## Known Issues

- Domain-dns sets their TTL ("Time To Live") to 20 minutes (and there doesn't
  seem to be a way to manually override that), so updates may take up to 40
  minutes to show on end-users' machines.
- If you still can't connect to your server after this is working, you may need
  to configure port forwarding on your router. Also, your ISP may be blocking
  the port you are trying to connect on.
- I have no idea if this will work with any other DDNS service. Pull requests
  are welcomed though.

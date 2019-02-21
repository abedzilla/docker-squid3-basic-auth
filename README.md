# squid3-basic-ncsa-auth-docker

A Squid3 caching proxy with SSL enabled in a Docker container, based on
https://github.com/toffer/docker-squid3-ssl and meant to be used from within
other Docker containers.

## Details

* ubuntu:bionic-20181204
* Squid (Version 3.5.27).

## Usage

Start Squid3 setting its hostname and container name:

```
$ docker run -d -h proxy.docker.dev --name squid3 fgrehm/squid3-ssl:v20140809
```


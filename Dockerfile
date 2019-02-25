FROM sameersbn/ubuntu:14.04.20170123
LABEL maintainer="abedzilla@gmail.com"

MAINTAINER sameer@damagehead.com

ENV SQUID_VERSION=3.3.8 \
    SQUID_CACHE_DIR=/var/cache/squid3 \
    SQUID_LOG_DIR=/var/log/squid3 \
    SQUID_USER=proxy \
    SQUID_AUTH_USER=proxy \
    SQUID_AUTH_PASSWORD=secret

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 80F70E11F0F0D5F10CB20E62F5DA5F09C3173AA6 \
 && echo "deb http://ppa.launchpad.net/brightbox/squid-ssl/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid3-ssl=${SQUID_VERSION}* apache2-utils \
 && mv /etc/squid3/squid.conf /etc/squid3/squid.conf.dist \
 && rm -rf /var/lib/apt/lists/*

COPY squid.conf /etc/squid3/squid.conf
COPY baddomains.txt /etc/squid3/baddomains.txt
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

VOLUME ["${SQUID_CACHE_DIR}", "${SQUID_LOG_DIR}"]

EXPOSE 8888/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]

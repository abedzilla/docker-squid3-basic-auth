FROM ubuntu:bionic-20181204
LABEL maintainer="abedzilla@gmail.com"

ENV SQUID_VERSION=3.5.27 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy \
    SQUID_AUTH_USER=abe \
    SQUID_AUTH_PASSWORD=asdfasdf

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid=${SQUID_VERSION}* \
    apache2-utils \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash proxy
RUN groupadd proxy
RUN usermod -aG proxy proxy

COPY squid.conf /etc/squid/squid.conf
COPY baddomains.txt /etc/squid/baddomains.txt

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 8888/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]

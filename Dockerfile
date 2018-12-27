FROM ubuntu:trusty
MAINTAINER  Abe Tobing <abedzilla@gmail.com>

VOLUME /var/cache/squid3

RUN apt-get -qqy update
RUN apt-get -qqy upgrade
RUN apt-get -qqy install apache2-utils squid3

# If you are prone to gouging your eyes out, do not read the following 2 lines
RUN sed -i 's@#\tauth_param basic program /usr/lib/squid3/basic_ncsa_auth /usr/etc/passwd@auth_param basic program /usr/lib/squid3/basic_ncsa_auth /usr/etc/passwd\nacl ncsa_users proxy_auth REQUIRED@' /etc/squid3/squid.conf
RUN sed -i 's@^http_access allow localhost$@\0\nhttp_access allow ncsa_users@' /etc/squid3/squid.conf

RUN mkdir /usr/etc

VOLUME /var/log/squid3

# Initialize dynamic certs directory
#RUN /usr/lib/squid3/ssl_crtd -c -s /var/lib/ssl_db
#RUN chown -R proxy:proxy /var/lib/ssl_db

# Prepare configs and executable
ADD squid.conf /etc/squid3/squid.conf
#RUN chmod +x /usr/local/bin/run
ADD init /init
RUN chmod +x /init

EXPOSE 8888

CMD ["/init"]


#EXPOSE 8888
#CMD ["/usr/local/bin/run"]

FROM ivixq/alpine-s6
MAINTAINER ivixq

## Install zabbix php7 apache
RUN apk --update add zabbix zabbix-mysql zabbix-webif zabbix-setup zabbix-utils \
          php7-apache2 php7-session php7-mysqli php7-mbstring php7-ldap ttf-dejavu \
#          php5-apache2 php5-bcmath php5-ctype php5-gd php5-gettext php5-json php5-ldap \
#          php5-mysqli php5-sockets php5-xmlreader ttf-dejavu \
          net-snmp net-snmp-tools mariadb-client nmap perl && \
    rm -rf /var/cache/apk/*

COPY rootfs /

RUN chmod 640 /etc/zabbix/zabbix_server.conf \
    && chown root:zabbix /etc/zabbix/zabbix_server.conf \
    && chmod 755 /etc/zabbix/alertscripts/* \
    && chown zabbix:zabbix /etc/zabbix/alertscripts/*

## Export volumes directory
VOLUME ["/etc/zabbix/externalscripts"]

## Export ports
EXPOSE 10051/tcp 10052/tcp 80/tcp 162/udp


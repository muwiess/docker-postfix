FROM alpine:3.13
MAINTAINER Juan Luis Baptiste juan.baptiste@gmail.com

RUN apk update && \
    apk add curl bash gawk cyrus-sasl cyrus-sasl-login cyrus-sasl-crammd5 mailx \
    postfix && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/log/supervisor/ /var/run/supervisor/ && \
    sed -i -e 's/inet_interfaces = localhost/inet_interfaces = all/g' /etc/postfix/main.cf

COPY run.sh /
RUN cat run.sh
RUN chmod +x /run.sh
RUN newaliases

ENV SMTP_SERVER=""
ENV SMTP_PORT="25"
ENV SMTP_USERNAME=""
ENV SMTP_PASSWORD=""
ENV SERVER_HOSTNAME=""
ENV ALWAYS_ADD_MISSING_HEADERS="yes"
ENV SMTP_USE_TLS="yes"
ENV SMTPD_TLS_SESSION_CACHE_DATABASE="btree:\${data_directory}/smtpd_scache"
ENV SMTP_TLS_CACHE_DATABASE="btree:\${data_directory}/smtp_scache"
ENV MYHOSTNAME=""
ENV MYORIGIN="/etc/mailname"
ENV MYDESTINATION="\$myhostname"
ENV RELAYHOST="[]:25"
ENV MYNETWORKS=""


EXPOSE 25
#ENTRYPOINT ["/run.sh"]
CMD ["/run.sh"]

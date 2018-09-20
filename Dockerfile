FROM alpine:3.7
LABEL maintainer="isca at isca dot space"

RUN     apk add --update --no-cache \
        opendkim \
        opendkim-utils \
        socat \
        && rm -Rf /var/cache/apk/*

RUN     (mkdir -p /etc/opendkim/keys; \
         mkdir -p /run/opendkim)

COPY    confs/opendkim.conf /etc/opendkim/opendkim.conf
COPY    sh/run.sh /bin/run
RUN     (chmod 755 /bin/run)

EXPOSE  8891
VOLUME  /etc/opendkim/keys

ENTRYPOINT  ["/bin/run"]

FROM openjdk:8-jre-alpine
MAINTAINER julien BONACHERA <julien@bonachera.fr>
CMD java -jar lib/ace.jar start
RUN apk add \
    --no-cache \
    --update \
    mongodb curl python3 libc6-compat

ENV VERSION=5.12.35
RUN curl -sLo /opt/ubnt.zip  http://dl.ubnt.com/unifi/${VERSION}/UniFi.unix.zip &&\
    python3 -m zipfile -e /opt/ubnt.zip /opt && \
    rm -f /opt/ubnt.zip
RUN ln -sf /usr/bin/mongod /opt/UniFi/bin/mongod
RUN apk add --no-cache java-snappy && \
rm /opt/UniFi/lib/snappy-java-* && \
ln /usr/share/java/snappy-java-* /opt/UniFi/lib/

WORKDIR /opt/UniFi
VOLUME /opt/UniFi/data
VOLUME /opt/UniFi/data/db

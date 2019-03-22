FROM openjdk:8-jre-alpine
MAINTAINER julien BONACHERA <julien@bonachera.fr>
CMD java -jar lib/ace.jar start
RUN apk add \
    --no-cache \
    --update \
    mongodb curl python3 && \
    rm /usr/bin/mongo && \
rm /usr/bin/mongos

ENV VERSION=5.10.19
RUN curl -sLo /opt/ubnt.zip  http://dl.ubnt.com/unifi/${VERSION}/UniFi.unix.zip &&\
    python3 -m zipfile -e /opt/ubnt.zip /opt && \
    rm -f /opt/ubnt.zip
RUN ln -sf /usr/bin/mongod /opt/UniFi/bin/mongod
WORKDIR /opt/UniFi
VOLUME /opt/UniFi/data
VOLUME /opt/UniFi/data/db

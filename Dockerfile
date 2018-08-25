FROM jbonachera/arch
MAINTAINER julien BONACHERA <julien@bonachera.fr>
RUN useradd -r unifi
CMD java -jar lib/ace.jar start
RUN pacman -S --needed --noconfirm mongodb jdk8-openjdk python && \
    rm -rf /var/cache/pacman/*
ENV VERSION=5.8.28
RUN curl -sLo /opt/ubnt.zip  http://dl.ubnt.com/unifi/${VERSION}/UniFi.unix.zip &&\
    python3 -m zipfile -e /opt/ubnt.zip /opt && \
    rm -f /opt/ubnt.zip && \
    chown unifi: -R /opt/UniFi
WORKDIR /opt/UniFi
COPY mongod-script /opt/UniFi/bin/mongod
USER unifi
VOLUME /opt/UniFi/data

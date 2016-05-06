FROM fedora:23
MAINTAINER julien BONACHERA <julien@bonachera.fr>
RUN useradd -r unifi
VOLUME /opt/UniFi/data
CMD java -jar lib/ace.jar start
ENV VERSION=4.8.18
RUN dnf install -y curl mongodb-server java-1.8.0-openjdk-headless && \
    curl -sLo /opt/ubnt.zip  http://dl.ubnt.com/unifi/${VERSION}/UniFi.unix.zip &&\
    python3 -m zipfile -e /opt/ubnt.zip /opt && \
    rm -f /opt/ubnt.zip && \
    chown unifi: -R /opt/UniFi && \
    dnf clean all && \
    ln -sf /usr/bin/mongod /opt/UniFi/bin/mongod
WORKDIR /opt/UniFi
USER unifi

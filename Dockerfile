FROM alpine:3.7

ENV NEXUS_VERSION 3.9.0-01
ENV SONATYPE_DIR=/opt/sonatype
ENV NEXUS_HOME=${SONATYPE_DIR}/nexus \
    NEXUS_DATA=/nexus-data \
    NEXUS_CONTEXT='' \
    SONATYPE_WORK=${SONATYPE_DIR}/sonatype-work
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre

# Packages
RUN set -ex;\
    apk update;\
    apk upgrade;\
    apk add --no-cache su-exec ca-certificates openjdk8 curl tar;\
    rm -rf /var/cache/apk/*;\
    echo "*** Add Nexus system account ***";\
    addgroup -S nexus;\
    adduser -S -D -h /home/nexus -s /bin/false -G nexus -g "nexus iam system account" nexus;\
    chown -R nexus /home/nexus

# Nexus
RUN set -ex;\
    echo "Installing Nexus ${NEXUS_VERSION} ...";\
    mkdir -p /opt/sonatype/nexus /opt/sonatype/sonatype-work;\
    curl -sSL --retry 3 https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz | tar -C ${NEXUS_HOME} -xvz --strip-components=1 nexus-${NEXUS_VERSION};\
    sed -e '/^nexus-context/ s:$:${NEXUS_CONTEXT}:' -i ${NEXUS_HOME}/etc/nexus-default.properties;\
    sed -e '/^-Xms/d' -e '/^-Xmx/d' -e '/MaxDirectMemorySize/d' -e '/UnlockDiagnosticVMOptions/d' -i ${NEXUS_HOME}/bin/nexus.vmoptions;\
    echo -e '-XX:+UnlockExperimentalVMOptions\n-XX:+UseCGroupMemoryLimitForHeap\n-XX:MaxRAMFraction=2\n-XX:+HeapDumpOnOutOfMemoryError\n-XshowSettings:vm\n-Djava.awt.headless=true' >> ${NEXUS_HOME}/bin/nexus.vmoptions;\
    ln -s ${NEXUS_DATA} /opt/sonatype/sonatype-work/nexus3

# Add local files and according directories to image
COPY files /

EXPOSE 8081 5000

VOLUME ${NEXUS_DATA}

WORKDIR /opt/sonatype/nexus

ENTRYPOINT ["entrypoint.sh"]
CMD ["bin/nexus","run"]

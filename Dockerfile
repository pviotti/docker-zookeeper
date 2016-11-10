FROM java:openjdk-8-jre-alpine
MAINTAINER Paolo Viotti <paolo.viotti@gmail.com>

ENV zkversion 3.4.9

RUN apk add --no-cache wget bash gawk \
    && mkdir /opt \
    && wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-$zkversion/zookeeper-$zkversion.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-$zkversion /opt/zookeeper \
    && mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888

VOLUME "/tmp/zookeeper"

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/zookeeper/bin

CMD ["zkServer.sh", "start-foreground"]

FROM ubuntu:14.04
MAINTAINER Iain Mckay <me@iainmckay.co.uk>

ENV DEBIAN_FRONTEND noninteractive
ENV ETCD_IP 172.17.42.1
ENV ETCD_PORT 4001
ENV S3_OBJECT etcd.json

RUN apt-get update \
    && apt-get install -yq --no-install-recommends python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && pip install awscli

RUN apt-get update \
    && apt-get install -yq --no-install-recommends git nodejs npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g git+https://github.com/tombburnell/etcd-dump.git

ADD start.sh /start.sh

ENTRYPOINT ["/start.sh"]
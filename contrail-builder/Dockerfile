FROM ubuntu:14.04.2
MAINTAINER Kyle Bai (kyle.b@inwinstack.com)

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y curl git python software-properties-common wget && \
  curl -sL https://deb.nodesource.com/setup_6.x | bash -
  apt-add-repository -y ppa:opencontrail/ppa  && \
  apt-get update && \
  apt-get install -y libipfix-dev librdkafka-dev librdkafka1 python-sphinx autoconf \
                     automake bison debhelper flex libcurl4-openssl-dev \
                     libexpat-dev libgettextpo0 libprotobuf-dev libtool libxml2-utils \
                     make protobuf-compiler python-all python-dev python-lxml \
                     python-setuptools python-sphinx ruby-ronn scons unzip vim-common \
                     libsnmp-python libipfix-dev librdkafka-dev librdkafka1 libboost-dev \
                     libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev \
                     libboost-program-options-dev libboost-python-dev libboost-regex-dev \
                     libboost-system-dev libcurl4-openssl-dev google-mock libgoogle-perftools-dev \
                     liblog4cplus-dev libtbb-dev libhttp-parser-dev libxml2-dev libicu-dev \
                     linux-headers-4.2.0-27-generic libzookeeper-mt-dev ant default-jdk javahelper \
                     libcommons-codec-java libhttpcore-java liblog4j1.2-java nodejs module-assistant && \


COPY entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]

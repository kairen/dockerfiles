FROM centos:7
MAINTAINER Kyle Bai <kyle.b@inwinstack.com>

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install \
    httpd \
    yum-utils \
    createrepo && \
    rm /etc/httpd/conf.d/welcome.conf

COPY setup.sh /opt/setup.sh
COPY run-httpd.sh /run-httpd.sh

RUN chmod -v +x /run-httpd.sh && \
    chmod -v +x /opt/setup.sh && \
    /opt/setup.sh && \
    rm /opt/setup.sh && \
    yum clean all

EXPOSE 80
CMD ["/run-httpd.sh"]

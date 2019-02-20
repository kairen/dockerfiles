FROM ubuntu:16.04
MAINTAINER Kyle Bai <kyle.b@inwinstack.com>

WORKDIR /opt
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
	apt-transport-https \
    ca-certificates \
	apache2 \
	curl

COPY gpg.conf /root/.gnupg/gpg.conf
COPY gpg-gen.key /opt/gpg-gen.key
COPY setup.sh /opt/setup.sh

RUN chown root.root /opt/setup.sh && \
    chmod 700 /opt/setup.sh && \
	/opt/setup.sh && \
	rm /opt/setup.sh /opt/gpg-gen.key && \
    apt-get purge -y curl apt-utils apt-transport-https ca-certificates && \
    apt-get autoclean -y && \
    apt-get autoremove -y  && \
    rm -r /var/cache/apt/archives && \
    rm -r /var/lib/apt/lists/*
    
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]

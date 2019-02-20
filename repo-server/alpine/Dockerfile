FROM httpd:2.4-alpine
MAINTAINER Kyle Bai <kyle.b@inwinstack.com>

ENV PKG_HOME_DIR /usr/local/apache2/htdocs
COPY ./download/ /root/download/

RUN apk add --no-cache python ca-certificates && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install -U jinja2 pyyaml && \
    cd /root/download && \
    python downloader.py && \
    cd && \
    pip uninstall -y jinja2 pyyaml && \
    rm -r /usr/lib/python2.7/site-packages/pip /usr/bin/pip && \
    apk del --no-cache python ca-certificates && \
    rm -rf /usr/local/apache2/htdocs/index.html && \
    rm -r /root/.cache /root/download

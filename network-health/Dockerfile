FROM alpine:3.7

RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

COPY entrypoint.sh /bin/entrypoint

ENTRYPOINT ["/bin/entrypoint"]
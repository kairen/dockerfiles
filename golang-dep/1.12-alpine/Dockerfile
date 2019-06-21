FROM golang:1.12-alpine
LABEL maintainer="Kyle Bai <kyle.b@inwinstack.com>"

ENV GOPATH "/go"

RUN apk add --no-cache git make g++ && \
  go get -u github.com/golang/dep/cmd/dep

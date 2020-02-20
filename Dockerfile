FROM golang:1.13.8-alpine3.11

LABEL maintainer="domsn.lee@gmail.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
    && apk add --update curl unzip git


ENV PROTOBUF_REVISION 3.11.4

RUN curl -sLO https://github.com/google/protobuf/releases/download/v${PROTOBUF_REVISION}/protoc-${PROTOBUF_REVISION}-linux-x86_64.zip \
  && unzip protoc-${PROTOBUF_REVISION}-linux-x86_64.zip -d /usr/local \
  && chmod +x /usr/local/bin/protoc \
  && chmod -R 755 /usr/local/include/ \
  && rm protoc-${PROTOBUF_REVISION}-linux-x86_64.zip

RUN go get -u github.com/golang/protobuf/protoc-gen-go 

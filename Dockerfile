FROM golang:1.13.8-alpine3.11

LABEL maintainer="domsn.lee@gmail.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
    && apk add --update curl unzip git autoconf automake build-base libtool


ENV PROTOBUF_REVISION 3.11.4

RUN curl -sLO https://github.com/google/protobuf/releases/download/v${PROTOBUF_REVISION}/protoc-${PROTOBUF_REVISION}-linux-x86_64.zip \
  && unzip protoc-${PROTOBUF_REVISION}-linux-x86_64.zip -d /usr/local \
  && chmod +x /usr/local/bin/protoc \
  && chmod -R 755 /usr/local/include/ \
  && rm protoc-${PROTOBUF_REVISION}-linux-x86_64.zip

ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
RUN ALPINE_GLIBC_BASE_URL="https://github.com/andyshinn/alpine-pkg-glibc/releases/download" \
    && ALPINE_GLIBC_PACKAGE_VERSION="2.30-r0" \
    && ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
    && ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
    && ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
    && apk add --no-cache --virtual=build-dependencies \
      ca-certificates \
      bash \
      tzdata \
    && curl -sL \
        -O "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        -O "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        -O "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
    && apk add --no-cache --allow-untrusted \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
    && /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true \
    && echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh \
    && apk del glibc-i18n \
    && apk del build-dependencies \
    && rm \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"

RUN go get -u github.com/golang/protobuf/protoc-gen-go 

RUN apk --update add \
  bash \
  libstdc++

# Cleaning up
RUN apk del \
  autoconf \
  automake \
  build-base \
  cargo \
  curl \
  git \
  libtool \
  unzip \
  && rm -rf /var/cache/apk/*

RUN mkdir /build

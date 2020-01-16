##ver-2020.01.16.12.39
###############################################################################
# BUILD STAGE

FROM golang:1.13-alpine


RUN set -x && \
    apk --no-cache --update add \
    bash \
    ca-certificates \
    curl \
    git \
    make \
    upx && \
    
    mkdir -p /src && \
    cd /src/ && \
    git clone https://github.com/shadowsocks/go-shadowsocks2.git && \
    cd /src/go-shadowsocks2/ && \ 
    make -j 4 linux && \
    upx --ultra-brute -qq /src/go-shadowsocks2/bin/shadowsocks2-linux

#ENV GO111MODULE on
#ENV GOPROXY https://goproxy.io

#RUN set -x && \
#    apk upgrade && \
#    apk add git upx && \
#    go get github.com/shadowsocks/go-shadowsocks2 && \
#    upx --ultra-brute -qq /go/bin/go-shadowsocks2

###############################################################################
# PACKAGE STAGE

#FROM alpine:3.10 AS dist

#LABEL maintainer="mritd <mritd@linux.com>"

#RUN apk upgrade \
#    && apk add tzdata \
#    && rm -rf /var/cache/apk/*
#
#COPY --from=builder /go/bin/go-shadowsocks2 /usr/bin/shadowsocks
#
#ENTRYPOINT ["shadowsocks"]

FROM scratch

COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0 /src/go-shadowsocks2/bin/shadowsocks2-linux /shadowsocks

VOLUME ["/cfg"]

EXPOSE 7780

ENTRYPOINT ["/shadowsocks"]

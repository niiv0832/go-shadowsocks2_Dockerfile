##ver-2020.04.05.12.20
###############################################################################
# BUILD STAGE
#
FROM golang:1.13-alpine
#
RUN set -x && \
    apk --no-cache --update add \
    bash \
    ca-certificates \
    curl \
    git \
    make \
    upx && \
 #   
    mkdir -p /src && \
    cd /src/ && \
    git clone https://github.com/shadowsocks/go-shadowsocks2.git && \
    cd /src/go-shadowsocks2/ && \ 
    make -j 4 linux && \
    upx --ultra-brute -qq /src/go-shadowsocks2/bin/shadowsocks2-linux

###############################################################################
# PACKAGE STAGE
#
FROM scratch
#
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0 /src/go-shadowsocks2/bin/shadowsocks2-linux /shadowsocks
#
VOLUME ["/cfg"]
#
EXPOSE 7780
#
ENTRYPOINT ["/shadowsocks"]

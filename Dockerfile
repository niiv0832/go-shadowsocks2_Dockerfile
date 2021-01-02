##ver-2021.01.02.16.27
###############################################################################
# BUILD STAGE
#
FROM golang:1.15-alpine
#
RUN set -x && \
    apk --no-cache --update add \
    bash \
    ca-certificates \
    curl \
    git \
    make \
    upx
 #   
RUN    mkdir -p /src
RUN    cd /src/
RUN    git clone https://github.com/shadowsocks/go-shadowsocks2.git 
RUN    cd /src/go-shadowsocks2/ 
RUN    make -j 4 linux
RUN    upx --ultra-brute -qq /src/go-shadowsocks2/bin/shadowsocks2-linux

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

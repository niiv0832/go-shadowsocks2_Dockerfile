# Docker container for fast proxy setup based on `go-shadowsocks2` proxy

## Links:
Link on docker hub: <a href="https://hub.docker.com/r/niiv0832/go-shadowsocks2">niiv0832/go-shadowsocks2</a>

Link on github: <a href="https://www.github.com/niiv0832/go-shadowsocks2_Dockerfile">niiv0832/go-shadowsocks2_Dockerfile</a>

## Usage

```shell
docker run -d --name=ssgo -p `YOU_PORT`:`SERV_CONFIG_PORT` niiv0832/go-shadowsocks2:latest -u -s 'ss://AEAD_CHACHA20_POLY1305:`YOUR_PASSWORD`@:`SERV_CONFIG_PORT`' -verbose
```

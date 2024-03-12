#!/bin/bash

OS_ARGS=""

case "$TARGETPLATFORM" in
  "linux/amd64")
    OS_ARGS="os=linux&arch=amd64"
    ;;

  "linux/arm/v6")
    OS_ARGS="os=linux&arch=arm&arm=6"
    ;;

  "linux/arm/v7")
    OS_ARGS="os=linux&arch=arm&arm=7"
    ;;

  "linux/arm64")
    OS_ARGS="os=linux&arch=arm64"
    ;;

esac


curl -L --connect-timeout 5 --max-time 1800 \
    "https://caddyserver.com/api/download?${OS_ARGS}&p=github.com%2Fcaddy-dns%2Froute53&idempotency=98170178482060" \
    -o /usr/bin/caddy && chmod +x /usr/bin/caddy

# "https://caddyserver.com/api/download?${OS_ARGS}&p=github.com%2Fcaddy-dns%2Fcloudflare&p=github.com%2Fcaddy-dns%2Froute53&p=github.com%2Fcaddy-dns%2Fdigitalocean&p=github.com%2Fcaddy-dns%2Fgoogleclouddns&p=github.com%2Fcaddy-dns%2Fazure&idempotency=65708359145450"
# "https://caddyserver.com/api/download?${OS_ARGS}&p=github.com%2Fcaddy-dns%2Froute53&idempotency=98170178482060" \
# "https://caddyserver.com/api/download?${OS_ARGS}&p=github.com%2Fcaddy-dns%2Fcloudflare&p=github.com%2Fcaddy-dns%2Froute53&p=github.com%2Fcaddy-dns%2Fdigitalocean&p=github.com%2Fkirsch33%2Frealip&p=github.com%2Fcaddy-dns%2Fgoogleclouddns&p=github.com%2Fcaddy-dns%2Fazure&p=github.com%2FWingLim%2Fcaddy-webhook&p=github.com%2Fmohammed90%2Fcaddy-storage-loader&idempotency=42864420815349"

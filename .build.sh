#!/bin/bash

CADDY_ARCH=""

case "$TARGETPLATFORM" in
  "linux/amd64")
    CADDY_ARCH="linux/amd64"
    ;;

  "linux/arm/v6")
    CADDY_ARCH="linux/arm6"
    ;;

  "linux/arm/v7")
    CADDY_ARCH="linux/arm7"
    ;;

  "linux/arm64")
    CADDY_ARCH="linux/arm64"
    ;;

  "linux/386")
    CADDY_ARCH="linux/386"
    ;;
esac


curl \
    --connect-timeout 5 \
    --max-time 600 \
    "https://caddyserver.com/download/${CADDY_ARCH}?plugins=dns,docker,hook.service,http.awslambda,http.cache,http.cgi,http.cors,http.expires,http.filter,http.forwardproxy,http.ipfilter,http.mailout,http.nobots,http.permission,http.ratelimit,http.realip,http.s3browser,http.webdav,net,supervisor,tls.dns.azure,tls.dns.cloudflare,tls.dns.digitalocean,tls.dns.dyn,tls.dns.godaddy,tls.dns.googlecloud,tls.dns.lightsail,tls.dns.linode,tls.dns.ns1,tls.dns.rfc2136,tls.dns.route53&license=personal&telemetry=off" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

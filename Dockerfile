FROM alpine:edge
MAINTAINER David N <david@nedved.com.au>

RUN apk --no-cache add tini git openssh-client \
    && apk --no-cache add --virtual devs tar curl

#Install Caddy Server, and All Middleware
RUN curl "https://caddyserver.com/download/linux/amd64?plugins=dns,docker,dyndns,hook.service,http.authz,http.awslambda,http.cache,http.cgi,http.cors,http.expires,http.filemanager,http.filter,http.forwardproxy,http.geoip,http.git,http.gopkg,http.ipfilter,http.jekyll,http.jwt,http.locale,http.minify,http.nobots,http.proxyprotocol,http.ratelimit,http.realip,http.reauth,http.restic,http.upload,http.webdav,net,tls.dns.azure,tls.dns.cloudflare,tls.dns.digitalocean,tls.dns.dnsimple,tls.dns.googlecloud,tls.dns.route53&license=personal&telemetry=off" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

#Remove build devs
RUN apk del devs

#Copy over a default Caddyfile
COPY ./Caddyfile /etc/Caddyfile

#USER caddy

ENTRYPOINT ["/sbin/tini"]

CMD ["caddy", "-quic", "--conf", "/etc/Caddyfile"]

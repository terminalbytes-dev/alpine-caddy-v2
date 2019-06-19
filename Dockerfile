FROM alpine:edge
MAINTAINER David N <david@nedved.com.au>

RUN apk --no-cache add tini git curl openssh-client \
    && apk --no-cache add --virtual devs tar

#Install Caddy Server, and All Middleware
RUN curl "https://caddyserver.com/download/linux/amd64?plugins=dns,docker,hook.service,http.awslambda,http.cache,http.cgi,http.cors,http.expires,http.filter,http.forwardproxy,http.ipfilter,http.mailout,http.nobots,http.permission,http.ratelimit,http.realip,http.s3browser,http.webdav,net,supervisor,tls.dns.azure,tls.dns.cloudflare,tls.dns.digitalocean,tls.dns.dyn,tls.dns.godaddy,tls.dns.googlecloud,tls.dns.lightsail,tls.dns.linode,tls.dns.ns1,tls.dns.rfc2136,tls.dns.route53&license=personal&telemetry=off" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

#Remove build devs
RUN apk del devs

#Copy over a default Caddyfile
COPY ./Caddyfile /etc/Caddyfile

#USER caddy
ENTRYPOINT ["/sbin/tini"]
CMD ["caddy", "-quic", "--conf", "/etc/Caddyfile"]

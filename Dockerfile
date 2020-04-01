FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine:edge
MAINTAINER David N <david@nedved.com.au>

ARG BUILD_DATE
ARG VERSION
ARG VCS_REF
ARG TARGETPLATFORM

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$VERSION \
  org.label-schema.vcs-ref=$VCS_REF

RUN apk --no-cache add tini git bash curl openssh-client \
    && apk --no-cache add --virtual devs tar

#Install Caddy Server, and All Middleware
COPY ./.build.sh /opt
RUN bash /opt/.build.sh && rm -rf /opt/.build.sh

#Remove build devs
RUN apk del devs

#Copy over a default Caddyfile
COPY ./Caddyfile /etc/Caddyfile

#USER caddy
ENTRYPOINT ["/sbin/tini"]
CMD ["caddy", "-quic", "--conf", "/etc/Caddyfile"]

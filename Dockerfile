FROM caddy:2.8.4-builder AS builder

RUN xcaddy build \
    --with github.com/caddyserver/replace-response

FROM caddy:2.8.4

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY proxy.d /etc/caddy/proxy.d


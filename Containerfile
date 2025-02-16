FROM alpine:latest as builder

RUN apk add musl-dev linux-headers gcc

WORKDIR /app

COPY ndp-proxy.c /app/

RUN gcc -static -w -s -o ndp-proxy ndp-proxy.c


FROM scratch

COPY --from=builder /app/ndp-proxy /ndp-proxy

ENTRYPOINT ["/ndp-proxy"]
CMD ["-v"]

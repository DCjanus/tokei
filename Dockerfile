FROM rust:alpine3.19 as build

RUN apk update && \
    apk add --no-cache git gcc g++ pkgconfig

WORKDIR /src
COPY . /src
RUN cargo build --release

FROM alpine:3.19

WORKDIR /src
COPY --from=build /src/target/release/tokei /usr/local/bin/tokei
ENTRYPOINT ["/usr/local/bin/tokei"]
CMD ["--help"]
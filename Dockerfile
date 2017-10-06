# Static builder for Rust
FROM ekidd/rust-musl-builder AS builder
COPY chess /home/rust/src/chess
COPY client /home/rust/src/client
USER root
RUN chown -R rust:rust /home/rust/src
USER rust
RUN cd client && cargo build --release

# New image from scratch (minimal sized)
FROM scratch
COPY --from=builder /home/rust/src/client/target/x86_64-unknown-linux-musl/release/client /client
ENTRYPOINT ["/client"]
# syntax = docker/dockerfile:experimental
FROM ubuntu:latest as main

# Install dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install musl-tools build-essential clang-11 php8.1-dev gcc -y

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

# Install Toolchains
COPY helper-scripts/install-toolchain.sh .
RUN ./install-toolchain.sh

# Fix for https://github.com/rust-lang/cargo/issues/8719 on armhf
RUN --security=insecure mkdir -p /root/.cargo && chmod 777 /root/.cargo && mount -t tmpfs none /root/.cargo && cargo build --release

ENTRYPOINT [ "tail", "-f", "/dev/null" ]
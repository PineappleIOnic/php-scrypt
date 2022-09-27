# syntax = docker/dockerfile:experimental
FROM ubuntu:latest as main

# Handle Travis Docker keybug
RUN gpg --recv-keys 871920D1991BC93C && gpg --export 871920D1991BC93C| apt-key add -

# Install dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install musl-tools build-essential clang-11 php8.1-dev gcc gcc-aarch64-linux-gnu -y

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /scripts

# Install Toolchains
COPY helper-scripts/install-toolchain.sh .
RUN ./install-toolchain.sh

COPY helper-scripts/build.sh .
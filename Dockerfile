FROM ubuntu:latest as main

# Install dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install musl-tools build-essential clang-11 php8.1-dev gcc -y

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Install Toolchains
RUN /root/.cargo/bin/rustup target add x86_64-unknown-linux-musl

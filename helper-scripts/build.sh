#!/bin/bash

# This script aids with building the extension for different environments

COMPARCH=$(uname -m)

# Clean up a couple conversion errors of uname to rust toolchain
if [ "$COMPARCH" = "arm64" ]
then
    COMPARCH=aarch64
fi

if [ "$COMPARCH" = "armv7l" ]
then
    echo "Building PHP-Scrypt for armv7"
    cargo build --release --target=armv7-unknown-linux-gnueabihf
    cargo build --release --target=armv7-unknown-linux-musleabihf
else
    echo "Building PHP-Scrypt for $COMPARCH"
    cargo build --release --target=$COMPARCH-unknown-linux-gnu
    cargo build --release --target=$COMPARCH-unknown-linux-musl
fi
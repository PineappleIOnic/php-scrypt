#!/bin/bash

# This script aids with installing the correct rust toolchains for GNU and musl environments

COMPARCH=$(uname -m)

# Clean up a couple conversion errors of uname to rust toolchain
if [ "$COMPARCH" = "arm64" ];
then
    COMPARCH=aarch64
fi

if [ "$COMPARCH" = "armv7l" ]
then
    echo "Installing armv7 toolchain"
    rustup target add armv7-unknown-linux-gnueabihf
    rustup target add armv7-unknown-linux-musleabihf
else
    echo "Installing $COMPARCH toolchain"
    rustup target add $COMPARCH-unknown-linux-gnu
    rustup target add $COMPARCH-unknown-linux-musl
fi
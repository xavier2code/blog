+++
title = "A Shell Script for Backing Up MinIO Buckets"
date = "2025-02-21"
draft = false

[taxonomies]
tags=["documentation", "shell"]

[extra]
comment = true
+++

> Usage: ./your_shell.sh [your minio name] <backup location>

```bash
#!/bin/bash

# MIT License
#
# Copyright (c) 2025 xavier2code
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Ensure the 'mc' command is available
if ! command -v mc &> /dev/null
then
    echo "MinIO Client (mc) is not installed. Installing mc..."
    # Detect system architecture
    ARCH=$(uname -m)
    if [ "$ARCH" == "x86_64" ]; then
      curl https://dl.min.io/client/mc/release/linux-amd64/mc \
        -o mc
    elif [ "$ARCH" == "aarch64" ]; then
      curl https://dl.min.io/client/mc/release/linux-arm64/mc \
        -o mc
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi
    chmod +x mc
    sudo mv mc /usr/local/bin/
    echo "MinIO Client (mc) installed successfully."
fi

# Check the number of arguments provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 [source_bucket] destination_bucket"
    exit 1
elif [ "$#" -eq 1 ]; then
    # Set default source bucket if only one argument is provided
    SOURCE_BUCKET="single_minio"
    DESTINATION_BUCKET=$1
else
    # Assign the provided arguments to variables
    SOURCE_BUCKET=$1
    DESTINATION_BUCKET=$2
fi

# Copy the bucket from source to destination and check the exit status directly
echo "Starting to copy bucket: $SOURCE_BUCKET -> $DESTINATION_BUCKET"
if mc cp --recursive "$SOURCE_BUCKET" "$DESTINATION_BUCKET"; then
    echo "Bucket copy completed successfully: $SOURCE_BUCKET -> $DESTINATION_BUCKET"
    echo
else
    echo "Bucket copy failed"
    echo
    exit 1
fi
```

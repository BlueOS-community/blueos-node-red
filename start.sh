#!/bin/bash

# turn on bash's job control
set -m

echo "Starting nginx.."
nginx &
echo "Starting openvscode-server.."

./entrypoint.sh
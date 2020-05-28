#!/bin/bash

# This script is supposed to test in a dockerized environment
# if the installation of sway would work in a new fedora install

docker build --network=host --no-cache -t install_sway:latest .
docker run --network=host install_sway:latest


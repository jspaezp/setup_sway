#!/bin/bash


# Makes running the script print what is being run and stops running after
# the first error
set -x
set -e

dnf copr enable alebastr/waybar -y
dnf install waybar -y
dnf install sway waybar kitty -y


from fedora:latest

RUN dnf install git zsh -y
RUN git clone https://github.com/jspaezp/setup_sway
WORKDIR setup_sway

RUN dnf install 'dnf-command(copr)' -y

ENTRYPOINT /usr/bin/zsh ./install_sway.zsh


from fedora:latest

RUN dnf install git -y
RUN git clone https://github.com/jspaezp/setup_sway
WORKDIR setup_sway

RUN dnf install 'dnf-command(copr)' -y

ENTRYPOINT /bin/bash ./install_sway.bash

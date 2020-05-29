

# Setting up sway

## Intro and motivation

## Scope

Provides the a script that installs all required dependencies (as it is right
now in fedora) to have a functioning and aesthetically pleasing installation
of sway. Also makes a backup of the current dotfiles that conflict with the
install in `~/.config/....`.

The new dotfiles are actually simlinked to the cloned repostory (just to make)
it easier to update the changes in the repo, reflecting changes done in the 
system.

## Usage

```

git clone https://github.com/jspaezp/setup_sway
cd setup_sway

## on newer fedora installs, this is required
# dnf install 'dnf-command(copr)'

sudo zsh install_sway.bash

```

## Testing

A dockerized container  has been generated to test that the script actually 
runs, right now it does not test that it does it correctly but it does the
check that it completes.

Note that this tests the version on the github repository, not the local one

```
git clone https://github.com/jspaezp/setup_sway
cd setup_sway/docker
zsh build_docker.zsh
```

## Author

- J. Sebastian Paez

### Known issues

1. The blurry screenshot updates when running the script on a temrinal but
   not when it runs via swaylock automatically

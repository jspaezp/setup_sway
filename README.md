

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

git clone ...
cd ...
sudo bash install_sway.bash

```

## Author

- J. Sebastian Paez
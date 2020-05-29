#!/usr/bin/zsh

# "Calculating" the global variables
foldername=$(date +%Y%m%d%_H%M)
backupname=~/.config/bkp_${foldername}

# Default options for the options
run=''
dry=''

# Usage instructions that are printed when no arguments are passed
print_usage() {
  printf "Run this script as 'zsh install_sway.zsh -r' \n"
  printf "or 'zsh install_sway.zsh -d' for a dry run \n"
}

# Utility function to add white lines (provided as an argument)
space () { for i in {1..$1} ; do echo "" ; done } 

# Utility Function that adds a large header
# style print of the first argument passed
# the second argument should be an integer with
# the width of the indentation (defaults to 3)
section_header () {  
  level=${2:=3}

  for i in {1.."${level}"} ; do
    # This makes a line, the width of the terminal
    for c in {1..$COLUMNS} ; do echo -n "=" ; done
    echo -n "\n"
  done

  for c in {1..$(( $COLUMNS / 3 ))} ; do 
    # Makes space to a third of the size of the terminal
    echo -n " " 
  done
  printf "${1}\n"

  for i in {1.."${level}"} ; do
    for c in {1..$COLUMNS} ; do echo -n "=" ; done
    echo -n "\n"
  done
  printf "\n"
}

# Function that carries out the installations
installs () {
  # Adds the repository required for waybar
  sudo dnf copr enable alebastr/waybar -y
  sudo dnf install waybar -y
  sudo dnf install sway waybar kitty -y
  sudo dnf install neofetch -y

  sudo dnf install swaylock pavucontrol fontawesome-fonts pcmanfm wofi -y
}

# Function that backs up the config files
backup () {
  mkdir -p $backupname

  for config_subdir in $(ls ./config/ ); do
    configdir="${HOME}"/.config/"${config_subdir}"
    if [ -d "${configdir}" ]; then
      mv --verbose "${configdir}" "${backupname}/."
    fi
  done
}

# Simlinks the config directories to the user's ~/.config
simlink () {
  for i in $(ls ./config/ ) ; do
    ln --verbose -s "${PWD}"/config/"${i}" ~/.config/.
  done

  mkdir -p "${HOME}/Pictures"
  ln --verbose -s "${PWD}"/assets/BW_ROSIE2.jpg "${HOME}/."
}

# Prints the head of the files in the simlinked config directories
# as well as the versions of the packages installed
# ends by calling neofetch
print_results () {
  for config_subdir in $(ls ./config/ ) ; do
    section_header "Config files in ${config_subdir}" 1
    head --verbose --lines 5 ~/.config/"${config_subdir}"/*
  done

  space 2

  section_header "Versions of the packages installed" 1

  echo "wofi version: $(wofi --version)"
  # For some reason pcmanfm does not have a --version argument
  echo "pcmanfm installed in: $(which pcmanfm)"
  pavucontrol --version
  # for some reason this syntax is needed because otherwise it
  # exits the script
  echo $(neofetch --version) 

  space 2

  sway --version
  waybar --version
  kitty --version

  space 2

  section_header "Neofetch" 1
  neofetch
}

# Makes running the script print what is being run
# set -x
# And stops running after the first error
set -e

# Parses the options, if it passes the -d or -r options, sets
# the "dry" or "run" variables to true respectively
while getopts 'rd' flag; do
  case "${flag}" in
    r) run='true' ;;
    d) dry='true' ;;
    *) print_usage
       exit 1 ;;
  esac
done

# If neither the -d or -r flags are passed, prints how to use it
# and exits the program
if [[ ! $run && ! $dry ]] ; then print_usage && exit 1 ; fi
if [[ $run && $dry ]] ; then 
  printf "Please pass only one of -d (dry) or -r (run)"
  exit 1
fi

section_header 'Installation' 3

# If its not a dry run, install stuff
if [[ $run && ! $dry ]] ; then
  installs 
else
  printf "Dry run, not installing anything"
fi
space 5

section_header 'Backup' 3
if [[ $run && !$dry ]] ; then backup ; fi
space 5

section_header 'Simlink' 3
if [[ $run && !$dry ]] ; then simlink ; fi
space 5

section_header 'Results Printing' 3
print_results
space 3

# Remove the temporary folder if it is empty, else let the user know where it is
if [[ $run && !$dry ]] ; then
  if [ -z "$(ls -A ${backupname} )" ]; then
    rm -r "${backupname}"
  else
    echo "Saved the former conflicting dotfiles in: "
    echo "----->>>>>>>>" "${backupname}"
  fi
fi

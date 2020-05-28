#!/bin/bash


# Makes running the script print what is being run and stops running after
# the first error
set -x
set -e

dnf copr enable alebastr/waybar -y
dnf install waybar -y
dnf install sway waybar kitty -y

foldername=$(date +%Y%m%d%_H%M)
backupname="~/.config/bkp_${foldername}"
mkdir -p "${backupname}"


for configdir in ~/.config/sway ~/.config/kitty ~/.config/waybar; do
  if [ -d "${configdir}"]; then
    mv -v "${configdir}" "${backupname}/."
  fi
done

# Remove the temporary folder if it is empty, else let the user know where it is
if [ -z "$(ls -A ${backupname} )" ]; then
  rm -r "${backupname}"
else
  echo "Saved the former conflicting dotfiles in: "
  echo "----->>>>>>>>" "${backupname}"
fi

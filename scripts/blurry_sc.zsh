#!/usr/bin/zsh

# Adapted from https://www.reddit.com/r/swaywm/comments/g5g2n8/swaylock_script_to_blur_the_screen_and_add_a_lock/
grim /tmp/screen.png -e 'mv $f /tmp/screen.png' # for security, the file erases itself
# convert /tmp/screen.png -scale 10% -scale 200% /tmp/screen.png # blured image, no original file
convert /tmp/screen.png -blur 0x10 /tmp/screen.png # blured image, no original file

echo "/tmp/screen.png"



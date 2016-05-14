#!/bin/bash

# Our config file for the 8bitdo controller
CFG_USB=8Bitdo-NES30-Pro-GamePad-Bluetooth-Mode.cfg
CFG_BT=8Bitdo-NES30-Pro-GamePad-USB-Mode.cfg

# Target path for the file
CONFIG_TARGET=/opt/retropie/configs/all/retroarch-joypads

# We are adding a new rules file force the SDL to see the 8bitdo as a joypad.
# Naming the rules file 10-local.rules to get it to load earlier then the other rules


if [[ ! -f /etc/udev/rules.d/10-local.rules ]]; then 
echo "Creating rule /etc/udev/rules.d/10-local.rules"

cat >> /etc/udev/rules.d/10-local.rules <<EOL
# Add more 8bitdo Joystick ID's to this config file

# Add the ID_INPUT_JOYSTICK attribute to the device so SDL picks up on it
SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SNES30 GamePad Joystick", MODE="0666", ENV{ID_INPUT_JOYSTICK}="1"

EOL
fi

# Time to copy over a known working 8bitdo config file!

# Copy the original config file if exists 
if [ -f $CONFIG_TARGET/$CFG_USB ]
  then mv $CONFIG_TARGET/$CFG_USB $CONFIG_TARGET/$CFG_USB.$(date +%M%H%S).bak
fi

if [ -f $CONFIG_TARGET/$CFG_BT ]
  then mv $CONFIG_TARGET/$CFG_BT $CONFIG_TARGET/$CFG_BT.$(date +%M%H%S).bak
fi

# Copy the config file into the target directory for retroarch
cp configs/$CFG_USB $CONFIG_TARGET/$CFG_USB
cp configs/$CFG_BT $CONFIG_TARGET/$CFG_BT


##################################################################################################
# hoobs-deconz-phoscon                                                                           #
# Copyright (C) 2020 HOOBS                                                                       #
#                                                                                                #
# This program is free software: you can redistribute it and/or modify                           #
# it under the terms of the GNU General Public License as published by                           #
# the Free Software Foundation, either version 3 of the License, or                              #
# (at your option) any later version.                                                            #
#                                                                                                #
# This program is distributed in the hope that it will be useful,                                #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                                 #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                  #
# GNU General Public License for more details.                                                   #
#                                                                                                #
# You should have received a copy of the GNU General Public License                              #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.                          #
##################################################################################################


#!/bin/bash
echo " "
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "This will install DeConz and Phoscon for HOOBS 3"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "After the installation is completed the Device performs an"
echo "reboot and you can access Phoscon and HOOBS as following:"
echo "----------------------------------------------------------------"
echo "Phoscon Interface is reachable at hoobs.local"
echo "HOOBS   Interface is reachable at hoobs.local:8080"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "Enable Raspberry Serial Port.."
sudo raspi-config nonint do_serial 1
cat > /boot/config.txt <<EOL
# For more options and information see
# http://rpf.io/configtxt
# Some settings may impact device functionality. See link above for details

# uncomment if you get no picture on HDMI for a default "safe" mode
#hdmi_safe=1

# uncomment this if your display has a black border of unused pixels visible
# and your display can output without overscan
disable_overscan=1
disable_splash=1

# uncomment the following to adjust overscan. Use positive numbers if console
# goes off screen, and negative if there is too much border
#overscan_left=16
#overscan_right=16
#overscan_top=16
#overscan_bottom=16

# uncomment to force a HDMI mode rather than DVI. This can make audio work in
# DMT (computer monitor) modes
#hdmi_drive=2

# uncomment to increase signal to HDMI, if you have interference, blanking, or
# no display
#config_hdmi_boost=4

# uncomment for composite PAL
#sdtv_mode=2

#uncomment to overclock the arm. 700 MHz is the default.
#arm_freq=800

# Uncomment some or all of these to enable the optional hardware interfaces
#dtparam=i2c_arm=on
#dtparam=i2s=on
#dtparam=spi=on

# Uncomment this to enable infrared communication.
#dtoverlay=gpio-ir,gpio_pin=17
#dtoverlay=gpio-ir-tx,gpio_pin=18

# Additional overlays and parameters are documented /boot/overlays/README

# Enable audio (loads snd_bcm2835)
dtparam=audio=on

# Remove under vold overlay on screen
avoid_warnings=1

[pi4]
# Enable DRM VC4 V3D driver on top of the dispmanx display stack
dtoverlay=vc4-fkms-v3d
max_framebuffers=2

[all]
#dtoverlay=vc4-fkms-v3d

avoid_warnings=1

[pi4]
# Enable DRM VC4 V3D driver on top of the dispmanx display stack
dtoverlay=vc4-fkms-v3d
max_framebuffers=2

[all]
#dtoverlay=vc4-fkms-v3d
enable_uart=1
EOL
echo "Raspberry Serial Port enabled"
echo "----------------------------------------------------------------"
echo "Get Phoscon Public Key....."
wget -O - http://phoscon.de/apt/deconz.pub.key | \
sudo apt-key add -
echo "Installing....."
sudo sh -c "echo 'deb http://phoscon.de/apt/deconz \
            $(lsb_release -cs)-beta main' > \
            /etc/apt/sources.list.d/deconz.list"
sudo apt update
sudo apt install -f --yes
sudo apt install deconz
echo "DeConz & Phoscon installed."
echo "----------------------------------------------------------------"
echo "Installing Wiring Pi (for Rpi4B)....."
cd /tmp
wget https://project-downloads.drogon.net/wiringpi-latest.deb
sudo dpkg -i wiringpi-latest.deb
echo "Wiring Pi (for Rpi4B) installed"
echo "----------------------------------------------------------------"
echo "Updating DeConz"
wget http://deconz.dresden-elektronik.de/raspbian/stable/deconz-latest.deb
sudo dpkg -i deconz-latest.deb
echo "DeConz updated"
echo "----------------------------------------------------------------"
echo "Disable nginx for HOOBS...."
sudo systemctl stop nginx
sudo systemctl disable nginx.service
echo "Nginx for HOOBS disabled"
echo "----------------------------------------------------------------"
echo "After the installation is completed the Device performs an"
echo "reboot and you can access Phoscon and HOOBS as following:"
echo "----------------------------------------------------------------"
echo "Phoscon Interface is reachable at hoobs.local"
echo "HOOBS   Interface is reachable at hoobs.local:8080"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "Rebooting now in 10 Seconds.........."
echo "----------------------------------------------------------------"
sudo reboot
echo "----------------------------------------------------------------"
echo "Enter now URL: hoobs.local to get to the Phoscon interface"
echo "----------------------------------------------------------------"


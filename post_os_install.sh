#!/bin/bash
################################################################################
# Author: Carlos A. García
#-------------------------------------------------------------------------------
# This script will install system packages and dependencies.
#-------------------------------------------------------------------------------
# Make a new file:
# sudo nano script-install.sh
# Place this content in it and then make the file executable:
# sudo chmod +x script-install.sh
# Execute the script to install:
# ./script-install
################################################################################

##fixed parameters

GUI="gnome"
IS_LAPTOP="True"
# OE_VERSION="11.0"
# OE_SUPERADMIN="admin"
# OE_CONFIG="${OE_USER}-server"

##
###  WKHTMLTOPDF download links
# WKHTMLTOX_X64=https://downloads.wkhtmltopdf.org/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
# WKHTMLTOX_X32=https://downloads.wkhtmltopdf.org/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-i386.deb

#--------------------------------------------------
# Update System
#--------------------------------------------------
echo -e "\n---- Update System ----"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install dist-upgrade -y

#--------------------------------------------------
# Install Tools and Dependencies
#--------------------------------------------------
echo -e "\n---- Install tools packages ----"
sudo apt-get install software-properties-common -y
sudo apt install build-essential -y
#sudo add-apt-repository universe -y

#--------------------------------------------------
# GUI
#--------------------------------------------------
if [ $GUI = "gnome" ]; then
  #--------------------------------------------------
  # Gnome
  #--------------------------------------------------
  echo -e "\n---- Installing Gnome extensions! ----"
  sudo apt-get install gnome-tweaks -y
  sudo apt install gnome-shell-extensions -y
else
  echo "Skipping Gnome extensions!"
fi

#--------------------------------------------------
# APPs
#--------------------------------------------------
echo -e "\n==== Installing APPs ===="
#--------------------------------------------------
# Adding PPA repositories
#--------------------------------------------------
echo -e "\n--- Adding PPA repositories!"
if [ $IS_LAPTOP = "True" ]; then
    # Install TPL for battery optimizations!
    sudo add-apt-repository ppa:linrunner/tlp -y
    sudo add-apt-repository ppa:linuxuprising/apps -y
fi
sudo add-apt-repository ppa:agornostal/ulauncher -y
# .
echo -e "\n--- Reloading packages list!"
sudo apt-get update
#--------------------------------------------------
# Installing Tools
#--------------------------------------------------
if [ $IS_LAPTOP = "True" ]; then
    echo -e "\n--- Installing TPL for battery optimizations!"
    sudo apt-get install tlp tlp-rdw tlpui -y
    # ThinkPads require an additional command:
    #sudo apt-get install tp-smapi-dkms acpi-call-dkms
fi
echo -e "\n--- Installing Sensors!"
sudo apt-get install lm-sensors -y
#--------------------------------------------------
# Installing Apps
#--------------------------------------------------
echo -e "\n--- Installing Ulauncher!"
sudo apt-get install ulauncher -y
echo -e "\n--- Installing Filezilla!"
sudo apt-get install filezilla -y
sudo apt-get install hardinfo -y

#--------------------------------------------------
# Installing Snap Apps
#--------------------------------------------------
echo -e "\n==== Installing Snap Apps ===="
sudo snap install indicator-sensors
sudo snap install skype -y
sudo snap install code -y
sudo snap install pycharm-community -y

echo "-----------------------------------------------------------"
echo "Done! The system is updated and ready!"
echo "-----------------------------------------------------------"

#!/Bin/bash

#INSTALL SCRIPT FOR UBUNTU 16.10

#Define our package arrays
util_packages=("htop" "screen" "unity-tweak-tool")
main_packages=("atom" "")
extra_packages=("" "")

#Let's go user's home dir
cd ~

#Let's update first
echo "Updating pre-installed packages";
sudo apt-get update -qq

echo "Installing utilities:";
echo "${util_packages}";
sudo apt-get install -yy ${util_packages[@]}

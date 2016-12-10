#!/Bin/bash

#INSTALL SCRIPT FOR UBUNTU 16.10

#Define our package arrays
util_packages=("htop" "screen" "unity-tweak-tool" "gdebi") #gdebi for installing debian packages on terminal
main_packages=("atom" "")
extra_packages=("" "")

#Let's go user's home dir
cd ~

#Let's update first
echo "Updating pre-installed packages";
sudo apt-get update -qq # -qq for no output

echo "Installing utilities:";
echo "${util_packages[@]}";
sudo apt-get install -yy ${util_packages[@]} # -yy install w/o asking ANYTHING, goes for defaults in case of problems

# Example: installing Google Chrome
#variables
gchromeURL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
gchromeFile=google-chrome-stable_current_amd64.deb
#Action
cd ~/Downloads
wget ${gchromeURL}
sudo gdebi -n ${gchromeFile} # -n for installing w/o prompts
rm -f ${gchromeFile}
cd ~ #Back to home

#Example: installing Spotify
sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free"
sudo apt-key adv --keyserver -y keyserver.ubuntu.com --recv-keys D2C19886
sudo apt-get update -qq
sudo apt-get install spotify-client


#!/Bin/bash
#Ubuntu installation script by Eurybus
#INSTALL SCRIPT FOR UBUNTU 16.10

#Modeled after https://www.youtube.com/watch?v=hBbvuiLoemk
#Original by: https://www.youtube.com/channel/UCTfabOKD7Yty6sDF4POBVqA

#Define our package arrays
util_packages=("htop" "screen" "unity-tweak-tool" "gdebi") #gdebi for installing debian packages on terminal
main_packages=("atom" "git")
extra_packages=("" "")

#Let's go user's home dir
cd ~

#Let's update first
echo "Updating pre-installed packages";
sudo apt-get update -qq # -qq for no output

echo "Installing utilities:"
echo "${util_packages[@]}"
sudo apt-get install -yy ${util_packages[@]} # -yy install w/o asking ANYTHING, goes for defaults in case of problems
echo "Installing main packages:"
echo "${main_packages[@]}"
sudo apt-get install -yy ${main_packages[@]}

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
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2C19886 #Lets grab the public key for Spotify repository
sudo apt-get update -qq
sudo apt-get install spotify-client

#System tweaks
sudo apt-get remove -yy gstreamer1.0-fluendo-mp3 #Removing this for better audio quality
#We are about to mod system config file. Time to backup
sudo cp /etc/sysctl.conf /etc/sysctl.conf.backup
% echo "vm.swappines = 10" |sudo tee -a /etc/sysctl.conf # We instruct system to use 90% of RAM before using swap space
                                                           # This is useful for when you want to run virtual computers

#Installation done
echo "End of script. Please reboot the computer"

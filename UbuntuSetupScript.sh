#!/Bin/bash
#Ubuntu installation script by Eurybus
#INSTALL SCRIPT FOR UBUNTU 16.10

#Modeled after https://www.youtube.com/watch?v=hBbvuiLoemk
#Original by: https://www.youtube.com/channel/UCTfabOKD7Yty6sDF4POBVqA

#Define our package arrays
util_packages=("htop" "screen" "unity-tweak-tool" "gdebi" "git" "tmux") #gdebi for installing debian packages on terminal
extra_packages=("numix-gtk-theme" "numix-icon-theme" "unity-tweak-tool")
main_packages=("openjdk-8-jdk" "unzip" "keepass2" "owncloud-client")

#Other variables
install_utils="n" # n or y
install_main="n"
install_extra="n"

install_atom="n"
install_spotity="n"
install_chrome="n"
install_intellij="n"
install_andrStd="n"
install_qt="n"
perform_tweaks="n"

#Let's go user's home dir
cd ~

#Let's update first
echo "Updating pre-installed packages"
sudo apt-get update -qq # -qq for no output

echo "Do you want to install utilities?"
select yn in "y" "n"; do
  case %yn in
  y ) %install_utils="y"
  n ) %install_utils="n"
  esac
done

echo "Do you want to install main packages?"
select yn in "y" "n"; do
  case %yn in
  y ) %install_main="y"
  n ) %install_main="n"
  esac
done

echo "Do you want to install main Atom text editor?"
select yn in "y" "n"; do
  case %yn in
  y ) %install_atom="y"
  n ) %install_atom="n"
  esac
done

if [ %install_utils -eq "y"]
then
	echo "Installing utilities:"
	echo "${util_packages[@]}"
	sudo apt-get install -yy ${util_packages[@]} # -yy install w/o asking ANYTHING, goes for defaults in case of problems
fi

if [ %install_main -eq "y"]
then
	echo "Installing main packages:"
	echo "${main_packages[@]}"
	sudo apt-get install -yy ${main_packages[@]}
fi

if [ %install_atom -eq "y"]
then
	#Installing Atom Text editor
	#Variables
	atomURL="https://github.com/atom/atom/releases/download/v1.13.1/atom-amd64.deb"
	atomFile=atom-amd64.deb
	cd ~/Downloads
	wget ${atomURL}
	sudo gdebi -n ${atomFile}
	rm -f ${atomFile}
	cd ~
fi


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
#sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free"
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2C19886 #Lets grab the public key for Spotify repository
#sudo apt-get update -qq
#sudo apt-get install spotify-client

#Installing Android studio
#Variables
androidStudioUrl="https://dl.google.com/dl/android/studio/ide-zips/2.2.3.0/android-studio-ide-145.3537739-linux.zip"
androidStudioFile=android-studio-ide-145.3537739-linux.zip
cd ~/Downloads
wget ${androidStudioUrl}
unzip ${androidStudioFile}
mkdir -p ../Dev/Apps/
mv android-studio ../Dev/Apps/Android-Studio

#Installing IntelliJ
cd ~/Downloads
intelliJURL="https://download.jetbrains.com/idea/ideaIC-2016.3.1.tar.gz"
intelliJtar=ideaIC-2016.3.1.tar.gz
wget ${intelliJURL}
mkdir -p ~/Dev/Apps/
mv ${intelliJURL} ~/Dev/Apps/
tar -zxvf ${intelliJtar}

#Installing Qt as instructed here: 
#https://webcache.googleusercontent.com/search?q=cache:cZknWO3kw2YJ:https://wiki.qt.io/Install_Qt_5_on_Ubuntu+&cd=1&hl=en&ct=clnk&gl=fi&client=firefox-b
cd ~/Downloads
wget "http://download.qt.io/official_releases/qt/5.8/5.8.0/qt-opensource-linux-x64-5.8.0.run"
sudo chmod +x *.run
sudo sh qt-opensource-linux-x64-5.8.0.run
dev_packages=("build-essential" "libfontconfig1" "mesa-common-dev" "libglu1-mesa-dev")
sudo apt-get install -yy ${dev_packages[@]}

#CHMOD changes
cd ~/
sudo chown -R $USER:$USER Dev

#System tweaks
sudo apt-get remove -yy gstreamer1.0-fluendo-mp3 #Removing this for better audio quality
#We are about to mod system config file. Time to backup
sudo cp /etc/sysctl.conf /etc/sysctl.conf.backup
% echo "vm.swappines = 10" |sudo tee -a /etc/sysctl.conf # We instruct system to use 90% of RAM before using swap space
                                                           # This is useful for when you want to run virtual computers

#Installation done
echo "End of script. Please reboot the computer"

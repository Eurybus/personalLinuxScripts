#!/bin/bash
#Made by Eurybus 10.12.2016
#Setting up needed variables
PreInstallPackagesFile=OriginalPackages.txt
#Add packages you want to install to array below like so packages=("package1" "package2")
packages=("atom" "wine" "wine-mono" "wireshark-gtk" "nmap" "android-tools" "numix-themes" "nemiver" "vlc")
#Defining functions
#Source for three functions below: http://stackoverflow.com/a/27587157
#By http://stackoverflow.com/users/4257217/greenraccoon23
#
_isInstalled() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# `_install <pkg>`
_install() {
    package="$1";

    # If the package IS installed:
    if [[ $(_isInstalled "${package}") == 0 ]]; then
        echo "${package} is already installed.";
        return;
    fi;

    # If the package is NOT installed:
    if [[ $(_isInstalled "${package}") == 1 ]]; then
        yes |sudo pacman -S "${package}"; # piped in yes to answer all questions with 'yes' | Eurybus
    fi;
}

# `_installMany <pkg1> <pkg2> ...`
# Works the same as `_install` above,
#     but you can pass more than one package to this one.
_installMany() {
    # The packages that are not installed will be added to this array.
    toInstall=();

    for pkg; do
        # If the package IS installed, skip it.
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo "${pkg} is already installed.";
            continue;
        fi;

        #Otherwise, add it to the list of packages to install.
        toInstall+=("${pkg}");
    done;

    # If no packages were added to the "${toInstall[@]}" array,
    #     don't do anything and stop this function.
    if [[ "${toInstall[@]}" == "" ]] ; then
        echo "All packages are already installed.";
        return;
    fi;

    # Otherwise, install all the packages that have been added to the 
"${toInstall[@]}" array.
    printf "Packages not installed:\n%s\n" "${toInstall[@]}";
    yes |sudo pacman -S "${toInstall[@]}"; # piped in yes to answer all questions with 'yes' | Eurybus
}

#Examples
#package="lshw";
#_install "${package}";
#
#packages=("lshw" "inkscape");
#_installMany "${packages[@]}";
##Or,
#_installMany "lshw" "inkscape"


#Start of script
echo "Automated software installation script.";
echo "listing current packages and dumping to file $PreInstallPackagesFile";

expac -S -H M '%k\t%n' > $PreInstallPackagesFile

echo "Backing up pacman_database in case of errors";
sudo tar -cjf pacman_database.tar.bz2 /var/lib/pacman/local 
echo "use command 'tar -xvjf pacman_database.tar.bz2' to extract it into Linux root (/)";

echo "Upgrading packages";
#Pacman has no option to assume yes, so we have to pipe in yes command to it
yes |sudo pacman -Syu 

echo "Installing following packages: ${packages[@]}";
_installMany "${packages[@]}";

echo "End of script";
#Now to visual side of things
#This is better to do by hand, really




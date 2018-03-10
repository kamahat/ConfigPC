#!/bin/bash

## == nettoyage
sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove

## == debut
sudo apt-get install vim terminator git htop curl aptitude

echo 'UUID=45e71c47-a88f-4493-8b1a-e5bfcf7562b0 /home/yoyo/eMule           reiserfs    defaults        0       2' >>/etc/fstab

# == reseau
sudo apt-get install wireshark zenmap sipcalc ethtool net-tools

# === geany
sudo apt-get install geany geany-plugin*
mkdir -p ~/Build/Git/
mkdir -p ~/Build/Git/geany & cd ~/Build/Git/geany
git clone https://github.com/geany/geany-themes.git
mkdir -p ~/.config/geany/colorschemes/
mv  ~/Build/Git/geany/geany-themes/colorschemes ~/.config/geany/

# ==== Chrome 

sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
 wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
 sudo apt-get update
 sudo apt-get install google-chrome-stable

## === virtualbox
sudo apt-get -y install gcc make linux-headers-$(uname -r) dkms
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >/etc/apt/sources.list.d/virtualbox.list'
sudo apt-get update
sudo apt-get install virtualbox-5.2
# verif
VBoxManage -v
# extension pack 
curl -O http://download.virtualbox.org/virtualbox/5.2.0/Oracle_VM_VirtualBox_Extension_Pack-5.2.0-120293.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.0-120293.vbox-extpack
# verif extension 
VBoxManage list extpacks

##== drivers Nvidia
# https://charlienewey.github.io/getting-nvidia-drivers-working-on-ubuntu-17-10/
sudo add-apt-repository ppa:graphics-drivers/ppa 
sudo apt-get update 
ubuntu-drivers devices  
#choisir la version, actuellement = 390
sudo apt-get install nvidia-(numéro du pilote) 

##=== Gnome EncFS Manager 
 sudo apt-get install encfs 
 mkdir -p ~/Encfs/Prive
 sudo add-apt-repository ppa:gencfsm/ppa && sudo apt-get update
 sudo apt-get install gnome-shell-extension-appindicator gnome-encfs-manager 
 gnome-encfs-manager set_pref force_traysystem="appindicator" && gnome-encfs-manager --replace
 
 ##=== Megasync
 https://mega.co.nz/#sync!linux
 
 ## === video player : MVP
 sudo add-apt-repository ppa:mc3man/mpv-tests
sudo apt-get update
sudo apt-get install -y mpv

## === video player : vlc
sudo apt-get install -y vlc
 
## === dropbox
https://www.dropbox.com/install-linux

sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo apt-get -y update

## === keepass2
sudo apt-get install -y mono-complete 
sudo apt-get install -y keepass2 keepass2-doc mono-dmcs xdotool
# ajuste la version
 https://sourceforge.net/projects/keepass/files/Translations%202.x/2.36/KeePass-2.36-French-f.zip/download
sudo unzip -d ~/.config/KeePass/ KeePass-2.36-French-f.zip
# plugin
https://keepass.info/extensions/v2/databasebackup/DataBaseBackup-2.0.8.6.zip
sudo unzip -d /usr/lib/keepass2/Plugins DataBaseBackup-2.0.8.6.zip
#
wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp.plgx
sudo mv KeePassHttp.plgx /usr/lib/keepass2/Plugins
sudo chmod 644 /usr/lib/keepass2/Plugins/KeePassHttp.plgx 
## === freecad
sudo add-apt-repository ppa:freecad-maintainers/freecad-daily && sudo apt-get update
sudo apt-get install freecad-daily freecad-daily-doc  
## === Telegram
sudo add-apt-repository -y ppa:atareao/telegram && sudo apt-get update && sudo apt-get install -y telegram
# a ajouter au demarrage
## == Hangout 
# telecahrger : https://www.google.com/tools/dlpage/hangoutplugin/download.html?platform=linux_ubuntu_x86_64
sudo snap install yakyak
# pour supprimer si besoin : sudo snap remove yakyak
## == mega
https://mega.nz/linux/MEGAsync/xUbuntu_17.10/amd64/megasync-xUbuntu_17.10_amd64.deb

## == GIT
sudo apt-get install git
GITUSERNAME="kamahat" && git config --global user.name $GITUSERNAME
GITEMAIL="kamahat@hotmail.com" && git config --global user.email $GITEMAIL
# creation du projet sur GIT ConfigPC
git init ConfigPC && cd ConfigPC
# ajout local
git remote add origin https://github.com/kamahat/ConfigPC.git

#!/bin/bash
##
## GIT ecriture : 
##		git commit -m "Fin"
##		git push -u origin master
##

## == nettoyage
sudo apt-get update && sudo apt-get -y dist-upgrade && sudo apt-get autoremove


## 18.10 bug

sudo apt install -y gnome-system-monitor
## == debut
sudo apt-get install -y vim terminator git htop curl aptitude screen openssh-server gparted remmina net-tools
sudo apt-get install debian-archive-keyring

echo 'UUID=45e71c47-a88f-4493-8b1a-e5bfcf7562b0 /home/yoyo/eMule           reiserfs    defaults        0       2' >>/etc/fstab

sudo ubuntu-drivers autoinstall
## pour cups : desactive et reactive
sudo apt-get install apparmor-utils
sudo aa-complain cupsd
#sudo aa-enforce cupsd.

# ====================
# AutoFS

# CIFS
sudo apt-get install -y smbclient cifs-utils autofs
mkdir -p /media/SMB
cat<<EOF>> /home/yoyo/.smbcredentials
username=yoyo
password=ondine69
domain=zalin.home
EOF
chmod 400 /home/yoyo/.smbcredentials




echo '/media/SMB /etc/auto.smb.top --ghost' >> /etc/auto.master
cat <<EOF>>/etc/auto.smb.top
* -fstype=autofs,-Dhost=& file:/etc/auto.smb.sub
EOF

cat <<EOF>/etc/auto.smb.sub
Video -fstype=cifs,credentials=/home/yoyo/.smbcredentials,uid=1000,gid=1000,vers=2.1,nounix,rsize=8192,wsize=8192,iocharset=utf8,file_mode=0750,dir_mode=0750 ://filer.zalin.home/Video
Partage -fstype=cifs,credentials=/home/yoyo/.smbcredentials,uid=1000,gid=1000,vers=2.1,nounix,rsize=8192,wsize=8192,iocharset=utf8,file_mode=0750,dir_mode=0750 ://filer.zalin.home/Partage
Musique -fstype=cifs,credentials=/home/yoyo/.smbcredentials,uid=1000,gid=1000,vers=2.1,nounix,rsize=8192,wsize=8192,iocharset=utf8,file_mode=0750,dir_mode=0750 ://filer.zalin.home/Musique
EOF
# on peut rempacler les uid par uid=${UID},gid=${EUID}

chmod 644 /etc/auto.smb.*
sudo service autofs restart

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
sudo apt install virtualbox
sudo apt install virtualbox-ext-pack

#	sudo apt-get -y install gcc make linux-headers-$(uname -r) dkms
#	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
#	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
#	sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >/etc/apt/sources.list.d/virtualbox.list'
#	sudo apt-get update
#	sudo apt-get install virtualbox-5.2
#	apt list --upgradable
#	# verif
#	VBoxManage -v
#	# extension pack 
#	curl -O http://download.virtualbox.org/virtualbox/5.2.0/Oracle_VM_VirtualBox_Extension_Pack-5.2.0.vbox-extpack
#	sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.0.vbox-extpack
#	# verif extension 
#	VBoxManage list extpacks

	 
 ##=== Megasync
https://mega.nz/linux/MEGAsync/xUbuntu_18.10/amd64/megasync_3.7.1_amd64.deb

## === dropbox
	https://www.dropbox.com/install-linux
	sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
	sudo apt-get -y update
	
##=== Gnome EncFS Manager 
	 sudo apt-get install encfs 
	 mkdir -p ~/Encfs/Prive
	 sudo add-apt-repository ppa:gencfsm/ppa && sudo apt-get update
	 sudo apt-get install gnome-shell-extension-appindicator 
	 #sudo apt-get install  gnome-encfs-manager 
	 http://ppa.launchpad.net/gencfsm/ppa/ubuntu/pool/main/g/gnome-encfs-manager/gnome-encfs-manager_1.8.19~ubuntu18.04.1_amd64.deb
	 gnome-encfs-manager set_pref force_traysystem="appindicator" && gnome-encfs-manager --replace

## === keepass2
sudo apt-get install -y mono-complete 
sudo apt-get install -y keepass2 keepass2-doc mono-dmcs xdotool curl jq
sudo mkdir /usr/lib/keepass2/Plugins

# ajuste la version
 https://sourceforge.net/projects/keepass/files/Translations%202.x/2.38/KeePass-2.36-French-f.zip/download
sudo unzip -d ~/.config/KeePass/ KeePass-2.36-French-f.zip
# plugin
wget https://keepass.info/extensions/v2/databasebackup/DataBaseBackup-2.0.8.6.zip
sudo unzip -d /usr/lib/keepass2/Plugins DataBaseBackup-2.0.8.6.zip
#
wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp.plgx
sudo mv KeePassHttp.plgx /usr/lib/keepass2/Plugins
sudo chmod 644 /usr/lib/keepass2/Plugins/KeePassHttp.plgx 
# 
curl -s https://api.github.com/repos/kee-org/keepassrpc/releases/latest | jq -r ".assets[] | select(.name | test(\"KeePassRPC.plgx\")) | .browser_download_url" | xargs sudo curl -s -L -o "/usr/lib/keepass2/Plugins/KeePassRPC.plgx"
sudo chown yoyo.yoyo /usr/lib/keepass2/Plugins/*.plgx 

## nouveau plugin
wget https://github.com/smorks/keepassnatmsg/releases/download/v2.0.5/KeePassNatMsg-v2.0.5-binaries.zip

cp * /usr/lib/keepass2/Plugins


## === video player : vlc
sudo apt-get install -y vlc
## === Edition graphic
sudo apt-get install pinta
	 
 ## === video player : MVP
sudo apt-get install -y mpv

## === JAVA
sudo apt install openjdk-8-jdk
sudo add-apt-repository ppa:linuxuprising/java
sudo apt install oracle-java11-set-default

## === Fontes - Polices
sudo apt install ttf-mscorefonts-installer
sudo apt-get install ttf-georgewilliams 
sudo fc-cache -f -v

# ==============================================
## == GIT
	sudo apt-get install git meld
	sudo apt-get install git-core git-gui git-doc
	GITUSERNAME="kamahat" && git config --global user.name $GITUSERNAME
	GITEMAIL=$GITUSERNAME"@h.com" && git config --global user.email $GITEMAIL
	# creation du projet sur GIT ConfigPC
	git init ConfigPC && cd ConfigPC
	git add install-17.10.sh # ajout des ficheir au repository
	git commit -m "Ouverture du CVS" # on commit quand o na tous les fichiers
	# ajout du repository distant
	git remote add origin https://github.com/kamahat/ConfigPC.git
	# push fichier du local sur le gitid_rsa_git
	git push -u origin master 
	# conifgure meld par defaut -- deja fait
cat<<EOF>>~/.gitconfig
[merge]
	tool = meld
EOF



# GIT SSH
	# Creation d'un jeu de clef
	ssh-keygen -t rsa -C $GITUSERNAME"@h.com" -f ~/.ssh/id_rsa_github
	# on export la clef publique dans GitHub (https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account)
	sudo apt-get install xclip keychain
	xclip -sel clip < ~/.ssh/id_rsa_github.pub
	# test :
	ssh -T git@github.com
	# on ajoute la clef dans ubuntu
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa_github # ajout de la clef à l'agent ssh
		Enter passphrase for /home/yoyo/.ssh/id_rsa_github: 
		Identity added: /home/$USER/.ssh/id_rsa_github (/home/$USER/.ssh/id_rsa_github)
	## on Check : on peut conmparel e hash md5 avec celu ide github
	ssh-add -l -E md5
		2048 MD5:99:48:xxxxxxxxxxxd:0b:f8 /home/$USER/.ssh/id_rsa (RSA)
		2048 MD5:e0:be:xxxxxxxxxxxxxx04:bd:34 /home/$USER/.ssh/id_rsa_github (RSA)
		2048 MD5:e0:be:xxxxxxxxxxxxxxx:bd:34 y@y.com (RSA)
		2048 MD5:99:48:xxxxxxxxxxxx:0b:f8  U@U.com (RSA)
	##
	git config --global user.email "kamahat@hotmail.com"
	git config --global --list
	# On change l'URL du projet de Http à SSH
	git remote set-url origin git@github.com:kamahat/ConfigPC.git
	
	# Forker marlin vers mon github: directe dans l'interface
	# copie local
	cd /home/yoyo/Build/Git
	git clone git@github.com:kamahat/Marlin.git --branch bugfix-2.0.x --single-branch
	cd Marlin
	git status
	git remote add upstream https://github.com/MarlinFirmware/Marlin.git

	# utilisation des clefs ssh
	cat <EOF>>/home/yoyo/.bashrc
	/usr/bin/keychain --clear $HOME/.ssh/id_rsa $HOME/.ssh/id_rsa_github
	source $HOME/.keychain/$HOSTNAME-sh
	EOF

# aide github
# https://www.christopheducamp.com/2013/12/16/forker-un-repo-github/

# update Local repository
cd ~/Build/Git/Marlin
git fetch upstream
git checkout bugfix-2.0.x
git merge upstream/bugfix-2.0.x
# update github
cd ~/Build/Git/Marlin
git push

## == cura
#stable (3.4)
#sudo add-apt-repository ppa:thopiekar/cura && sudo apt-get update
# edge (3.5)
sudo add-apt-repository ppa:thopiekar/cura-master && sudo apt-get update
apt-get install cura

# ================
# === tinyMediaManager
apt-get install openjdk-8-jdk
apt-get install libmediainfo*
cd /path/to/tinyMediaManager
 ./tinyMediaManager.sh
 # Download  http://release.tinymediamanager.org/
 wget http://release.tinymediamanager.org/dist/tmm_2.9.8_6644bb9_linux.tar.gz
 tar -zxvf tmm_2.9.8_6644bb9_linux.tar.gz
 sed -i 's/^java/\/usr\/lib\/jvm\/java-8-openjdk-amd64/' ./tinyMediaManager.sh
 
# ==============================================
# == Media Manager
# ================
# === MEdiaelec : gestion bibliotech video

cd ~/Build/Git/MediaElch
wget https://bintray.com/komet/MediaElch/download_file?file_path=MediaElch_linux_2.6.0_2019-01-06_08-54_git-master-d11d788.AppImage

# ==============================================
# deezer player
# ==============================================
sudo add-apt-repository ppa:alexlarsson/flatpak
sudo apt install flatpak xdg-desktop-portal-gtk xdg-desktop-portal gnome-software gnome-software-plugin-flatpak

cat <<EOF>~/.local/share/flatpak/repo/config
[remote "flathub"]
gpg-verify=true
gpg-verify-summary=true
url=https://flathub.org/repo/
xa.title=Flathub
EOF

# import key 

wget https://flathub.org/repo/flathub.gpg
flatpak --user remote-modify --gpg-import=flathub.gpg flathub
flatpak --user install flathub org.gnome.Recipes
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-add --if-not-exists nuvola https://dl.tiliado.eu/flatpak/nuvola.flatpakrepo
flatpak update
flatpak install nuvola eu.tiliado.Nuvola
flatpak install nuvola eu.tiliado.NuvolaAppDeezer 


#========================
# FReecad

#openscad
wget -qO - https://files.openscad.org/OBS-Repository-Key.pub | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/t-paul/xUbuntu_18.10/ ./' >>/etc/apt/sources.list.d/openscad.list 
sudo apt-get install openscad-nightly

#===============
# signal
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop

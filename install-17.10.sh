#!/bin/bash
##
## GIT ecriture : 
##		git commit -m "Fin"
##		git push -u origin master
##

## == nettoyage
sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove

## 18.10 bug

sudo apt install gnome-system-monitor
## == debut
sudo apt-get install vim terminator git htop curl aptitude screen openssh-server gparted remmina
sudo apt-get install keyutils
apt install -y realmd sssd sssd-tools libnss-sss libpam-sss krb5-user adcli samba-common-bin ntp  


echo 'UUID=45e71c47-a88f-4493-8b1a-e5bfcf7562b0 /home/yoyo/eMule           reiserfs    defaults        0       2' >>/etc/fstab
# mkdir -p /media/yoyo/{Video,Musique,Partage}
# echo '//filer.zalin.home/Video     /media/yoyo/Video     cifs     _netdev,credentials=/home/yoyo/.smbcredentials,iocharset=utf8,vers=3.0,gid=1000,uid=1000,rw,guest    0     0' >>/etc/fstab

cat <<EOF>/home/yoyo/.smbcredentials
username=yoyo
password=MonMotDePasse
domain=zalin.home
EOF
chmod 600 /home/yoyo/.smbcredentials
# == reseau
sudo apt-get install wireshark zenmap sipcalc ethtool net-tools
# NFS client
apt install -y nfs-common
# mount -t nfs filer.zalin.home:/volume2/Partage /media/yoyo/NFS
sudo snap refresh

# CIFS
sudo apt-get install smbclient cifs-utils

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
 
# === QDirStat
sudo add-apt-repository ppa:nathan-renniewaldock/qdirstat
sudo apt install qdirstat

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
	http://download.virtualbox.org/virtualbox/5.2.12/Oracle_VM_VirtualBox_Extension_Pack-5.2.12-122591.vbox-extpack
	sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.0-120293.vbox-extpack
	# verif extension 
	VBoxManage list extpacks

##== drivers Nvidia
# https://charlienewey.github.io/getting-nvidia-drivers-working-on-ubuntu-17-10/
	sudo add-apt-repository ppa:graphics-drivers/ppa 
	sudo apt-get update 
	ubuntu-drivers devices  
	# optinel pour tester la carte
			sudo apt-get install phoronix-test-suite
			 sudo phoronix-test-suite default-benchmark openarena xonotic tesseract gputest unigine-valley
			 
	#choisir la version, actuellement = 390
	sudo apt-get install nvidia-driver-(numéro du pilote) 
	### === cuda
	sudo apt-get install linux-headers-$(uname -r)
	sudo apt -y install nvidia-cuda-toolkit
	nvcc -V 
	 
 ##=== Megasync
 https://mega.co.nz/#sync!linux
 
 ##=== LibreOffice
 snap remove LibreOffice
 sudo add-apt-repository ppa:libreoffice/ppa
 sudo apt-get install libreoffice libreoffice-nlpsolver libreoffice-help-fr libreoffice-l10n-fr
 
 ## === video player : MVP
	sudo add-apt-repository ppa:mc3man/mpv-tests
	sudo apt-get update
	sudo apt-get install -y mpv

## === video player : vlc
sudo apt-get install -y vlc
## === Edition graphic
sudo apt-get install pinta
## === dropbox
	https://www.dropbox.com/install-linux
	sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
	sudo apt-get -y update

## === keepass2
sudo apt-get install -y mono-complete 
sudo apt-get install -y keepass2 keepass2-doc mono-dmcs xdotool
# ajuste la version
 https://sourceforge.net/projects/keepass/files/Translations%202.x/2.38/KeePass-2.36-French-f.zip/download
sudo unzip -d ~/.config/KeePass/ KeePass-2.36-French-f.zip
# plugin
https://keepass.info/extensions/v2/databasebackup/DataBaseBackup-2.0.8.6.zip
sudo unzip -d /usr/lib/keepass2/Plugins DataBaseBackup-2.0.8.6.zip
#
wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp.plgx
sudo mv KeePassHttp.plgx /usr/lib/keepass2/Plugins
sudo chmod 644 /usr/lib/keepass2/Plugins/KeePassHttp.plgx 
##=== Gnome EncFS Manager 
	 sudo apt-get install encfs 
	 mkdir -p ~/Encfs/Prive
	 sudo add-apt-repository ppa:gencfsm/ppa && sudo apt-get update
	 sudo apt-get install gnome-shell-extension-appindicator gnome-encfs-manager 
	 gnome-encfs-manager set_pref force_traysystem="appindicator" && gnome-encfs-manager --replace
	 
	 
## === Lecture Flash swf
sed -i '/<mime-type type="application\/vnd.adobe.flash.movie">/s/vnd.adobe.flash.movie/x-shockwave-flash/' /usr/share/mime/packages/freedesktop.org.xml
update-mime-database /usr/share/mime
## === freecad
sudo add-apt-repository ppa:freecad-maintainers/freecad-daily && sudo apt-get update
sudo apt-get install freecad-daily freecad-daily-doc  
## === Telegram
sudo apt-get install -y telegram-desktop
#sudo add-apt-repository -y ppa:atareao/telegram && sudo apt-get update && sudo apt-get install -y telegram
# a ajouter au demarrage

## === JAva
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java9-installer oracle-java9-set-default

## == mega
https://mega.nz/linux/MEGAsync/xUbuntu_17.10/amd64/megasync-xUbuntu_17.10_amd64.deb
# ==============================================
## == GIT
	sudo apt-get install git
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

# GIT SSH
	# Creation d'un jeu de clef
	ssh-keygen -t rsa -C $GITUSERNAME"@h.com" -f ~/.ssh/id_rsa_github
	# on export la clef publique dans GitHub
	# on ajoute la clef dans ubuntu 
	ssh-add ~/.ssh/id_rsa_github
		Enter passphrase for /home/yoyo/.ssh/id_rsa_github: 
		Identity added: /home/$USER/.ssh/id_rsa_github (/home/$USER/.ssh/id_rsa_github)
	## on Check : on peut conmparele hash md5 avec celu ide github
	ssh-add -l -E md5
		2048 MD5:99:48:xxxxxxxxxxxd:0b:f8 /home/$USER/.ssh/id_rsa (RSA)
		2048 MD5:e0:be:xxxxxxxxxxxxxx04:bd:34 /home/$USER/.ssh/id_rsa_github (RSA)
		2048 MD5:e0:be:xxxxxxxxxxxxxxx:bd:34 y@y.com (RSA)
		2048 MD5:99:48:xxxxxxxxxxxx:0b:f8  U@U.com (RSA)
	##
	# On change l'URL du projet de Http à SSH
	git remote set-url origin git@github.com:kamahat/ConfigPC.git
# ==============================================
## == Arduino
# Telecharger le binaire sur : https://www.arduino.cc/en/Main/Software
mkdir -p ~/Build/local/Arduino && cd ~/Build/local/Arduino
tar -xvf ~/Téléchargements/arduino-1.8.5-linux64.tar.xz
./install.sh 
	Adding desktop shortcut, menu item and file associations for Arduino IDE... done!
# Raccourcis "Arduino IDE" on doit le rendre exécutable en faisant clic droit → Propriété → Permission → cochez "autorisez l'exécution du fichier comme un programme"
sudo chmod a+rw /dev/ttyUSB0

## == cura
#stable (3.4)
#sudo add-apt-repository ppa:thopiekar/cura && sudo apt-get update
# edge (3.5)
sudo add-apt-repository ppa:thopiekar/cura-master && sudo apt-get update
        
apt-get install cura
# ==============================================
## == Stellarium
sudo add-apt-repository ppa:stellarium/stellarium-releases
sudo apt-get install stellarium
# ==============================================
# == Media Manager
# ================
# === MEdiaelec : gestion bibliotech video
# le repository n'a pas e version pour la 17.10
##sudo apt-get install qt5-default qtmultimedia5-dev qt5-qmake qtscript5-dev libmediainfo-dev qtdeclarative5-dev
#cd ~/Build/Git
#git clone https://github.com/Komet/MediaElch.git
#cd MediaElch && mkdir build && cd build
#qmake .. && make -j5

# autre optin : app image
cd ~/Build/Git/MediaElch
wget https://bintray.com/komet/MediaElch/download_file?file_path=MediaElch_linux_2.6.0_2019-01-06_08-54_git-master-d11d788.AppImage


# ================
# === tinyMediaManager
apt-get install openjdk-8-jdk
apt-get install libmediainfo
cd /path/to/tinyMediaManager
 ./tinyMediaManager.sh
 # Download  http://release.tinymediamanager.org/
 wget http://release.tinymediamanager.org/dist/tmm_2.9.8_6644bb9_linux.tar.gz
# ==============================================

## === Clementine
sudo apt-get install clementine
## === gestion des tag audio
sudo apt-get install easytag
## muzixbrainz
$noop(Various Artist Albums)
$if($eq(%compilation%,1),
[$if2(%albumartist%,%artist%)]/%album%/
$if($gt(%totaldiscs%,1),$if(%discsubtitle%,CD %discnumber%: %discsubtitle%/, CD %discnumber%/),)
$num(%tracknumber%,2). %artist% - %title%,
$noop(Single Artist Albums)
$firstalphachar($if($eq($left($lower(%artist%),4),the ),
$right($upper(%artist%),$sub($len(%artist%),4)),$upper(%artist%)))/
$noop(Artist)
$if2(%albumartist%,%artist%)/
$if(%album%,%album%/
$noop(Album Tracks)
$if($gt(%totaldiscs%,1),$if(%discsubtitle%,CD %discnumber%: %discsubtitle%/, CD %discnumber%/),)
$num(%tracknumber%,2). %title%,
$noop(Non-Album Tracks)
%title%
)
)
# ==============================================
## === Hashcat
apt-get install opencl-headers

# ============================
## == geogebra 5.0 avec 3D
sudo add-apt-repository "deb http://www.geogebra.net/linux/ stable main"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C072A32983A736CF  &&   sudo apt-get update
sudo apt-get install geogebra5 geogebra-classic geogebra-math-apps geogebra-math-calculators

# ============================
## == slic3r

# solution simple : le packages
aptitude versions slic3r
sudo apt-get install slic3r

# à partir des sources
sudo apt-get install build-essential libgtk2.0-dev libwxgtk3.0-dev libwx-perl libmodule-build-perl git cpanminus libextutils-cppguess-perl libboost-all-dev libxmu-dev liblocal-lib-perl wx-common libopengl-perl libwx-glcanvas-perl libtbb-dev libxmu-dev freeglut3-dev libwxgtk-media3.0-dev libboost-thread-dev libboost-system-dev libboost-filesystem-dev
cd ~/Build/Git
git clone https://github.com/alexrj/Slic3r.git
cd Slic3r
git checkout -b origin/master 

export LDLOADLIBS=-lstdc++
# pour intel : -msse4.2
# export GCCOPT='-O3 -j4 -pipe -msse4a'
#perl Build.PL //OPTIMIZE="-O3 -j4" 
perl Build.PL 
perl Build.PL --gui
cat <<EOF>slic3r
#!/bin/sh
perl ./slic3r.pl $*
EOF
chmod +x slic3r


#Exec=bash -c 'cd /opt/Slic3r && /opt/Slic3r/Slic3r --gui %F'
cat<<EOF>/usr/share/applications/slic3r_master.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Slic3r
Icon=//home/yoyo/Build/Git/Slic3r/var/Slic3r.png
Exec=bash -c 'cd /home/yoyo/Build/Git/Slic3r && ./Slic3r %F'

Keywords=perl;slice;3D;printer;convert;gcode;stl;obj;amf;
StartupNotify=false
StartupWMClass=slic3r
MimeType=application/sla;model/x-wavefront-obj;model/x-geomview-off;application/x-amf;
Categories=Development;Engineering;
EOF

# update
rm slic3r
git pull

# ============================
## == integration AD
apt -y install realmd sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob oddjob-mkhomedir packagekit

cat <<EOF>/etc/realmd.conf
[users]
 default-home = /home/%D/%U
 default-shell = /bin/bash
 
[active-directory]
 default-client = sssd
 os-name = Ubuntu Workstation
 os-version = 18.04
 
[service]
 automatic-install = no
 
[zalin.home]
 fully-qualified-names = yes
 automatic-id-mapping = no
 user-principal = yes
 manage-system = yes
EOF

realm discover ZALIN.HOME
realm join ZALIN.HOME --user Administrateur --computer-ou=OU=Computers
echo "use_fully_qualified_names = False" >> /etc/sssd/sssd.conf
systemctl restart sssd

# ====================
# AutoFS
cat<<EOF>> /home/yoyo/.smbcredentials
username=yoyo
password=ondine69
domain=zalin.home
EOF
chmod 400 /home/yoyo/.smbcredentials


sudo apt-get install autofs
mkdir -p /media/SMB

echo '/media/SMB /etc/auto.smb.top --ghost' >> /etc/auto.master
cat <<EOF>>/etc/auto.smb.top
* -fstype=autofs,-Dhost=& file:/etc/auto.smb.sub
EOF

cat <<EOF>/etc/auto.smb.sub
Video -fstype=cifs,credentials=/home/yoyo/.smbcredentials,uid=1000,gid=1000,vers=2.1 ://filer.zalin.home/Video
Partage -fstype=cifs,credentials=/home/yoyo/.smbcredentials,uid=1000,gid=1000,vers=2.1 ://filer.zalin.home/Partage
Musique -fstype=cifs,credentials=/home/yoyo/.smbcredentials,uid=1000,gid=1000,vers=2.1 ://filer.zalin.home/Musique
EOF
# on peut rempacler les uid par uid=${UID},gid=${EUID}

chmod 644 /etc/auto.smb.*
sudo service autofs restart
# ====================
# openscad
sudo add-apt-repository ppa:openscad/releases
sudo apt-get install openscad

#!/bin/bash
#
# RAspbian install
#
#----------------------

# on demonte les parition de la carte SD
lsblk
# unzip et copie l'image

unzip -p 2018-06-27-raspbian-stretch-lite.zip | dd bs=4M if=2018-06-27-raspbian-stretch-lite.img of=/dev/sdg conv=fsync

# partition remonté
#mount /dev/sdg1 /media/yoyo
echo 'SSH' >/media/yoyo/boot/ssh

#----------------------
# SSH - preconfig

mkdir -p /media/yoyo/rootfs/root/.ssh
cat <<EOF>/media/yoyo/rootfs/root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7fe9GFsCnR/fRSuDddi2quB3wy9LcCO+ZnUS+8CbSEUHbIRKNqlg4RKe2GkHuDwVGUpvOOxIHlr4r2aqa7g6/UwvJxr5EPmDwzWjFawvIduNQKGP8uT2g/tP7Hm2SfnfcJAjtlaCRFjlyvxcx1InebGgcXvocUQ+uJFC2L58QVC6oslVnqs7fhlWMBGKoSDZ1fbg98tcYw43oo+hBa0XrERJZZmJJ5KKNvBxI7pfJMS887wo2ExAj9Jkawi7yv8iHF/GSzrrDvkxBxweyRUHivJ27iGhZfecFpow7HNa3T8usy3494tlzJDeFT6xe3O2NpvHwont/fh5+nt0fk2yp yoyo@Maria
EOF
chmod 600 /media/yoyo/rootfs/root/.ssh/authorized_keys

#----------------------
# wifi  - preconfig

# wpa_passphrase "LiBeBCNOF" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null
cat <<EOF>/media/yoyo/rootfs/etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=FR

network={
	ssid="dd-wrt"
	psk=a3bd3eaccea231cbe16adec9eeda7dafc7ac0b666c7c2cd6010c5bd53d9e42b4
}
EOF
# wpa_cli -i wlan0 reconfigure

sed -i '/#alias ipv6 off/s/^#//' /media/yoyo/rootfs/etc/modprobe.d/ipv6.conf
# sed -i '/^all:/ s/$/ ipv6.disable=1/' /media/yoyo/boot/cmdline.txt

#----------------------
# Configuration

#boot
ssh pi@192.168.64.145
# password = raspberry
#sudo adduser yoyo 
#sudo adduser yoyo sudo

sudo systemctl enable ssh
sudo systemctl start ssh

sudo raspi-config
# hostname
# raspi-config nonint do_hostname %s 
# raspi-config nonint do_onewire %d
raspi-config --expand-rootfs


# Sélectionner l’option « 4 Localisation Options »
# Puis « I3 Change Keyboard Layout »
# Garder « PC générique 105 touches (intl) » et valider
# Sélectionner « Autre » et valider
# Chercher « Français » et valider
# Sélectionner « Français » dans la disposition du clavier et valider
# Garder « Disposition par défaut pour le clavier » et valider
# Garder « Pas de touche « compose » » et valider
# Sortir de raspi-config et confirmer le reboot.

update-locale LANG=fr_FR.UTF-8
locale-gen --purge "LANG=fr_FR.UTF-8 UTF-8"
dpkg-reconfigure --frontend noninteractive locales
sudo timedatectl set-timezone Europe/Paris

# --- mise à jours

sudo apt-get update
sudo apt-get dist-upgrade -y
raspi-config nonint do_update
rpi-update
sudo apt-get install vim ntp ntpdate
sudo ntpdate -s ntp.obspm.fr


# sudo dpkg-reconfigure tzdata




#----------------------
# Node-RED
#
# doc : https://nodered.org/docs/hardware/raspberrypi

sudo apt-get install build-essential
bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)
# You can now start Node-RED with the command  node-red-start
#  or using the icon under   Menu / Programming / Node-RED
#  Then point your browser to localhost:1880 or http://{your_pi_ip-address}:1880

sudo wget https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/nodered.service -O /lib/systemd/system/nodered.service
sudo wget https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/node-red-start -O /usr/bin/node-red-start
sudo wget https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/node-red-stop -O /usr/bin/node-red-stop
sudo chmod +x /usr/bin/node-red-st*
sudo systemctl daemon-reload

sudo systemctl enable nodered.service

# update npm
npm i -g npm
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:$PATH" >> ~/.profile
source ~/.profile
# utilitaire pour gere la version de node js
# a rempalcer par nvm : https://github.com/creationix/nvm
npm install -g n
n stable

# node --version
v10.8.0

# utilisatire 
npm install -g vtop
npm install -g prettier 

# 1-wire
# doc : https://www.npmjs.com/package/node-red-contrib-owfs
# https://www.domolio.fr/premiers-pas-avec-le-1-wire-et-owserver-sous-debian-wheezy/
apt-get install owfs
npm install owfs
sed -i '/server: usb/s/^#//' /etc/owfs.conf
sed -i '/server: FAKE/s/^/#/' /etc/owfs.conf
sed -i '/server: port/s/localhost/127.0.0.1/' /etc/owfs.conf
systemctl restart owserver

#npm install owfs
#npm install node-red-contrib-owfs 
npm install -g rpi2mqtt



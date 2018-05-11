#!/bin/bash


# ==============================================
## == Install Octopi


## == SSH
mkdir -p /home/pi/.ssh
cat <<EOF>>/home/pi/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7fe9GFsCnR/fRSuDddi2quB3wy9LcCO+ZnUS+8CbSEUHbIRKNqlg4RKe2GkHuDwVGUpvOOxIHlr4r2aqa7g6/UwvJxr5EPmDwzWjFawvIduNQKGP8uT2g/tP7Hm2SfnfcJAjtlaCRFjlyvxcx1InebGgcXvocUQ+uJFC2L58QVC6oslVnqs7fhlWMBGKoSDZ1fbg98tcYw43oo+hBa0XrERJZZmJJ5KKNvBxI7pfJMS887wo2ExAj9Jkawi7yv8iHF/GSzrrDvkxBxweyRUHivJ27iGhZfecFpow7HNa3T8usy3494tlzJDeFT6xe3O2NpvHwont/fh5+nt0fk2yp yoyo@Maria
EOF
chmod 640 /home/pi/.ssh/authorized_keys

## == disable IPv6

cat <<EOF>>/etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
net.ipv6.conf.wlan0.disable_ipv6 = 1

EOF

sysctl -p

blacklist ipv6
to /etc/modprobe.d/ipv6.conf
## == Wifi

# scan les reseaux  wifi
sudo iwlist wlan0 scan

# on change les normes
sed -i '/^country=/s/GB/FR/' /etc/wpa_supplicant/wpa_supplicant.conf

# on cree la ligen de connexion dans le ficheri de configuration : 
wpa_passphrase "dd-wrt" "LiBeBCNOF" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null

tail /etc/wpa_supplicant/wpa_supplicant.conf
## You can configure more than 1 wifi networks by adding more 'network' blocks
#network={
#  ssid="Another Wifi"
#  psk="password"
#}
network={
	ssid="dd-wrt"
	#psk="LiBeBCNOF"
	psk=a3bd3eaccea231cbe16adec9eeda7dafc7ac0b666c7c2cd6010c5bd53d9e42b4
}

# la wlan0 peutfaire du dhcp
echo 'auto wlan0' >> /etc/network/interfaces

# Relance le wifi 
wpa_cli -i wlan0 reconfigure

###################################
# Octopi
# recommadner passer sur un firmware mavin/Skyned3D 


## OctoPrint 1.3.7 or later, tells me that my printer's firmware lacks mandatory safety features, what does this mean?
# it means that it detected a firmware running on your printer that is known to lack mandatory safety features such as thermal runaway protection.
# It currently does this for the following stock firmwares: Anet A8 (identified through firmware name ANET_A8_*)
# ===> update your printer to a safe firmware, such as Marlin or Repetier 


# upgrade pipi installer
sudo pip install --upgrade pip

####################################
# Anet A8 update : Skynet3d 
# basé sur Marlin + auto-leveling 





#!/bin/bash


cat <<EOF>>/root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7fe9GFsCnR/fRSuDddi2quB3wy9LcCO+ZnUS+8CbSEUHbIRKNqlg4RKe2GkHuDwVGUpvOOxIHlr4r2aqa7g6/UwvJxr5EPmDwzWjFawvIduNQKGP8uT2g/tP7Hm2SfnfcJAjtlaCRFjlyvxcx1InebGgcXvocUQ+uJFC2L58QVC6oslVnqs7fhlWMBGKoSDZ1fbg98tcYw43oo+hBa0XrERJZZmJJ5KKNvBxI7pfJMS887wo2ExAj9Jkawi7yv8iHF/GSzrrDvkxBxweyRUHivJ27iGhZfecFpow7HNa3T8usy3494tlzJDeFT6xe3O2NpvHwont/fh5+nt0fk2yp yoyo@Maria
EOF

# ==============================================
## == Install Sickrage - MEdusa

sudo apt-get update && sudo apt-get install unrar-free git-core openssl libssl-dev python2.7
sudo addgroup --system medusa
sudo adduser --disabled-password --system --home /var/lib/medusa --gecos "Medusa" --ingroup medusa medusa
sudo mkdir /opt/medusa && sudo chown medusa:medusa /opt/medusa

su - medusa
sudo -u medusa git clone https://github.com/pymedusa/Medusa.git /opt/medusa
sudo cp -v /opt/medusa/runscripts/init.systemd /etc/systemd/system/medusa.service

sudo chown root:root /etc/systemd/system/medusa.service
sudo chmod 644 /etc/systemd/system/medusa.service

## on abaisse le niveau des droits sinon on peut pas ecrire sur le partage
# /etc/systemd/system/medusa.service
[Service]
User=root
Group=root

sudo systemctl enable medusa
sudo systemctl start medusa
sudo systemctl status medusa

http://jd2.zalin.home:8081


# ==============================================
# === VPN
apt-get -y install openvpn

touch /etc/openvpn/credentials
printf '%s\n' 'username' 'password' > /etc/openvpn/credentials
sed -i 's/auth-user-pass/auth-user-pass \/etc\/openvpn\/credentials/g' /etc/openvpn/vpnunlimited-CH.conf

# test
openvpn --config /etc/openvpn/vpnunlimited-CH.conf

# autostart

cat <<EOF>>/lib/systemd/system/OpenVPN-vpnunlimited-CH.service
[Unit]
Description=Hide.me OpenVPN CH
After=multi-user.target

[Service]
Type=idle
ExecStart=/usr/sbin/openvpn --config /etc/openvpn/vpnunlimited-CH.conf

[Install]
WantedBy=multi-user.target
EOF

chmod 644 /lib/systemd/system/OpenVPN-vpnunlimited-CH.service
systemctl daemon-reload
systemctl enable OpenVPN-vpnunlimited-CH.service
systemctl daemon-reload
systemctl status OpenVPN-vpnunlimited-CH.service

## verification
w3m http://hide.me/check

#!/bin/bash


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

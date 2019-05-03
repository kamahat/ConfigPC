#!/bin/bash


cat <<EOF>>/root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7fe9GFsCnR/fRSuDddi2quB3wy9LcCO+ZnUS+8CbSEUHbIRKNqlg4RKe2GkHuDwVGUpvOOxIHlr4r2aqa7g6/UwvJxr5EPmDwzWjFawvIduNQKGP8uT2g/tP7Hm2SfnfcJAjtlaCRFjlyvxcx1InebGgcXvocUQ+uJFC2L58QVC6oslVnqs7fhlWMBGKoSDZ1fbg98tcYw43oo+hBa0XrERJZZmJJ5KKNvBxI7pfJMS887wo2ExAj9Jkawi7yv8iHF/GSzrrDvkxBxweyRUHivJ27iGhZfecFpow7HNa3T8usy3494tlzJDeFT6xe3O2NpvHwont/fh5+nt0fk2yp yoyo@Maria
EOF
chmod 640 /root/.ssh/authorized_keys

apt-get install dialog

## ============================
## note : flux mqtt

piscine_lumiere_mqtt/statut {consigne : 1} /{consigne : 0}

piscine_moteur_mqtt/statut { consigne: 1}

const char* DomotOutTopic = "domoticz/in";
const char* mqtt_JeedomOutTopic = "piscine_mqtt/capteur";
const char* mqtt_moteur_JeedomInTopic = "piscine_moteur_mqtt/statut";
const char* mqtt_lumiere_JeedomInTopic = "piscine_lumiere_mqtt/statut";

# === Client  mosquitto
# sudo apt-get install mosquitto 
sudo apt-get install mosquitto-clients
mosquitto_sub -h mqtt.zalin.home -t piscine_mqtt/+

## jeedom start /st op piscine
#[racine][Filtration Piscine][On]#
#[racine][Filtration Piscine][Off]#

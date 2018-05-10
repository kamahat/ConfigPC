#!/bin/bash


# ==============================================
## == Install Octopi

mkdir -p /home/pi/.ssh
cat <<EOF>>/home/pi/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7fe9GFsCnR/fRSuDddi2quB3wy9LcCO+ZnUS+8CbSEUHbIRKNqlg4RKe2GkHuDwVGUpvOOxIHlr4r2aqa7g6/UwvJxr5EPmDwzWjFawvIduNQKGP8uT2g/tP7Hm2SfnfcJAjtlaCRFjlyvxcx1InebGgcXvocUQ+uJFC2L58QVC6oslVnqs7fhlWMBGKoSDZ1fbg98tcYw43oo+hBa0XrERJZZmJJ5KKNvBxI7pfJMS887wo2ExAj9Jkawi7yv8iHF/GSzrrDvkxBxweyRUHivJ27iGhZfecFpow7HNa3T8usy3494tlzJDeFT6xe3O2NpvHwont/fh5+nt0fk2yp yoyo@Maria
EOF
chmod 640 /home/pi/.ssh/authorized_keys



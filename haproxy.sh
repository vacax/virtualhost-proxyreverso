#!/usr/bin/env bash
echo "Instalando estructura basica para clase virtualhost y proxy reverso"

# Habilitando la memoria de intecambio.
sudo dd if=/dev/zero of=/swapfile count=2048 bs=1MiB
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Instando los software necesarios para probar el concepto.
sudo yum update && sudo yum install -y htop nmap git haproxy mod_ssl
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y certbot

# Instalando la versión sdkman y java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java

# Subiendo el servicio de Apache.
#sudo systemctl start httpd

# Insta
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
sudo yum update -y && sudo yum install -y htop nmap git httpd mod_ssl tree
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y certbot

# Instalando la versión sdkman y java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java

# Subiendo el servicio de Apache.
sudo systemctl start httpd

# Creando las carpetas necesarias para el ejemplo de virtualhost
sudo mkdir /var/www/html/app1 /var/www/html/app2
sudo echo "Aplicacion #1" >  /var/www/html/app1/index.html
sudo echo "Aplicacion #2" >  /var/www/html/app2/index.html

cd ~/
git clone https://github.com/vacax/virtualhost-proxyreverso && cd virtualhost-proxyreverso
cp configuraciones/*.conf /etc/httpd/conf.d/

# Clonando el proyecto de Javalin-demo y Orm-JPA
cd ~/
git clone https://github.com/vacax/javalin-demo/ && cd javalin-demo && ./gradlew shadowjar && java -jar build/libs/app.jar > salida.txt 2> error.txt &

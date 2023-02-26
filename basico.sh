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
echo "Aplicacion #1" | sudo tee /var/www/html/app1/index.html
echo "Aplicacion #2" | sudo tee /var/www/html/app2/index.html

# Clonando el proyecto de virtualhost-proxyreverso y copiando los archivos importantes.
# Una vez compiado, si es reiniciado el servicio de apache, deberá configurar los nuevos archivos creados.
# Donde dice cambiar sustituir.
cd ~/
git clone https://github.com/vacax/virtualhost-proxyreverso && cd virtualhost-proxyreverso
cp configuraciones/*.conf /etc/httpd/conf.d/

# Clonando el proyecto de Javalin-demo e iniciando la aplicación, escuchando en el puerto 7000
cd ~/
git clone https://github.com/vacax/javalin-demo/ && cd javalin-demo && bash start.sh &
curl localhost:7000
echo "Script completado!..."

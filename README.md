# Repositorio para la prueba de concepto de Vitualhost y Proxy Reverso

En una instancia basada en Amazon Linux, clonar el proyecto actual y ejecutar los siguientes comandos para instalación básica:

### Ubuntu:

`
wget https://raw.githubusercontent.com/vacax/virtualhost-proxyreverso/master/basico-ubuntu.sh && chmod +x basico-ubuntu.sh && bash basico-ubuntu.sh
`

### Amazon Linux 2:
`
wget https://raw.githubusercontent.com/vacax/virtualhost-proxyreverso/master/basico.sh && chmod +x basico.sh && bash basico.sh
`

Una vez terminado el script, salga de la terminar y vuelva a conectarse. Validar que los siguientes comandos:

**Comando Java:**

`
java -version
`

![java](imagenes/java.png)

**Comando Nmap:**

`
nmap localhost
`

![nmap](imagenes/nmap.png)

**Comando Free:**

`
free 
`

![free](imagenes/free.png)

En este punto tenemos disponible todas las herramientas necesarias instaladas.

### **Configurando Virtualhost**

Es necesario contar con un servicio DNS, para poder registrar los registro tipo A, 
apuntando a la dirección IP de la máquina asignada en Amazon. En el archivo ``virtualhost.conf`` 
en la ruta de ``/etc/apache2/sites-available/``, deben cambio el valor ``CAMBIAR`` por la IP, ver imágenes.

![amazon-ip](imagenes/ip-amazo.png)

![archivo virtual host](imagenes/virtualhost.png)

Una vez modificado ejecutar el comando: 
```
sudo service apache2 reload
```

### **Configurando Proxy Reverso**

Ver el archivo ``/etc/apache2/sites-available/proxyreverso.conf``, y sustituir el valor ``CAMBIAR``. Ver imagen.

![Proxy Reverso](imagenes/proxyreverso.png)

Una vez modificado ejecutar el comando:
```
sudo service apache2 reload
```

### **Configurando Proxy Reverso y Seguridad**

Ver el archivo ``/etc/apache2/sites-available/seguro.conf``, y sustituir el valor ``CAMBIAR``. Ver imagen.

![Seguridad y Proxy](imagenes/seguridad.png)

Una vez modificado ejecutar el comando:
```
sudo service apache2 reload
```
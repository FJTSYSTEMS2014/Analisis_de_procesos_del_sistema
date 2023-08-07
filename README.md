# Analisis_de_procesos_del_sistema

##Pasos de Instalación- Resumen:

Dar permisos de ejecución al script: Asegúrate de darle permisos de ejecución al script utilizando el comando chmod:
   chmod +x  procesosSistema.sh
   
Instalar requisitos: Para instalar los paquetes necesarios, utiliza los siguientes comandos:
  sudo apt update
  sudo apt install bash clamav tcpdump wireshark
  
Ejecutar el script: Ahora puedes ejecutar el script utilizando el siguiente comando:
  ./nombre_del_script.sh


##Analisis de procesos del sistema:

Para que el programa funcione en Kali Linux, necesitarás asegurarte de que se cumplan los siguientes requisitos:

Bash: Asegúrate de tener el intérprete de Bash instalado en Kali Linux. Por defecto, Kali Linux incluye Bash, pero si no lo tienes, puedes instalarlo ejecutando el siguiente comando:

sudo apt update
sudo apt install bash


ClamAV: El programa utiliza el antivirus ClamAV para escanear en busca de malware conocido. Si no lo tienes instalado, puedes instalarlo utilizando los siguientes comandos:

sudo apt update
sudo apt install clamav


Tcpdump y Tshark: Necesitarás las herramientas Tcpdump y Tshark para capturar y analizar el tráfico de red sospechoso. Puedes instalarlas con los siguientes comandos:

sudo apt update
sudo apt install tcpdump wireshark

Privilegios de superusuario: Algunas de las funciones utilizan comandos que requieren privilegios de superusuario (root). Asegúrate de ejecutar el script como root o utilizar sudo cuando sea necesario.

Sí, antes de ejecutar un script bash (.sh) en Kali Linux, es posible que necesites asignar permisos de ejecución al archivo. Esto se hace utilizando el comando chmod (change mode).Para darle permisos de ejecución al script, abre una terminal y navega al directorio donde se encuentra el archivo .sh. Luego, ejecuta el siguiente comando:

chmod +x  procesosSistema.sh

Una vez que hayas verificado que cumplas con estos requisitos, puedes ejecutar el programa utilizando el siguiente comando:

./procesosSistema.sh
otra opcion:
bash procesosSistema.sh

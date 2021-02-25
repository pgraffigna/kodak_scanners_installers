#!/bin/bash
#script para instalar scanner ir2420/ir2620 en Ubuntu 20.04 64 bits

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
blueColor="\e[0;34m\033[1m"
purpleColor="\e[0;35m\033[1m"
endColor="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

#variables globales
URL_64=https://resources.kodakalaris.com/docimaging/drivers/LinuxSoftware_i2000_v4.14.x86_64.deb.tar.gz

echo -e "${yellowColor}Instalando programas ${endColor}"
sudo apt update; sudo apt install -y simple-scan

echo -e "\n${yellowColor}Descargando instaladores ${endColor}"
wget -q "$URL_64"

echo -e "\n${yellowColor}Descomprimiendo el gz ${endColor}"
gunzip LinuxSoftware_i2000_v4.14.x86_64.deb.tar.gz

echo -e "\n${yellowColor}Descomprimiendo el tar ${endColor}"
mkdir -p tar 2>/dev/null && tar -xf LinuxSoftware_i2000_v4.14.x86_64.deb.tar -C tar && cd tar

echo -e "\n${yellowColor}Corriendo el script ${endColor}"
sudo ./setup

echo -e "\n${yellowColor}Reparando la instalacion ${endColor}"
sudo apt --fix-broken install

echo -e "\n${yellowColor}Reparando las dependencias ${endColor}"
sudo dpkg --ignore-depends=multiarch-support -i libudev0_175-0ubuntu19_amd64.deb

echo -e "\n${yellowColor}Corriendo el script una vez mas ${endColor}"
sudo ./setup

echo -e "\n${yellowColor}Creando link simbolico ${endColor}"
sudo ln -sfr /usr/lib/sane/libsane-kds* /usr/lib/x86_64-linux-gnu/sane

echo -e "\n${yellowColor}Evitando que el paquete 'libudev0' se actualice porque sino deja de funcionar el scanner ${endColor}"
sudo apt-mark hold libudev0

echo -e "\n${greenColor}Drivers instalados conectar por USB y probar!!! ${endColor}"




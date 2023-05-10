#!/bin/bash

# Table Color
ColorGreen="\e[0;32m\033[1m"
EndColor="\033[0m\e[0m"
ColorRed="\e[0;31m\033[1m"
ColorBlue="\e[0;34m\033[1m"
ColorYellow="\e[0;33m\033[1m"
ColorPurpure="\e[0;35m\033[1m"
ColorTurquesa="\e[0;36m\033[1m"
ColorGray="\e[0;37m\033[1m"

# Variables Globales
ip_address=$2

ip_verify="^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"

# Ctrl + C
function ctrl_c(){
  echo -e "\n$ColorRed[!]$EndColor$ColorGray Saliendo...$EndColor\n"
  exit 1
}
trap ctrl_c SIGINT

# helPpanel
function helPpanel(){
  
  echo -e "$ColorTurquesa
    #                        #     #                                        
   # #   #    # #####  ####  ##    # #    #   ##   #####       ####  #    # 
  #   #  #    #   #   #    # # #   # ##  ##  #  #  #    #     #      #    # 
 #     # #    #   #   #    # #  #  # # ## # #    # #    #      ####  ###### 
 ####### #    #   #   #    # #   # # #    # ###### #####           # #    # 
 #     # #    #   #   #    # #    ## #    # #    # #      ###  #   # #    # 
 #     #  ####    #    ####  #     # #    # #    # #      ###  ####  #    #                                        
$EndColor"

  echo -e "$ColorTurquesa Uso:$EndColor\n"
  echo -e "$ColorGreen./AutoNmap$EndColor$ColorGray -h$EndColor      $ColorRed[!] Ver panel de ayuda$EndColor"
  echo -e "$ColorGreen./AutoNmap$EndColor$ColorGray -t <IP>$EndColor$ColorRed [!] Escaneo TCP rapido$EndColor"
  echo -e "$ColorGreen./AutoNmap$EndColor$ColorGray -T <IP>$EndColor$ColorRed [!] Escaneo TCP estandar$EndColor"
  echo -e "$ColorGreen./AutoNmap$EndColor$ColorGray -u <IP>$EndColor$ColorRed [!] Escaneo UDP$EndColor"
  echo -e "$ColorGreen./AutoNmap$EndColor$ColorGray -u <IP>$EndColor$ColorRed [!] Escaneo comun (solo nmap)$EndColor\n"
}

# AutoNmap_tcp_fast
function AutoNmap_tcp_fast(){
  if [[ $ip_address =~ $ip_verify ]]; then 
  
    echo -e "\n$ColorPurpure [!]$EndColor$ColorGray Analizando puertos...$EndColor"
    echo $ipaddress

    disC_Ports="$(sudo nmap -p- -sS --min-rate 5000 -n -Pn $ip_address -oN Ports | grep ^[1-9] | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')"
    echo -e "\n$ColorPurpure [+]$EndColor$ColorGray Los puertos han sido descubiertos...$EndColor"
    sleep 2
  
    echo -e "\n$ColorPurpure [!]$EndColor$ColorGray Analizando servicios...$EndColor"
    disC_Services="$(nmap -sCV -T4 -p$disC_Ports -Pn $ip_address -oN Services)"
    echo -e "\n$ColorYellow [+]$EndColor$ColorGray Los servicios han sido descubiertos...$EndColor"
    echo -e "\n$ColorYellow [!]$EndColor$ColorGray Revise el contenido de los archivos 'Services' y 'Ports, por si hay algun error$EndColor"

    sudo chown $(whoami):$(whoami) Ports
    sudo chown $(whoami):$(whoami) Services
  else
    echo -e "\n$ColorRed[!] Bad Syntax$EndColor\n"
  fi
}

# AutoNmap_tcp_stand
function AutoNmap_tcp_stand(){
  if [[ $ip_address =~ $ip_verify ]]; then 
  
    echo -e "\n$ColorPurpure[!]$ColorPurpure$ColorGray Analizando puertos...$EndColor"
    echo $ipaddress

    disC_Ports="$(sudo nmap -p- -T3 --min-rate 5000 $ip_address -oN Ports | grep ^[1-9] | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')"
    echo -e "\n$ColorPurpure[+]$EndColor$ColorGray Los puertos han sido descubiertos...$EndColor"
    sleep 2
  
    echo -e "\n$ColorPurpure[!]$EndColor$ColorGray Analizando servicios...$EndColor"
    disC_Services="$(nmap -sCV -T4 -p$disC_Ports -Pn $ip_address -oN Services)"
    echo -e "\n$ColorYellow[+]$EndColor$ColorGray Los servicios han sido descubiertos...$EndColor"
    echo -e "\n$ColorYellow[!]$EndColor$ColorGray Revise el contenido de los archivos 'Services' y 'Ports, por si hay algun error'$EndColor"

    sudo chown $(whoami):$(whoami) Ports
    sudo chown $(whoami):$(whoami) Services
  else
    echo -e "\n$ColorRed[!] Bad Syntax$ColorRed\n"
  fi
}

# AutoNmap_udp
function AutoNmap_upd(){
  if [[ $ip_address =~ $ip_verify ]]; then 
  
    echo -e "\n$ColorPurpure[!]$EndColor$ColorGray Analizando puertos...$EndColor"
    echo $ipaddress

    disC_Ports="$(sudo nmap -p- -sU --min-rate 5000 -n -Pn $ip_address -oN Ports | grep ^[1-9] | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')"
    echo -e "\n$ColorPurpure[+]$EndColor$ColorGray Los puertos han sido descubiertos...$EndColor"
    sleep 2
  
    echo -e "\n$ColorPurpure[!]$EndColor$ColorGray Analizando servicios...$EndColor"
    disC_Services="$(nmap -sCV -T4 -p$disC_Ports -Pn $ip_address -oN Services)"
    echo -e "\n$ColorYellow[+]$EndColor$ColorGray Los servicios han sido descubiertos...$EndColor"
    echo -e "\n$ColorYellow[!]$EndColor$ColorGray Revise el contenido de los archivos 'Services' y 'Ports, por si hay algun error$EndColor"

    sudo chown $(whoami):$(whoami) Ports
    sudo chown $(whoami):$(whoami) Services
  else
    echo -e "\n$ColorRed[!] Bad Syntax$EndColor\n"
  fi
}
# AutoNmap_comun
function AutoNmap_comun(){
  if [[ $ip_address =~ $ip_verify ]]; then 
  
    echo -e "\n$ColorPurpure[!]$EndColor$ColorGray Analizando puertos...$EndColor"
    echo $ipaddress

    disC_Ports="$(sudo nmap $ip_address -oN Ports | grep ^[1-9] | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')"
    echo -e "\n$ColorPurpure[+]$EndColor$ColorGray Los puertos han sido descubiertos...$EndColor"
    sleep 2
  
    echo -e "\n$ColorPurpure[!]$EndColor$ColorGray Analizando servicios...$EndColor"
    disC_Services="$(nmap -sCV -T4 -p$disC_Ports -Pn $ip_address -oN Services)"
    echo -e "\n$ColorYellow[+]$EndColor$ColorGray Los servicios han sido descubiertos...$EndColor"
    echo -e "\n$ColorYellow[!]$EndColor$ColorGray Revise el contenido de los archivos 'Services' y 'Ports, por si hay algun error$EndColor"

    sudo chown $(whoami):$(whoami) Ports
    sudo chown $(whoami):$(whoami) Services
  else
    echo -e "\n$ColorRed[!] Bad Syntax$EndColor\n"
  fi
}


# Indicadores
declare -i parameter_counter=0

# Menu
while getopts "h:tTun" arg; do
  case $arg in 
    t) let parameter_counter=+1;;
    T) let parameter_counter=+2;;
    u) let parameter_counter=+3;;
    n) let parameter_counter=+4;;
    h) ;;
  esac
done

if [ $parameter_counter == 1 ]; then 
  AutoNmap_tcp_fast $ip_address
elif [ $parameter_counter == 2 ]; then 
  AutoNmap_tcp_stand $ip_address
elif [ $parameter_counter == 3 ]; then 
  AutoNmap_upd $ip_address
elif [ $parameter_counter == 4 ]; then 
  AutoNmap_comun $ip_address  
else
  helPpanel
fi

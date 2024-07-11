#Colori
co1="\e[0;31m\033[1m"
co2="\e[0;33m\033[1m"
co3="\e[0;32m\033[1m"
co4="\e[0;36m\033[1m"
co5="\e[0;34m\033[1m"
co6="\e[0;35m\033[1m"
co8="\e[0;37m\033[1m"
endco="\033[0m\e[0m"
#Inizia
clear
echo -e "${co2}[+]${endco}${co8} Installando${co3} DuckDukGo${endco} dalla linea di commandi${endco}"
sudo apt-get install ddgr
echo -e "${co2}[+]${endco}${co8} per trovare risultati relativi alla pizza margherita usa:${endco}${co3} ddgr pizza margherita ${endco}" 

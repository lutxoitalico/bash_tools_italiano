#!/bin/bash
#Colori
co1="\e[0;31m\033[1m"
co2="\e[0;33m\033[1m"
co3="\e[0;32m\033[1m"
co4="\e[0;36m\033[1m"
co5="\e[0;34m\033[1m"
co6="\e[0;35m\033[1m"
co8="\e[0;37m\033[1m"
endco="\033[0m\e[0m"

echo -e "${co5}[+] ${endco}Installazione Electrum Wallet"
echo -e "${co5}[+] ${endco}Scarica Electrum AppImage"
wget https://download.electrum.org/4.5.5/electrum-4.5.5-x86_64.AppImage
echo -e "${co5}[+] ${endco}Scarica chiave asc"
wget https://download.electrum.org/4.5.5/electrum-4.5.5-x86_64.AppImage.asc
wget https://raw.githubusercontent.com/spesmilo/electrum/master/pubkeys/ThomasV.asc
sleep 1
echo -e "${co5}[+] ${endco}Importa chiave asc"
gpg --import ThomasV.asc
sleep 1
echo -e "${co5}[+] ${endco}Verifica firma asc"
gpg --verify electrum-4.5.5-x86_64.AppImage.asc
sleep 1
echo -e "${co5}[+] ${endco}Verifica AppImage"
gpg --verify electrum-4.5.5-x86_64.AppImage.asc electrum-4.5.5-x86_64.AppImage
rm *.asc
mv electrum-4.5.5-x86_64.AppImage electrum.AppImage
sudo chmod +x electrum.AppImage

echo -e "${co5}[+] ${endco}Run electrum.AppImage"

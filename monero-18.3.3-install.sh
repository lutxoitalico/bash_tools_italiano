#!/bin/bash
#Instalazione di Monero GUI Wallet V 18.3.3
#Colori
co1="\e[0;31m\033[1m"
co2="\e[0;33m\033[1m"
co3="\e[0;32m\033[1m"
co4="\e[0;36m\033[1m"
co5="\e[0;34m\033[1m"
co6="\e[0;35m\033[1m"
co8="\e[0;37m\033[1m"
endco="\033[0m\e[0m"
# Installazione e verifica
rm -rf monero-x86* binaryfate.asc hashes.txt monero*.tar.bz2

echo -e "${co5}[+] ${endco}Scarica le chiavi .asc"
wget -O binaryfate.asc https://raw.githubusercontent.com/monero-project/monero/master/utils/gpg_keys/binaryfate.asc
sleep 0.5 
echo " "
echo -e "${co5}[+] ${endco}Verifica le chiavi con GPG"
gpg --keyid-format long --with-fingerprint binaryfate.asc
sleep 0.5 
echo " "
echo -e "${co5}[+] ${endco}Importa le chiavi"
gpg --import binaryfate.asc
sleep 0.5 
echo " "
echo -e "${co5}[+] ${endco}Scarica HASHES.TXT"
wget -O hashes.txt https://www.getmonero.org/downloads/hashes.txt
sleep 0.5 
echo " "
echo -e "${co5}[+] ${endco}Verifica i HASH"
echo -e "${co5}[+] ${endco}${co1}Dovrebbe comparire GOOD SIGNATURE${endco}"
gpg --verify hashes.txt
sleep 0.5 
echo " "
echo -e "${co5}[+] ${endco}Dowload Monero GUI wallet v 18.3.3"
wget -O monero-gui-linux-x64-v0.18.3.3.tar.bz2 https://downloads.getmonero.org/gui/linux64
sleep 0.5 
echo " "
echo -e "${co5}[+] ${endco}HASH di monero-linux-x64-v0.18.3.3"
cat hashes.txt | grep monero-gui-linux-x64-v0.18.3.3.tar.bz2
sleep 0.5 
echo " "
echo -e "${co5}[+] ${endco}HASH di verifica"
shasum -a 256 monero-gui-linux-x64-v0.18.3.3.tar.bz2
sleep 0.5 
echo -e "${co5}[+] ${endco}Decomprime Monero GUI wallet v18.3.3"
tar -xf monero-gui-linux-x64-v0.18.3.3.tar.bz2 --verbose

rm binaryfate.asc hashes.txt monero*.tar.bz2

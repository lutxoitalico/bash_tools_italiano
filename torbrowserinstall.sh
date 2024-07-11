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
#Inizia
clear
echo -e "${co2}[+]${endco}${co8} Preparando l'installazione di Tor Browser${endco}"
sudo apt install curl xz-utils
rm -rf tor.* tor-* sta* Bro*
echo ""
#
echo -e "${co2}[+]${endco}${co8} Scaricando binari e firme${endco}"
wget https://www.torproject.org/dist/torbrowser/13.5.1/tor-browser-linux-x86_64-13.5.1.tar.xz
wget https://www.torproject.org/dist/torbrowser/13.5.1/tor-browser-linux-x86_64-13.5.1.tar.xz.asc
echo ""
#
echo -e "${co2}[+]${endco}${co8} Verificando firme${endco}"
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org
gpg --output ./tor.keyring --export EF6E286DDA85EA2A4BA7DE684E2C6E8793298290
gpgv --keyring ./tor.keyring ~/Downloads/tor-browser/tor-browser-linux-x86_64-13.5.1.tar.xz.asc ~/Downloads/tor-browser/tor-browser-linux-x86_64-13.5.1.tar.xz
curl -s https://openpgpkey.torproject.org/.well-known/openpgpkey/torproject.org/hu/kounek7zrdx745qydx6p59t9mqjpuhdf |gpg --import -
echo ""
#
echo -e "${co1}[!]${endco}${co8} Verifica se compare${endco}${co1} --- GOOD signature --- ${endco}${co8} prima di iniziare ad utilizzare Tor ${endco}"
sleep 3
echo ""
#
echo -e "${co2}[+]${endco}${co8} Extracting Tor${endco}"
tar -xf tor-browser-linux-x86_64-13.5.1.tar.xz
rm tor-browser-linux-x86_64-13.5.1.tar.xz
echo -e "${co2}[+]${endco}${co8}Esegui tor con ./start-tor-browser.desktop ${endco}"

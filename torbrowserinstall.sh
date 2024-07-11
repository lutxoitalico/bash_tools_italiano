#!/bin/bash
echo "[+] Preparando l'installazione di Tor Browser"
sudo apt install curl xz-utils
rm -rf tor.* tor-* sta* Bro*
echo "[+] Scaricando binari e firme"
wget https://www.torproject.org/dist/torbrowser/13.5.1/tor-browser-linux-x86_64-13.5.1.tar.xz
wget https://www.torproject.org/dist/torbrowser/13.5.1/tor-browser-linux-x86_64-13.5.1.tar.xz.asc
echo "[+] Verificando firme"
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org
gpg --output ./tor.keyring --export EF6E286DDA85EA2A4BA7DE684E2C6E8793298290
gpgv --keyring ./tor.keyring ~/Downloads/tor-browser/tor-browser-linux-x86_64-13.5.1.tar.xz.asc ~/Downloads/tor-browser/tor-browser-linux-x86_64-13.5.1.tar.xz
curl -s https://openpgpkey.torproject.org/.well-known/openpgpkey/torproject.org/hu/kounek7zrdx745qydx6p59t9mqjpuhdf |gpg --import -
echo "[!] Verifica se le firme sono corrette prima di iniziare ad utilizzare Tor"
sleep 3
echo "[+] Extracting TOR"
tar -xf tor-browser-linux-x86_64-13.5.1.tar.xz -v
rm tor-browser-linux-x86_64-13.5.1.tar.xz


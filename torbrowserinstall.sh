#!/bin/bash
echo "[+] Installando Tor"
sudo apt install curl xz-utils
echo "[+] Verificando firme"
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org
gpg --output ./tor.keyring --export EF6E286DDA85EA2A4BA7DE684E2C6E8793298290
gpgv --keyring ./tor.keyring ~/Downloads/tor-browser-linux-x86_64-13.0.15.tar.xz.asc ~/Downloads/tor-browser-linux-x86_64-13.0.15.tar.xz
curl -s https://openpgpkey.torproject.org/.well-known/openpgpkey/torproject.org/hu/kounek7zrdx745qydx6p59t9mqjpuhdf |gpg --import -
echo "[+] Extracting TOR"
tar -xf tor-browser-linux-x86_64-13.0.15.tar.xz -v
echo "[!] Verifica se le firme sono corrette prima di iniziare ad utilizzare Tor"

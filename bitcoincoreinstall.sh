te#!/bin/bash
#Instalazione di bitcoin-core-24.1
#Colori
co1="\e[0;31m\033[1m"
co2="\e[0;33m\033[1m"
co3="\e[0;32m\033[1m"
co4="\e[0;36m\033[1m"
co5="\e[0;34m\033[1m"
co6="\e[0;35m\033[1m"
co8="\e[0;37m\033[1m"
endco="\033[0m\e[0m"
   
function_limpieza(){
   #pulizia iniziale
   echo -e "${co5}[+] ${endco}${co8}Arresta Bitcoin core...${endco}"
   sudo bitcoin-cli stop > /dev/null
   sleep 3
   echo -e "${co5}[+] ${endco}${co8}Cancella Bitcoin core...${endco}"
   sudo rm -r -f /usr/local/bin/*
   sudo rm -r -f $HOME/.bitcoin/
}

function_herramientas(){
   #installare tools
   echo -e "${co5}[+] ${endco}${co8}Install tools necessari ${endco}"
   sudo apt-get install -y bc jq autoconf file gcc libc-dev make g++ pkgconf re2c git libtool automake gcc xxd figlet
   sleep 1
}

function_dowload_btc(){
   #scarica bitcoin files
   echo -e "${co5}[+] ${endco}${co8}Scarica Bitcoin core 24.1${endco}"
   wget https://bitcoincore.org/bin/bitcoin-core-24.1/bitcoin-24.1-x86_64-linux-gnu.tar.gz > /dev/null
   echo -e "${co5}[+] ${endco}${co8}Scarica checksum crittografico SHA256SUMS ${endco}"
   wget https://bitcoincore.org/bin/bitcoin-core-24.1/SHA256SUMS > /dev/null
   echo -e "${co5}[+] ${endco}${co8}Scarica firme checksum ${endco}"
   wget https://bitcoincore.org/bin/bitcoin-core-24.1/SHA256SUMS.asc > /dev/null 
   echo -e "${co5}[+] ${endco}${co8}Scarica l'elenco di firme ${endco}"
   git clone https://github.com/bitcoin-core/guix.sigs > /dev/null 
   sleep 1
}

function_verificar_firmas(){
   #verificare firme
   echo -e "${co5}[+] ${endco}${co8}Verifica lista di checksum ${endco}"
   shasum --ignore-missing --check SHA256SUMS
   echo -e "${co5}[+] ${endco}${co8}Importa tutte le firme ${endco}"
   gpg --import guix.sigs/builder-keys/*
   echo -e "${co5}[+] ${endco}${co8}Verifica il file checksum con varie firmas ${endco}"
   gpg --verify SHA256SUMS.asc
   echo -e "${co5}[!] ${endco}${co1}Verifica la validità delle fime con i corrispondenti svilupatori ! ${endco}"
sleep 4
}

function_unzip_clean(){
   #scompattare pachetto bitcoin core
   echo -e "\n${co5}[+] ${endco}${co8}Decomprime Bitcoin Core 24.1${endco}"
   tar xzf bitcoin-24.1-x86_64-linux-gnu.tar.gz -v
   sleep 1
   #pulire files
   echo -e "${co5}[+] ${endco}${co8}Elimina files temporanei ${endco}"
   rm -r -f SHA256SUMS  SHA256SUMS.asc  bitcoin-24.1-x86_64-linux-gnu.tar.gz  guix.sigs
   sleep 1 
}

function_instala(){
  #instalare binari
  echo -e "${co5}[+] ${endco}${co2}Installa Bitcoin Core 24.1 ${endco}"
  sudo install -m 0755 -o root -g root -t /usr/local/bin/ bitcoin-24.1/bin/*
  rm -r -f bitcoin*
  sleep 2
}

function_conf(){
  #creare file bitcoin.nconf
  mkdir $HOME/.bitcoin
  echo -e "regtest=1\nfallbackfee=0.0001\nserver=1\ntxindex=1" > $HOME/.bitcoin/bitcoin.conf
  echo $(cat $HOME/.bitcoin/bitcoin.conf)
  sleep 1
  echo -e "${co5}[!] ${endco}${co1}$(bitcoind --version | grep version ) ${endco}"
  echo -e "${co5}[+] ${endco}${co2}Contenuto del file bitcoin.conf ${endco}"
  cat $HOME/.bitcoin/bitcoin.conf 
}

function_limpieza
function_herramientas
function_dowload_btc
function_verificar_firmas
function_unzip_clean
function_instala
function_conf

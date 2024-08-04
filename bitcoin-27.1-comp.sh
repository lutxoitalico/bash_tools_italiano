#!/bin/bash
#Instalazione di bitcoin-core-27.1
#Colori
co1="\e[0;31m\033[1m"
co2="\e[0;33m\033[1m"
co3="\e[0;32m\033[1m"
co4="\e[0;36m\033[1m"
co5="\e[0;34m\033[1m"
co6="\e[0;35m\033[1m"
co8="\e[0;37m\033[1m"
endco="\033[0m\e[0m"

# Aggiorna sistema
   echo -e "${co5}[+] ${endco}${co8}Aggiorna il sistema...${endco}"
sudo apt update

sudo apt upgrade -y
# installa dependenncies
   echo -e "${co5}[+] ${endco}${co8}Installa tools necessari...${endco}"

sudo apt install net-tools git build-essential haveged gnupg dirmngr xxd autoconf autotools-dev automake pkg-config clang libboost-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libevent-dev libnatpmp-dev libminiupnpc-dev libsqlite3-dev libtool bsdmainutils python3 libssl-dev libzmq3-dev libprotobuf-dev protobuf-compiler ccache -y
# berkeley DB
   echo -e "${co5}[+] ${endco}${co8}Installa Berkeley DataBase...${endco}"

sudo apt install  libdb-dev -y

# interfaccia GUI
   echo -e "${co5}[+] ${endco}${co8}Installa GUI...${endco}"

sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools qtwayland5 libqrencode-dev -y

export BITCOIN="bitcoin-core-27.1"
export BITCOINPLAIN=`echo $BITCOIN | sed 's/bitcoin-core/bitcoin/'`

# scaricare bitcoin core 
   echo -e "${co5}[+] ${endco}${co8}Scarica codice fonte...${endco}"

wget https://bitcoincore.org/bin/$BITCOIN/$BITCOINPLAIN.tar.gz
# scaricare anche le firme
   echo -e "${co5}[+] ${endco}${co8}Scarica le firme SHA256...${endco}"

wget https://bitcoincore.org/bin/$BITCOIN/SHA256SUMS.asc
wget https://bitcoincore.org/bin/$BITCOIN/SHA256SUMS

# Clonare il repositorio con le chiavi
   echo -e "${co5}[+] ${endco}${co8}Scarica il repositorio con le chiavi...${endco}"

git clone https://github.com/bitcoin-core/guix.sigs.git
for file in ./guix.sigs/builder-keys/*.gpg; do gpg --import "$file"; done

# Verificare l'autenticita SHA256SUMS
   echo -e "${co5}[+] ${endco}${co8}Verifica autenticità...${endco}"

export SHASIG=`gpg --verify SHA256SUMS.asc SHA256SUMS 2>&1 | grep "Good signature"`
export SHACOUNT=`gpg --verify SHA256SUMS.asc SHA256SUMS 2>&1 | grep "Good signature" | wc -l`

if [[ "$SHASIG" ]]
then
    echo "$0 - Verifica di firma corretta: Trovate $SHACOUNT firme."
    echo "$SHASIG"
else
    (>&2 echo "$0 - Errore di verifica: Non si è potuto verificare il file SHA256SUMS")
fi

# cerca nella local directory i files nel SHA256SUMS e verifica
   echo -e "${co5}[+] ${endco}${co8}Verifica files SHASUM...${endco}"

export SHACHECK=`sha256sum -c --ignore-missing < SHA256SUMS 2>&1 | grep "OK"`

if [ "$SHACHECK" ]
then
   echo "$0 - Esito positivo. Comprovati i files: $SHACHECK"
else
    (>&2 echo "$0 - Verifica di SHA negativa!")
fi

# Estrae il códice fonte
   echo -e "${co5}[+] ${endco}${co8}Estrae il codice fonte...${endco}"

tar xzf $BITCOINPLAIN.tar.gz
cd $BITCOINPLAIN
sleep 3
clear
# Compila Bitcoin Core
   echo -e "${co5}[+] ${endco}${co8}Compila il codice fonte di Bitcoin Core...${endco}"

./autogen.sh
./configure
make -j 2

# Esegue i tests di verifica
sleep 3
   echo -e "${co5}[+] ${endco}${co8}Esegue i test di verifica...${endco}"

make check
./test/functional/test_runner.py --extended

# Estrae i binari compilati a un file tar
   echo -e "${co5}[+] ${endco}${co8}Compila il codice fonte di Bitcoin Core...${endco}"
tar --transform 's/.*\///g' -czf ../$BITCOINPLAIN-compiled.tar.gz ./src/bitcoin-wallet ./src/bitcoin-tx ./src/bitcoin-util ./src/bitcoind ./src/bitcoin-cli ./src/qt/bitcoin-qt

# cancella il código fonte e gli altri files scaricati
cd ..
rm -fr $BITCOINPLAIN $BITCOINPLAIN.tar.gz guix.sigs SHA256SUMS.asc SHA256SUMS


#!/bin/bash
#Pratica Bitcoin Regtest.
#Colori
co1="\e[0;31m\033[1m"
co2="\e[0;33m\033[1m"
co3="\e[0;32m\033[1m"
co4="\e[0;36m\033[1m"
co5="\e[0;34m\033[1m"
co6="\e[0;35m\033[1m"
co8="\e[0;37m\033[1m"
endco="\033[0m\e[0m"

functionClean(){
   clear
   sleep 1 
   echo -e "${co5}[!] ${endco}${co2}Stop Bitcoin Core${endco}"
   bitcoin-cli stop &> /dev/null 
   echo -e "${co5}[!] ${endco}${co2}Elimina files temporanei di REGTEST${endco}"
   rm -r -f ~/.bitcoin/regtest/
   sleep 5
}

functionStart(){
   echo -e "${co5}[+] ${endco}${co8}Restart Bitcoin Core${endco}"
     bitcoind -daemon
   echo -e "\t\t\t\t\t\t${co5}$(bitcoind --version | grep version)${endco}"
     sleep 3
   echo -e "${co5}[+] ${endco}${co8}Blockchain: ${endco}${co3}\t\t\t\t$(bitcoin-cli getblockchaininfo | jq -r .chain ) ${endco}"
 }

functionWalletMinatore(){
   
   echo -e "${co5}[+] ${endco}${co8}Creando wallet Minatore ${endco}"
     bitcoin-cli -named createwallet wallet_name="Minatore" > /dev/null
     walletAddressMinatore=$(bitcoin-cli -rpcwallet=Minatore getnewaddress "Wallet del Miner")
   echo -e "${co5}[+] ${endco}${co8}Nueva Wallet Minatore: \t\t\t${endco}${co3}$walletAddressMinatore ${endco}"
     sleep 1 
}

fuctionWalletTrader(){
   echo -e "${co5}[+] ${endco}${co8}Creando wallet del Trader ${endco}"
     bitcoin-cli -named createwallet wallet_name="Trader" > /dev/null
     walletAddressTrader=$(bitcoin-cli -rpcwallet=Trader getnewaddress "Wallet del Trader")
   echo -e "${co5}[+] ${endco}${co8}Nueva Wallet Trader: \t\t\t${endco}${co3}$walletAddressTrader ${endco}"
     sleep 1
}


functionMining110(){
   # Minare 110 blocchi e verificare balance del miner

   echo -e "\n${co5}[+] ${endco}${co8}Blockheight: \t\t\t\t${endco}${co3}$(bitcoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | tr ',' ' ')${endco}"
   echo -e "${co5}[+] ${endco}${co8}Balance: \t\t\t\t\t${endco}${co3}$(bitcoin-cli -rpcwallet=Minatore getbalance | bc)${endco}"
   echo -e "${co5}[+] ${endco}${co2}Minando 110 blocchi...${endco}"
     bitcoin-cli generatetoaddress 110 ${walletAddressMinatore} > /dev/null
   echo -e "\n${co5}[+] ${endco}${co8}Blockheight: \t\t\t\t${endco}${co3}$(bitcoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | tr ',' ' ')${endco}"
   echo -e "${co5}[+] ${endco}${co8}Balance: \t\t\t\t\t${endco}${co3}$(bitcoin-cli -rpcwallet=Minatore getbalance | bc)${endco}"
     sleep 1
}

transazione20(){
   echo -e "\n${co5}[+] ${endco}${co8}Informazione preliminare: ${endco}"
   echo -e   "${co5}[+] ${endco}${co8}Saldo nella wallet del Minatore: \t\t${endco}${co3}$(bitcoin-cli -rpcwallet=Minatore getbalance | bc)${endco}"
   echo -e   "${co5}[+] ${endco}${co8}Saldo nella wallet del Trader: \t\t${endco}${co3}$(bitcoin-cli -rpcwallet=Trader getbalance | bc)${endco}"
   # Transazione: Il Minatore invia 20 bitcoin al Trader
   txMinatoreTrader=$(bitcoin-cli -rpcwallet=Minatore sendtoaddress "$walletAddressTrader" 20)

   echo -e "\n${co5}[+] ${endco}${co8}Invio di 20 BTC al trader...${endco}"
   echo -e   "${co5}[+] ${endco}${co8}Hash di transazione Minatore -> trader \t${endco}${co3}$txMinatoreTrader${endco}"
}

busquedaMempool(){
   mempoolTx=$(bitcoin-cli getmempoolentry $txMinatoreTrader | jq -r .unbroadcast )
   echo -e "${co5}[+] ${endco}${co8}Stato della transazione nella mempool: \t${endco}${co3}$mempoolTx${endco} "
   sleep 1
}

functionmining5(){
   # Minare 5 blocchi e verificare balance del miner  
   echo -e "\n${co5}[+] ${endco}${co8}Blockheight: \t\t\t\t${endco}${co3}$(bitcoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | tr ',' ' ')${endco}"
   echo -e "${co5}[+] ${endco}${co8}Balance: \t\t\t\t\t${endco}${co3}$(bitcoin-cli -rpcwallet=Minatore getbalance | bc)${endco}"
   echo -e "${co5}[+] ${endco}${co2}Minando 110 blocchi...${endco}"
     bitcoin-cli generatetoaddress 5 $walletAddressMinatore
   echo -e "${co5}[+] ${endco}${co8}Blockheight: \t\t\t\t${endco}${co3}$(bitcoin-cli getblockchaininfo | grep blocks | awk '{print $2}' | tr ',' ' ')${endco}"
   echo -e "${co5}[+] ${endco}${co8}Balance: \t\t\t\t\t${endco}${co3}$(bitcoin-cli -rpcwallet=Minatore getbalance | bc)${endco}"
     sleep 1
 } 

transazioneDettagliata(){
   #Transazione Minatore - Trader
   echo -e "\n${co5}[+] ${endco}${co8}Transazione dettagliata: ${endco}"
   txMinatore=$(bitcoin-cli -rpcwallet=Minatore gettransaction $txMinatoreTrader)
   txMinatoreRaw=$(bitcoin-cli -rpcwallet=Minatore getrawtransaction $txMinatoreTrader)
   txMinatoreDecoded=$(bitcoin-cli decoderawtransaction $txMinatoreRaw)
   txidMinatoreFrom=$(echo $txMinatoreDecoded | jq -r .vin[0].txid )
   txParent=$(bitcoin-cli -rpcwallet=Minatore gettransaction $txidMinatoreFrom)
   txMinatoreFromAddress0=$(echo $txMinatoreDecoded | jq -r  .vout[0].scriptPubKey.address )
   MinatoreFromAddressAmount0=$(echo $txMinatoreDecoded | jq  .vout[0].value )
   txMinatoreFromAddress1=$(echo $txMinatoreDecoded | jq -r  .vout[1].scriptPubKey.address )
   MinatoreFromAddressAmount1=$(echo $txMinatoreDecoded | jq  .vout[1].value )
   walletMinatoreAddressFrom=$(echo $txParent | jq -r .details[0].address )
   walletMinatoreFromAmount=$(echo $txParent | jq .details[0].amount )
   txFee=$(echo "$walletMinatoreFromAmount - $MinatoreFromAddressAmount1 - $MinatoreFromAddressAmount0" | bc )
#  echo -e "${co5}[+] ${endco}${co8}Transaction ID: \t\t${endco}${co3}$txidMinatoreFrom ${endco}"           #############

   echo -e "\n${co5}[+] ${endco}${co8}Dettaglio TX wallet Minatore: ${endco}"
   echo -e "${co5}[+] ${endco}${co8}Address UTXO Origin \t\t\t${endco}${co3}$walletMinatoreAddressFrom ${endco}"
   echo -e "${co5}[+] ${endco}${co8}Original balance\t\t\t\t${endco}${co3}$walletMinatoreFromAmount ${endco}"
   echo -e "${co5}[+] ${endco}${co8}Send to Wallet Address \t\t\t${endco}${co3}$txMinatoreFromAddress0 ${endco}"
   echo -e "${co5}[+] ${endco}${co8}Importo \t\t\t\t\t${endco}${co3}$MinatoreFromAddressAmount0 ${endco}"
   echo -e "${co5}[+] ${endco}${co8}Send to Wallet Address \t\t\t${endco}${co3}$txMinatoreFromAddress1 ${endco}"
   echo -e "${co5}[+] ${endco}${co8}Importo \t\t\t\t\t${endco}${co3}$MinatoreFromAddressAmount1 ${endco}"
   echo -e "${co5}[+] ${endco}${co8}Fee \t\t\t\t\t${endco}${co3}$txFee ${endco}"

   sleep 1
   
   txTrader=$(bitcoin-cli -rpcwallet=Trader gettransaction $txMinatoreTrader)
   txTraderId=$(echo $txTrader | jq -r .txid )
   txTraderAmount=$(echo $txTrader | jq .amount )
   txTraderAddress=$(echo $txTrader | jq -r .details[0].address )
   txConfirmations=$(echo $txTrader | jq -r .confirmations )

   echo -e "\n${co5}[+] ${endco}${co8}Dettaglio TX wallet Trader: ${endco}"
   echo -e "${co5}[+] ${endco}${co8}Transaction ID: \t\t\t\t${endco}${co3}$txTraderId${endco}"
   echo -e "${co5}[+] ${endco}${co8}Wallet Address: \t\t\t\t${endco}${co3}$txTraderAddress${endco}"
   echo -e "${co5}[+] ${endco}${co8}Importo ricevuto: \t\t\t\t${endco}${co3}$txTraderAmount${endco}"
   echo -e "${co5}[+] ${endco}${co8}Confirmations: \t\t\t\t${endco}${co3}$txConfirmations${endco}"
   sleep 1
 }

functionClean
functionStart
functionWalletMinatore
functionWalletTrader
functionMining110
functionMining5
transazione20
busquedaMempool
mining5blocks
transazioneDettagliata

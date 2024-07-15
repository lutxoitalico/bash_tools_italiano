#!/bin/bash
#Colours
c01="\e[0;31m\033[1m"
c02="\e[0;33m\033[1m"
c03="\e[0;32m\033[1m"
c04="\e[0;36m\033[1m"
c05="\e[0;34m\033[1m"
c06="\e[0;35m\033[1m"
c07="\e[0;37m\033[1m"
endC="\033[0m\e[0m"
#Colours
clear
cpuInfo=$(cat /proc/cpuinfo | grep "model name" | awk $'{print $4,$5,$6,$7,$8,$9,$10,$11,$12}' | tail -n 1 )
videoInfo=$(inxi -G | grep Wani | awk $'{print $2,$3,$4,$5,$6}' )
temp=$(sensors | grep temp1: | awk $'{print $2}')
sfwInfo=$(cat /etc/os-release | grep PRETTY_NAME= | cut -d '=' -f2 ) 
ipPort=$(ip a | grep enp2 | tail -1 | awk $'{print $2}' | cut -d '/' -f 1 )
backSfwDet=$(screen -ls | grep 'Detached\|Attached' | awk $'{print $1,$4 }')
linuxuptime=$(uptime | awk $'{print $3,$4,$5}')
diskfreesp=$(df -H | grep sda2 | awk $'{print $4}')

echo -e "\n${c02}[!]${endC}${c07} PC Status${endC}"
echo -e "\n${c05}[+]${endC}${c07} User name:\t\t\t${endC}${c03}$(whoami)${endC}"
sleep 1
echo -e "${c05}[+]${endC}${c07} Processor:      \t\t${endC}${c03}$cpuInfo ${endC}"
sleep 0.2
echo -e "${c05}[+]${endC}${c07} Video:          \t\t${endC}${c03}$videoInfo ${endC}"
sleep 0.2
echo -e "${c05}[+]${endC}${c07} Temperature:    \t\t${endC}${c03}$temp${endC}"
sleep 0.2
echo -e "${c05}[+]${endC}${c07} Software:       \t\t${endC}${c06}$sfwInfo ${endC}"
sleep 0.2
echo -e "${c05}[+]${endC}${c07} IP Port:        \t\t${endC}${c03}$ipPort${endC}"
sleep 0.2
echo -e "${c05}[+]${endC}${c07} Uptime:         \t\t${endC}${c03}$linuxuptime${endC}"
sleep 0.2
echo -e "${c05}[+]${endC}${c07} Free disk space:\t\t${endC}${c03}$diskfreesp${endC}"
echo " "

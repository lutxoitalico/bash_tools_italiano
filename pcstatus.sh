#!/bin/bash
#Colours
co1="\e[0;31m\033[1m"
co2="\e[0;33m\033[1m"
co3="\e[0;32m\033[1m"
co4="\e[0;36m\033[1m"
co5="\e[0;34m\033[1m"
co6="\e[0;35m\033[1m"
co7="\e[0;37m\033[1m"
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

echo -e "\n${co2}[!]${endC}${co7} PC Status${endC}"
echo -e "\n${co5}[+]${endC}${co7} User name:\t\t\t${endC}${co3}$(whoami)${endC}"
sleep 1
echo -e "${co5}[+]${endC}${co7} Processor:      \t\t${endC}${co3}$cpuInfo ${endC}"
sleep 0.2
echo -e "${co5}[+]${endC}${co7} Video:          \t\t${endC}${co3}$videoInfo ${endC}"
sleep 0.2
echo -e "${co5}[+]${endC}${co7} Temperature:    \t\t${endC}${co3}$temp${endC}"
sleep 0.2
echo -e "${co5}[+]${endC}${co7} Software:       \t\t${endC}${co6}$sfwInfo ${endC}"
sleep 0.2
echo -e "${co5}[+]${endC}${co7} IP Port:        \t\t${endC}${co3}$ipPort${endC}"
sleep 0.2
echo -e "${co5}[+]${endC}${co7} Uptime:         \t\t${endC}${co3}$linuxuptime${endC}"
sleep 0.2
echo -e "${co5}[+]${endC}${co7} Free disk space:\t\t${endC}${co3}$diskfreesp${endC}"
echo " "

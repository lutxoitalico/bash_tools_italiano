#!/bin/bash

# Esercizio 01

 # ESERCIZIO:
 # - Crea esempi utilizzando tutti i tipi di operatori nel tuo linguaggio preferito:
 # Aritmetica, logica, confronto, assegnazione, identità, appartenenza, bit...
 # (Tieni presente che ogni lingua può averne di diverse)
 # - Utilizzando le operazioni con gli operatori che desideri, crea degli esempi
 # che rappresentano tutti i tipi di strutture di controllo esistenti
 # nella tua lingua:
 # Condizionali, iterative, eccezioni...
 # - È necessario stampare il risultato di tutti gli esempi tramite la console.
 #
 # DIFFICOLTÀ EXTRA (facoltativo):
 # Creare un programma che stampi tramite la console tutti i numeri inseriti
 # compreso tra 10 e 55 (compresi), pari, e che non siano né 16 né multipli di 3.
 #
 # Sicuramente esaminando attentamente le possibilità hai scoperto qualcosa di nuovo.

clear
echo "------------------------"
echo "Esempio dei 4 operatori: somma sottrazione moltiplicazione divisione"

  echo "Somma 6.33333 + 2 = " 
  bc <<< "scale=4; 6.33335 + 2"
  echo "Sottrazione 6.33333 - 2 = "
  awk "BEGIN {print 6.33333-2}"
  echo "Moltiplicazione 6.33333 * 2 = " 
  python3 -c "print (6.3*2)"
  echo "Divisione 6.33333 / 2 = " 
  bc <<< "scale=2;6.33333/2"
  echo "Modulo, resto de 6.33333 / 2 = " 
  bc <<< "scale=2;6.33333%2"
  echo "esponenciale"
  bc <<< "scale=2;10**3"
  echo "divisione intera"
  bc <<< "scale=2;10//3"

sleep 1
echo "------------------------"
echo "Alternativa, operatori con variabili"

  a=8
  b=3
 
  echo "Somma ($a + $b): $((a + b))"
  echo "Sottrazione ($a - $b): $((a - b))"
  echo "Moltiplicazione ($a * $b): $((a * b))"
  echo "Divisione ($a / $b): $((a / b))"
  echo "Resto ($a % $b): $((a % b))"

sleep 1
echo "------------------------"
echo "Operatori de comparazione o di confronto"

  echo "Operatori di confronto:"
  echo "Uguale a ($a == $b) es: $((a == b))"
  echo "Diverso da ($a != $b) es: $((a != b))"
  echo "Minore di: ($a < $b) es: $((a < b))"
  echo "Maggiore di: ($a > $b) es: $((a < b))"
  echo "Maggiore o uguale a: ($a >= $b) es $((a >= b))"
  echo "Minore o uguale a: ($a <= $b) es $((a <= b))"

sleep 1
echo "------------------------"
echo "Operatori logici" 

  echo "AND &&: ($a != $b) && ($a > $b) es $(( a != b && a > b))"
  echo "OR ||: ($a != $b) || ($a > $b) es $(( a != b || a > b))"
  echo "NOT !: !($a != $b) es $(( ! (a != b) ))"

sleep 1
echo "------------------------"
echo "Operatori di assegnazione"

a=10
b=5
echo "Prima: $a"
a=$((a + 5))
echo "Dopo: $a"
a=$((a -= b))  #sostrazione e assegnazione
a=$((a *= b))  #moltiplicazione e assegnazione
a=$((a /= b))  #divisione e assegnazione
a=$((a %= b))  #modulo e assegnazione
#a=$((a **= b)) #esponenziale e assegnazione
#a=$((a //= b)) #divisione intera e assegnazione

sleep 1
echo "------------------------"
echo "Operatori di assegnazione con let"

mia_var=5
echo $mia_var

let mia_var+=1 
echo "somma e assegnazione"
echo $mia_var
let mia_var-=1 
echoi "sostrazione e assegnazione"
echo $mia_var
let mia_var*=2 
echo "moltiplicazione e assegnazione"
echo $mia_var
let mia_var/=2 
echo "divisione e assegnazione"
echo $mia_var 
let mia_var%=3 
echo "modulo e assegnazione"
echo $mia_var 

sleep 1
echo "------------------------"
echo "Condizionali if elif else fi "

if [ $a -lt $b ]; then
    echo "$a e minore di $b"
elif [ $a -eq $b ];then
    echo "$a e uguale a $b"
else [ $a -gt $b ];
    echo  "$a e maggiore di $b"
fi


echo "Equivalenza die condizionali"
echo "        -gt     >       maggiore "
echo "        -lt     <       minore "
echo "        -ge     >=      maggiore o uguale "
echo "        -le     <=      minore o uguale "
echo "        -eq     ==      uguale "
echo "        -ne     !=      non uguale "


echo "test: Mostrare sequenza da 10 a 55 ma non mostrare numeri pari, ne il n16, ne i numeri multiplo da 3"

for numero in $(seq 10 55); do
    if [ $((numero % 2)) -eq 0 ] && [ $((numero)) -ne 16 ] &&  [ $((numero % 3)) -ne 0 ]; then
    echo "$numero"
    fi
done

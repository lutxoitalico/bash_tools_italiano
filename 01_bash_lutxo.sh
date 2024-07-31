#!/bin/bash

# Ejercicio 01

 # EJERCICIO:
 # - Crea ejemplos utilizando todos los tipos de operadores de tu lenguaje:
 #   Aritméticos, lógicos, de comparación, asignación, identidad, pertenencia, bits...
 #   (Ten en cuenta que cada lenguaje puede poseer unos diferentes)
 # - Utilizando las operaciones con operadores que tú quieras, crea ejemplos
 #   que representen todos los tipos de estructuras de control que existan
 #   en tu lenguaje:
 #   Condicionales, iterativas, excepciones...
 # - Debes hacer print por consola del resultado de todos los ejemplos.
 #
 # DIFICULTAD EXTRA (opcional):
 # Crea un programa que imprima por consola todos los números comprendidos
 # entre 10 y 55 (incluidos), pares, y que no son ni el 16 ni múltiplos de 3.
 #
 # Seguro que al revisar detenidamente las posibilidades has descubierto algo nuevo.

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

echo "------------------------"
echo "Alternativa, operatori con variabili"

  a=8
  b=3
  echo "Suma ($a + $b): $((a + b))"
  echo "Resta ($a - $b): $((a - b))"
  echo "Multiplicación ($a * $b): $((a * b))"
  echo "División ($a / $b): $((a / b))"
  echo "Módulo ($a % $b): $((a % b))"

echo "------------------------"
echo "Operatori de comparazione o di confronto"

  echo "Operatori di confronto:"
  echo "Uguale a ($a == $b) es: $((a == b))"
  echo "Diverso da ($a != $b) es: $((a != b))"
  echo "Minore di: ($a < $b) es: $((a < b))"
  echo "Maggiore di: ($a > $b) es: $((a < b))"
  echo "Maggiore o uguale a: ($a >= $b) es $((a >= b))"
  echo "Minore o uguale a: ($a <= $b) es $((a <= b))"

echo "------------------------"
echo "Operatori logici" 

  echo "AND &&: ($a != $b) && ($a > $b) es $(( a != b && a > b))"
  echo "OR ||: ($a != $b) || ($a > $b) es $(( a != b || a > b))"
  echo "NOT !: !($a != $b) es $(( ! (a != b) ))"

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

my_variable=5
echo $my_variable
let my_variable+=1
echo $my_variable
let my_variable-=1
echo $my_variable
let my_variable*=2
echo $my_variable
let my_variable/=2
echo $my_variable 
let my_variable%=3
echo $my_variable 


echo "------------------------"
echo "Condizionali"

if [ $a -lt $b ]; then
    echo "$a e minore di $b"
elif [ $a -eq $b ];then
    echo "$a e uguale a $b"
else [ $a -gt $b ];
    echo  "$a e maggiore di $b"
fi


echo "Condizionalila equivalencia de condicionales es"
echo "        -gt     >       mayor "
echo "        -lt     <       menor "
echo "        -ge     >=      mayor o igual "
echo "        -le     <=      menor o igual "
echo "        -eq     ==      igual "
echo "        -ne     !=      distinto "


echo "test: Mostrare sequenza da 10 a 55, non mostrare numeri pari, ne il n16, ne i numeri multiplo da 3"

for numero in $(seq 10 55); do
    if [ $((numero % 2)) -eq 0 ] && [ $((numero)) -ne 16 ] &&  [ $((numero % 3)) -ne 0 ]; then
    echo "$numero"
    fi
done

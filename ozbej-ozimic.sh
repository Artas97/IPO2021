#!bin/bash

# preveri ali je število ponovitev podano kot argument

if [ "$#" -ne 1 ]; then
	echo "Uporaba: $0 <število ponovitev>"
	exit 1
fi

# nastavi ime in pot do datoteke

datoteka=$(date + %d_%m_%Y).txt
pot=$(pwd)/$datoteka

# če datoteka ne obstaja, jo ustvari
if [ ! -f $pot ]; then
	touch $pot
fi

# zanka za ponavljanje
for ((i=1; i<=$1; i++))
do
	# preveri če ma računalnik dostop do interneta
	ping -q -c 1 google.com > /dev/null 2>&1
	if [ $? -eq 0]; then
		# dobimo ip naslov
		ip=$(ifconfig | grep 'inet' | awk '{print $2}')
	else
		ip="CONNECTION ERROR"
	fi

# dobimo trenutni čas in uporabniško ime
cas=$(date + %H:%M:%S)
uporabnik=$(whoami)

#izpisemo samo naslovni prostor in 1 poljubno informacijo o sistemu
naslovni_prostor=$(hostname)

# zapišemo podatke v datoteko
echo "$cas $ip $uporabnik $naslovni_prostor 1 poljubna informacija" >> $pot

# počakamo 1 minuto če je to zahtevano
if [ $i -lt $1 ]; then
	sleep 60
fi
done

#izpišemo zadnjih 5 vrstic datoteke

tail -n 5 $pot

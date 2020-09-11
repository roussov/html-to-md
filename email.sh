#!/bin/sh
#Weather for Jacky!
#
subject="-Email Météo-"
DAY=$(date +%d)
MONTH=$(date +%m)
YEAR=$(date +%y)

read -p "Entrez l'adresse email du destinataire: " TO
read -p "Entrez le message: " subject
sendmail -t $TO -m $subject -a weather-$DAY-$MONTH-$YEAR.txt
time sleep



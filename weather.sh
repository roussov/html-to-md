#!/bin/sh
#Weather for Jacky!
#


function scrapWeb() {
    cd /
    #MODIFY URL RASPBERRY
    mkdir _weather
    cd _weather
    #scrap
    read -p "Indiquez la ville de votre choix: " city

    curl https://fr.weather-forecast.com/$city > weather-html.txt
    html2text weather-html.txt > weather-$DAY-$MONTH-$YEAR.txt
}



function send_me_email() {
    read -p "Entrez l'adresse email du destinataire: " TO
    read -p "Entrez le message: " subject
    sendmail -t $TO -m $subject -a weather-$DAY-$MONTH-$YEAR.txt
}
function main(){
    subject="-Email Météo-"
    DAY=$(date +%d)
    MONTH=$(date +%m)
    YEAR=$(date +%y)
    scrapWeb
    send_me_email
    ls -lh $dest
}
main

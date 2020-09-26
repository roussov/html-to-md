#!/bin/bash
#start.sh

function start_test{
    while true; do
    read -p "Avez-vous déjà installé le module sendmail [essentiel au serveur] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) _news;;
        [Nn]* ) ./setup.sh;;
         * ) echo "Répondez par oui ou par non";;
    esac
done
function news(){
    python3 news.py
    ./email.sh
}

function main(){
    start_test
    news
    
}
main
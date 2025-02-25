#!/bin/bash
#start.sh


function start-test(){
    echo "Bienvenue [test des modules]"
    echo "==========================="
    while true; do
    read -p "Avez-vous déjà configuré le serveur ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) news-txt || exit 0 ;;
        [Nn]* ) ./setup.sh ;;
        * ) echo "Répondez par oui ou par non";;
    esac
done
}



function news-txt(){
    python3 news.py
    ./email.sh
}

function main(){
    start-test
    news-txt
}
main

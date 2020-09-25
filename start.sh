#!/bin/bash
#start.sh

function test{
    while true; do
    read -p "Avez-vous déjà installé le module sendmail [essentiel au serveur] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) _news ;;
        [Nn]* ) ./setup.sh;;
         * ) echo "Répondez par oui ou par non";;
    esac
done
function _news (){
    python3 news.py
    ./email.sh
}

function main(){
    _test
    _news
    
}
main
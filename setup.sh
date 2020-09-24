#!/bin/bash
#setup.sh

function dependencies(){
    echo "Dépendances du programme"
    echo "==========================="
    clear
    while true; do
    read -p "Avez-vous déjà installer les dépendances python [essentiels au script] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) sendmail_install ;;
        [Nn]* ) pip install -r requirements.txt 
                sendmail_install ;;
        * ) echo "Répondez par oui ou par non";;
    esac

done



} 

function sendmail_install(){
    echo "Configuration du module sendmail"
    echo "============================="
    clear
     while true; do
    read -p "Avez-vous déjà installé le module sendmail [essentiel au serveur] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) start-service ;;
        [Nn]* ) $sendmail_install 
                start-service ;;
         * ) echo "Répondez par oui ou par non";;
    esac
done
clear

}

function start-service(){
    sudo sendmailconfig
    sudo service apache2 restart
    python news.py
    ./email.sh   
}



function main(){
    sendmail_install=sudo apt-get install sendmail
    dependencies
    start-service   
}

main

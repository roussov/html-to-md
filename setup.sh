#!/bin/bash
#setup.sh

function dependencies(){
    echo "Dépendances du programme"
    echo "==========================="
    while true; do
    read -p "Avez-vous déjà installer les dépendances python [essentiels au script] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) sendmail_config ;;
        [Nn]* ) pip3 install -r requirements.txt 

        * ) echo "Répondez par oui ou par non";;
    esac

done



} 

function sendmail_config(){
    echo "Configuration du module sendmail"
    echo "============================="

     while true; do
    read -p "Avez-vous déjà installé le module sendmail [essentiel au serveur] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) start-service ;;
        [Nn]* ) $sendmail_install 
                start-service ;;
         * ) echo "Répondez par oui ou par non";;
    esac
done


}

function start-service(){
    sudo sendmailconfig
    sudo service apache2 restart
    ./start.sh

}



function main(){
    sendmail_install=sudo apt-get install sendmail
    dependencies
    start-service   
}

main

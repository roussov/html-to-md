#!/bin/bash
#setup.sh

function dependencies(){
    echo "Dépendances du programme"
    echo "==========================="
    clear
    while true; do
    read -p "Avez-vous déjà installer les dépendances python [essentiels au script] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) ssmtp_install ;;
        [Nn]* ) pip install -r requirements.txt 
                ssmtp_install ;;
        * ) echo "Répondez par oui ou par non";;
    esac

done



} 

function ssmtp_install(){
    echo "Configuration du module ssmtp"
    echo "============================="
    clear
     while true; do
    read -p "Avez-vous déjà installé le module ssmtp [essentiel au serveur] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) mail-config ;;
        [Nn]* ) $ssmtp_install 
                mail-config ;;
         * ) echo "Répondez par oui ou par non";;
    esac
done
clear

}
function mail-config() {
    echo "Initialisation Du serveur"
    echo "============================="
    
    clear
    cd /usr/sbin/sendmail
    time 1
    ls -la
    clear
    echo "Configurez votre serveur avec vos infos"
    nano $conf_ssmtp_conf
    chmod 600 $conf_ssmtp_conf
    #securisation des données 
    nano $etc/ssmtp/revaliases
    sudo apt-get install mailutils

}

function start-service(){
    python weather.py
    ./email.sh   
}



function main(){

    ssmtp_install=sudo apt-get install ssmtp
    conf_ssmtp_conf=/etc/ssmtp/ssmtp.conf
    conf_ssmtp_revaliases=etc/ssmtp/revaliases

    dependencies
    start-service   
}

main
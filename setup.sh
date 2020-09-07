#!/bin/bash
#setup.sh

function dependencies(){
    echo "Dépendances au programme"
    echo "==========================="
    while true; do
    read -p "Souhaitez vous installer html-xml-utils & ssmtp ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) apt-get update
                apt-get install -y $ssmtp_install $html-xml-utils_install; break;;
        [Nn]* ) exit;;
        * ) echo "Répondez par oui ou par non";;
    esac

done

}

function mail-config{
    echo "Configuration du module ssmtp"
    echo "============================="
    cd /usr/sbin/sendmail
    ls -la
    clear
    echo "Configurez votre serveur avec vos infos"
    nano $conf_ssmtp_conf
    chmod 600 $conf_ssmtp_conf
    #securisation des données 
    nano $etc/ssmtp/revaliases
    sudo apt-get install mailutils
     
}

function start-service{
    echo
    #./weather.sh
}

function main(){

    ssmtp_install=sudo apt-get install ssmtp
    html-xml-utils_install=sudo apt-get install html-xml-utils
    
    conf_ssmtp_conf=/etc/ssmtp/ssmtp.conf
    conf_ssmtp_revaliases=etc/ssmtp/revaliases

    dependencies
    mail-config
    start-service
}
main

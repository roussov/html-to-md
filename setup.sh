#!/bin/bash
#setup.sh

function python_init(){
echo "Initialisation de python"
echo "==========================="
# Vérifier si Python est déjà installé
if command -v python3 &>/dev/null; then
    echo "Python est déjà installé, voici la version :"
    python3 --version
    exit 0
else
    echo "Python n'est pas installé. Installation en cours..."
fi

# Mettre à jour la liste des paquets
sudo apt update

# Installer les pré-requis
sudo apt install -y software-properties-common

# Ajouter le PPA de deadsnakes pour la dernière version de Python
sudo add-apt-repository ppa:deadsnakes/ppa -y

# Mettre à jour de nouveau la liste des paquets
sudo apt update

# Installer la dernière version de Python
sudo apt install -y python3

# Vérifier l'installation
if command -v python3 &>/dev/null; then
    echo "Installation réussie, voici la version installée :"
    python3 --version
else
    echo "Échec de l'installation de Python."
fi
}
function pip_init(){
echo "Initialisation de pip"
echo "==========================="
# Met à jour la liste des paquets
echo "Mise à jour de la liste des paquets..."
sudo apt update

# Installe pip3 si ce n'est pas déjà fait
if ! command -v pip3 &> /dev/null
then
    echo "pip3 n'est pas installé. Installation en cours..."
    sudo apt install -y python3-pip
else
    echo "pip3 est déjà installé. Vérification de la mise à jour..."
    # Met à jour pip3
    pip3 install --upgrade pip
    echo "pip3 a été mis à jour."
fi

# Vérification de l'installation de pip3
if command -v pip3 &> /dev/null
then
    echo "pip3 est installé et prêt à être utilisé."
    pip3 --version
else
    echo "Une erreur s'est produite lors de l'installation de pip3."
    exit 1
fi
}
function apache2_init(){
    
    if command -v apache2 >/dev/null 2>&1; then
    echo "Apache 2 est installé."
    apache2 -v
elif command -v httpd >/dev/null 2>&1; then
    echo "Apache 2 est installé."
    httpd -v
else
    echo "Apache 2 n'est pas installé."
    echo "Installation et mise en service d'apache2"
    sudo apt install apache2
fi

}
function dependencies(){
    echo "Dépendances du programme"
    echo "==========================="
    while true; do
    read -p "Avez-vous déjà installé les dépendances python [essentiels au script] ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) sendmail_config ;;
        [Nn]* ) python_config
                sendmail_config ;;
         * ) echo "Répondez par oui ou par non";;
    esac
done
}

function sendmail_config(){
    echo "Configuration du module sendmail"
    echo "============================="

     while true; do
    read -p "Avez-vous déjà installé les modules essentiels au serveur ?: [Y,y / N,n]" yn
    case $yn in
        [Yy]* ) start-service ;;
        [Nn]* ) $sendmail_install
                $mail_install
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
    python_config=python_init && pip_init  pip3 install -r requirements.txt
    sendmail_install=sudo apt-get install sendmail
    mail_install=apt-get install mailutils
    dependencies
    start-service
    exit 0

}

main

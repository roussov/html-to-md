#!/bin/bash
# setup.sh

set -e

function python_init() {
    echo "Initialisation de Python"
    echo "==========================="

    if command -v python3 &>/dev/null; then
        echo "Python est déjà installé :"
        python3 --version
    else
        echo "Python n'est pas installé. Installation en cours..."
        sudo apt update
        sudo apt install -y software-properties-common
        sudo add-apt-repository -y ppa:deadsnakes/ppa
        sudo apt update
        sudo apt install -y python3
        python3 --version
    fi
}

function pip_init() {
    echo "Initialisation de pip"
    echo "==========================="

    if ! command -v pip3 &>/dev/null; then
        echo "pip3 n'est pas installé. Installation en cours..."
        sudo apt install -y python3-pip
    else
        echo "pip3 est déjà installé. Mise à jour..."
        pip3 install --upgrade pip
    fi

    echo "pip3 est prêt :"
    pip3 --version
}

function apache2_init() {
    echo "Vérification d'Apache 2"
    echo "==========================="

    if command -v apache2 &>/dev/null || command -v httpd &>/dev/null; then
        echo "Apache 2 est déjà installé."
        apache2 -v 2>/dev/null || httpd -v
    else
        echo "Installation d'Apache 2..."
        sudo apt install -y apache2
    fi
}

function install_dependencies() {
    echo "Installation des dépendances Python"
    echo "==========================="

    read -rp "Avez-vous déjà installé les dépendances Python (requirements.txt) ? [Y/N]: " yn
    case "$yn" in
        [Nn]* )
            pip3 install -r requirements.txt
            ;;
        * )
            echo "Supposé déjà installé."
            ;;
    esac
}

function sendmail_config() {
    echo "Configuration de Sendmail"
    echo "==========================="

    read -rp "Avez-vous déjà installé les modules essentiels pour le serveur (sendmail/mailutils) ? [Y/N]: " yn
    case "$yn" in
        [Nn]* )
            sudo apt install -y sendmail mailutils
            ;;
        * )
            echo "Supposé déjà installé."
            ;;
    esac
}

function start_service() {
    echo "Démarrage des services"
    echo "==========================="

    sudo sendmailconfig
    sudo service apache2 restart
    ./start.sh
}

function main() {
    sudo apt update
    python_init
    pip_init
    apache2_init
    install_dependencies
    sendmail_config
    start_service
    echo "Installation et configuration terminées."
}

main

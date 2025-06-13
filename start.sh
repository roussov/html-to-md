#!/bin/bash
# start.sh

set -e

function start_test() {
    echo "Bienvenue [test des modules]"
    echo "==========================="

    while true; do
        read -rp "Avez-vous déjà configuré le serveur ? [Y/y / N/n]: " yn
        case $yn in
            [Yy]* )
                run_news
                return
                ;;
            [Nn]* )
                ./setup.sh
                run_news
                return
                ;;
            * )
                echo "Répondez par Y/y ou N/n."
                ;;
        esac
    done
}

function run_news() {
    echo "Exécution de news.py et email.sh"
    python3 news.py
    ./email.sh
}

function main() {
    start_test
}

main

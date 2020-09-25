#!/bin/bash
#start.sh


function os_program(){
    echo "Bienvenue / Nous allons tester la compatibilité du système"
    if [[ "$OSTYPE" =~ ^linux-gnu ]]; then
        echo "Votre système est compatible"
    else
        echo "Votre système est incompatible"
    fi
}
function main(){
    os-os_program 
}



main
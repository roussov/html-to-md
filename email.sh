#!/bin/bash
#email html-to-md!

set -e

# Variables de date
DAY=$(date +%d)
MONTH=$(date +%m)
YEAR=$(date +%y)
news_today="news-$DAY-$MONTH-$YEAR.txt"

# Vérifie si le fichier source existe
if [[ ! -f news.txt ]]; then
    echo "❌ Le fichier news.txt est introuvable. Abandon."
    exit 1
fi

# Renommer le fichier
mv news.txt "$news_today"
echo "✅ Fichier renommé en $news_today"

# Démarrer Sendmail (si nécessaire)
if ! pgrep -x "sendmail" > /dev/null; then
    echo "⏳ Démarrage du service sendmail..."
    sudo /etc/init.d/sendmail start
else
    echo "✅ Sendmail est déjà en cours d'exécution."
fi

# Saisie utilisateur
read -rp "Entrez l'adresse email du destinataire: " TO
read -rp "Entrez le sujet: " subject

# Envoi du mail avec le contenu du fichier
if tail -n 100 "$news_today" | mail -s "$subject" "$TO"; then
    echo "✅ Email envoyé avec succès à $TO"
else
    echo "❌ Échec de l'envoi de l'email."
    exit 1
fi

# Affichage de la file d'attente mail
mailq


#!/bin/sh
#Weather for Jacky!
#


DAY=$(date +%d)
MONTH=$(date +%m)
YEAR=$(date +%y)
news_today=news-$DAY-$MONTH-$YEAR.txt

mv news.txt $news_today



read -p "Entrez l'adresse email du destinataire: " TO
read -p "Entrez le message: " subject
sendmail -t $TO -m $subject -a $news_today




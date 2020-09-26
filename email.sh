#!/bin/sh
#Weather for Jacky!
#


DAY=$(date +%d)
MONTH=$(date +%m)
YEAR=$(date +%y)
news_today=news-$DAY-$MONTH-$YEAR.txt

mv news.txt $news_today


/etc/init.d/sendmail start
read -p "Entrez l'adresse email du destinataire: " TO
read -p "Entrez le sujet: " subject
tail -100 $news_today | mail -s $subject $TO
mailq



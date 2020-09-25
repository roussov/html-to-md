#!usr/bin/env python3.7
import requests
from bs4 import BeautifulSoup


url_news = requests.get('https://www.lemonde.fr/cosmos/')
soup = BeautifulSoup(url_news)

try:
    page = requests.get(url_news).text
except:
    print("Error opening the URL")

soup.title


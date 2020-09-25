#!usr/bin/env python3.7
# -*- coding: UTF-8 -*-


from urllib.request import Request, urlopen
from bs4 import BeautifulSoup as soup
import os.path
import requests



def main():
    url = "https://www.francetvinfo.fr/"
    req = Request(url , headers={'User-Agent': 'Mozilla/5.0'})
    webpage = urlopen(req).read()
    page_soup = soup(webpage, "html.parser")
    title = page_soup.find("title")
    containers = page_soup.findAll("p")
    with open('news.txt','w+') as file:
        file.write(str(title) + '\n')
        file.write(str(containers) + '\n')
    welcome()

def welcome():
	    welcome = """
        +=========================================+
        |..........   News for Jacky   ...........|
        +-----------------------------------------+
        |                                         | 
       https://github.com/vincentrs92/News-for-Jacky   
 	    |                                         |
        +=========================================+
        |..........  News for Jacky    ...........|
        +-----------------------------------------+\n\n
"""


if __name__ == '__main__':
	main()
import requests
from bs4 import BeautifulSoup
from markdownify import markdownify as md

# Fonction pour récupérer le contenu HTML à partir d'une URL
def fetch_html(url):
    response = requests.get(url)
    response.raise_for_status()  # Raise an error for bad responses
    return response.text

# Fonction pour convertir du HTML en Markdown
def convert_html_to_markdown(html):
    return md(html)

# URL de la page que vous souhaitez convertir
print("exemple https://example.com")
print("===========================")
url = input("choix de l'url \n")
print("===========================")

# Récupérer le HTML et le convertir en Markdown
try:
    html_content = fetch_html(url)
    markdown_content = convert_html_to_markdown(html_content)

    # Output the Markdown content
    print(markdown_content)

except Exception as e:
    print(f"An error occurred: {e}")
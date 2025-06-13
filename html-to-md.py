import requests
from bs4 import BeautifulSoup
from markdownify import markdownify as md
from urllib.parse import urlparse

def fetch_html(url):
    """Récupère le contenu HTML depuis une URL"""
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        return response.text
    except requests.exceptions.RequestException as e:
        raise RuntimeError(f"Erreur de connexion ou d'URL: {e}")

def convert_html_to_markdown(html):
    """Convertit du HTML en Markdown"""
    return md(html, heading_style="ATX")  # Style # pour les titres

def is_valid_url(url):
    """Valide la structure de l'URL"""
    parsed = urlparse(url)
    return parsed.scheme in ("http", "https") and parsed.netloc

def main():
    print("Exemple d'URL : https://example.com")
    print("===================================")
    url = input("Entrez l'URL à convertir en Markdown : ").strip()
    print("===================================")

    if not is_valid_url(url):
        print("❌ URL invalide. Veuillez entrer une URL valide (http ou https).")
        return

    try:
        html = fetch_html(url)
        markdown = convert_html_to_markdown(html)
        print("\n✅ Conversion réussie. Contenu Markdown ci-dessous :\n")
        print(markdown)

        save = input("\nSouhaitez-vous sauvegarder ce contenu dans un fichier ? [Y/n] ").strip().lower()
        if save in ("y", "yes", ""):
            filename = input("Nom du fichier (ex: sortie.md) : ").strip()
            with open(filename or "output.md", "w", encoding="utf-8") as f:
                f.write(markdown)
            print(f"✅ Contenu sauvegardé dans : {filename or 'output.md'}")

    except Exception as e:
        print(f"\n❌ Une erreur est survenue : {e}")

if __name__ == "__main__":
    main()

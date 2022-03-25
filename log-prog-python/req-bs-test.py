import requests
import os
import bs4

url = 'http://xkcd.com' # url inicial
os.makedirs('xkcd', exist_ok=True) # armazena as tirinhas em ./xkcd 

while not url.endswith('#'):
    # Faz download da página.
    print(f'Downloading page {url}...')

    res = requests.get(url)
    res.raise_for_status()
    soup = bs4.BeautifulSoup(res.text)

    # Encontra o URL da imagem da tirinha.
    comicElem = soup.select('#comic img')
    if comicElem == []:
        print('Could not find comic image.')
    else:
        comicUrl = 'http:' + comicElem[0].get('src')
        # Faz o download da imagem.
        print(f'Downloading image {comicUrl}...')
        res = requests.get(comicUrl)
        res.raise_for_status()


    with open(os.path.join('xkcd', os.path.basename(comicUrl)), 'wb') as imageFile:
        for chunk in res.iter_content(100000):
            imageFile.write(chunk)
            
    # Obtém o url do botão Prev. print('Done.')
    prevLink = soup.select('a[rel="prev"]')[0]
    url = 'http://xkcd.com' + prevLink.get('href')
print('Done')
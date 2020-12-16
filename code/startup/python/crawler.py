import json

import argparse
from bs4 import BeautifulSoup
import requests
from tqdm import trange, tqdm


class BingEngine:

    def __init__(self):
        self.baseurl = 'https://cn.bing.com'
        self.search_pattern = '/search?q={query}'

    def get_url(self, query, relative=True):
        url = self.search_pattern.format(query=query)
        if not relative:
            url = self.baseurl + url
        return url

    def get(self, query):
        return self.get_page_content(self.get_url(query))

    def get_page_content(self, url, relative=True):
        if relative:
            url = self.baseurl + url
        return requests.get(url).content


class BingPage:

    def __init__(self, page):
        self.soup = BeautifulSoup(page, 'html.parser')

    def next_url(self):
        url = self.soup.findChild(class_='sb_pagN')
        return url.get('href') if url else None

    def get_results(self):
        results = self.soup.find_all(class_='b_algo')
        infos = []
        for result in results:
            infos.append(self._parse_result(result))
        return infos

    def _parse_result(self, result):
        info = {
            'title': '',
            'abstract': '',
            'link': ''
        }
        info['title'] = self._text(result.h2)
        caption = result.findChild(class_='b_caption')
        if caption:
            info['abstract'] = self._text(caption.findChild('p'))
            info['link'] = self._text(caption.cite)
        return info

    def _text(self, node):
        return node.getText() if node else ''


def search_on_bing(query, num_page, verbose=True):
    engine = BingEngine()
    res = []
    for i in trange(num_page):
        if i == 0:
            url = engine.get_url(query)
        page = BingPage(engine.get_page_content(url))
        page_results = page.get_results()
        res.extend(page_results)
        if verbose:
            tqdm.write('Page %d: %d results found.' % (i, len(page_results)))

        url = page.next_url()
        if not url:
            break
    if verbose:
        print('Total results: %d' % len(res))
        print('Sample: \n', res[0])
    return res


def save(res, path):
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(res, f, indent=4, ensure_ascii=False)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('query', help='Keywords.')
    parser.add_argument('-p', '--pages', default=1, help='Total pages')
    parser.add_argument('-s', '--save', default='bing_result.json')

    args = parser.parse_args()

    res = search_on_bing(args.query, args.pages)
    save(res, args.save)

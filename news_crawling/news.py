import requests
from bs4 import BeautifulSoup
from openpyxl import Workbook
from openpyxl.styles import Font

wb = Workbook()
ws = wb.active
a = 1
print("검색 내역은 엑셀에 자동 저장됩니다.")
while True:
    aa = "A" + str(a)
    word = input("검색할 키워드를 입력해주세요>> ")
    search_word = word
    
    ws.append([search_word])
    ws.append([])
    a1 = ws[aa]
    a1.font = Font(color="0000FF", size=20, bold=True)
    
    url = f'https://search.naver.com/search.naver?where=news&sm=tab_jum&query={search_word}'
    req = requests.get(url)
    html = req.text
    soup = BeautifulSoup(html, 'html.parser')
    serch_result = soup.select('.news_tit')
    list1 = []
    list2 = []
    for link in serch_result:
        title = link.text
        url = link.attrs['href']
        ws.append([title])
        ws.append([url])
        print("제목: ",title)
        print("링크: ", url, end="\n\n")
    wb.save("C:\\Users\\User\\Desktop\\news_crawling\\search_result.xlsx")
    chk = input("계속하려면 Y를 입력하세요 : ")
    a += 23
    if(chk != "Y"):
        break
    ws.append([])
wb.close()
input("종료하시려면 아무키나 입력하세요...")
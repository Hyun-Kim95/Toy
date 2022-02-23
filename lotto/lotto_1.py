# 로또 엑셀 다운로드
import time
from selenium import webdriver
import pyautogui

def 엑셀다운():
  browser = webdriver.Chrome()
  browser.maximize_window()

  # 로또 url 접속
  browser.get('https://www.dhlottery.co.kr/gameResult.do?method=byWin')
  # 1회차 부터 선택
  time.sleep(1)
  browser.find_element_by_xpath('//*[@id="drwNoStart"]').click()
  time.sleep(1)
  pyautogui.press("End")
  time.sleep(1)
  pyautogui.press("Enter")
  # 엑셀 다운로드 클릭
  time.sleep(1)
  browser.find_element_by_xpath('//*[@id="exelBtn"]').click()
  # 브라우저 종료
  time.sleep(2)
  browser.quit()

  # 엑셀파일 옮기기 + 확장자 변경(xlsx)
  # 로또 엑셀 열기
  pyautogui.hotkey("Win","r")
  time.sleep(1)
  pyautogui.write("C:\\Users\\User\\Downloads\\excel.xls")
  time.sleep(1)
  pyautogui.press("Enter")
  time.sleep(2)
  pyautogui.press("y")
  time.sleep(2)

  # 편집허용 버튼 클릭(엑셀이 같은 모니터에 나오게 한 상태로 진행)
  try:
    pyautogui.click(pyautogui.locateOnScreen("C:\\Users\\User\\Desktop\\lotto\\img\\pyunzip.png"))
    time.sleep(1)
  except:
    print("편집허용을 실패했습니다.")
  # # 다른 이름으로 저장 클릭
  pyautogui.click(pyautogui.locateOnScreen("C:\\Users\\User\\Desktop\\lotto\\img\\file.png"))
  time.sleep(1)
  pyautogui.click(pyautogui.locateOnScreen("C:\\Users\\User\\Desktop\\lotto\\img\\dsave.png"))
  time.sleep(1)
  # 폴더 선택
  pyautogui.click(pyautogui.locateOnScreen("C:\\Users\\User\\Desktop\\lotto\\img\\looking.png"))
  time.sleep(1)
  pyautogui.click(pyautogui.locateOnScreen("C:\\Users\\User\\Desktop\\lotto\\img\\search.png"))
  pyautogui.write("C:\\Users\\User\\Desktop\\lotto")
  pyautogui.press("Enter")
  time.sleep(1)

  # 확장자 변경 및 저장
  pyautogui.click(pyautogui.locateOnScreen("C:\\Users\\User\\Desktop\\lotto\\img\\hoak.png"))
  time.sleep(1)
  pyautogui.press("Home")
  time.sleep(1)
  pyautogui.press("Enter")
  time.sleep(1)
  pyautogui.click(pyautogui.locateOnScreen("C:\\Hyun_Folder\\ETC\\lotto\\img\\csave.png"))
  time.sleep(1)
  pyautogui.press("y")
  time.sleep(1)
  pyautogui.hotkey("Alt","F4")

  # 다운받은 excel.xls 삭제
  time.sleep(1)
  pyautogui.hotkey("Win","r")
  pyautogui.write("C:\\Users\\User\\Downloads")
  time.sleep(1)
  pyautogui.press("Enter")
  time.sleep(1)
  pyautogui.press("up")
  time.sleep(1)
  pyautogui.press("delete")
  time.sleep(1)
  pyautogui.hotkey("Alt","F4")
  print("엑셀다운로드 완료")
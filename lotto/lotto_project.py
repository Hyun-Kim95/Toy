import time
from openpyxl import Workbook
from sympy import false, true
import lotto_1 as a
import lotto_2 as ex
import lotto_4 as ln
import lotto_5 as b

def 엑셀다운로드하시겠습니까():
  btn = input("엑셀 다운로드를 실행하려면 'y'입력, 건너뛰기는 'n' 입력 >> ")
  if(btn == 'y'):
    a.엑셀다운()
  elif(btn == 'n'):
    print("엑셀 다운로드를 생략합니다.")
    return false
  else:
    print("y 와 n 중에 입력해주세요!")
    return true

def 추첨번호갯수():
  while True:
    cnt = input("구하고자 하는 추천번호의 갯수를 숫자만 입력하세요 >> ")
    if(cnt == '0'):
      print("1 이상의 숫자를 입력해주세요!")
      continue
    try:
      cnt = int(cnt)
      break
    except:
      print("숫자만 입력해주세요!")
      continue
  return cnt
  
def 종료():
  print("실행완료")
  print("5초 후 자동 종료됩니다")
  for i in range(5,0,-1):
    print(i)
    time.sleep(1)

# -----------------함수경계-------------------------------

print("""
로또 프로그램 순서
1. 엑셀 다운로드 및 실행폴더로 옮김(y / n)
2. 추천 조합 생성(갯수 선택)
3. 결과를 엑셀에 저장
4. 결과를 이메일로 전송
""")
while (엑셀다운로드하시겠습니까()):
  pass

wb = Workbook()
ws = wb.active

cnt = 추첨번호갯수()

print("\n* 참고 : 최근 1등 당첨 번호의 과거 기록은 4등이었던 경우가 2 ~ 3개 였음")
a = ex.a - 3
print("{} 회차 로또 예상 번호 : ".format(a))
내용 = ""
while True:
  조합 = ln.조합함수(cnt)
  체크 = 0
  for i in 조합:
    if(len(i[6]) == 0):
      체크 = 1
      break

  if(len(조합) != 0 and 체크 == 0):
    break

for num in 조합:
  ws.append(num)
  내용 += str(num)
  내용 += "\n"
  print(num, "\n")
  
while True:
  savebtn = input("엑셀에 저장 및 메일로 전송을 하시려면  y, 그냥 종료 하시려면 n 을 입력하세요>> ")
  if(savebtn == 'y'):
    wb.save("C:\\Users\\User\\Desktop\\lotto\\lotto_result.xlsx")
    print("엑셀에 저장 완료")

    # 메일로 전송
    b.실행(내용)
    종료()
    break
  elif(savebtn == 'n'):
    print("저장 및 전송 없이 종료합니다.")
    종료()
    break
  else:
    print("y 와 n 중에서 골라주세요!")
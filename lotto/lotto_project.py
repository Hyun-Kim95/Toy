import time
from openpyxl import Workbook
import lotto_1 as a
import lotto_4 as ln
import lotto_5 as b

# 로또 엑셀 다운받기
print("""
로또 프로그램 순서
1. 엑셀 다운로드 및 실행폴더로 옮김(y / n)
2. 추천 조합 생성(갯수 선택)
3. 결과를 엑셀에 저장
4. 결과를 이메일로 전송
""")
while True:
  while True:
    btn = input("엑셀 다운로드를 실행하려면 'y'입력, 건너뛰기는 'n' 입력 >> ")
    if(btn == 'y'):
      a.엑셀다운()
      break
    elif(btn == 'n'):
      print("엑셀 다운로드를 생략합니다.")
      break
    else:
      print("y 와 n 중에 입력해주세요!")

  # 정답 예상지 작성
  wb = Workbook()
  ws = wb.active
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
    
  내용 = ""

  print("로또 예상 번호 : ")
  for num in ln.조합(cnt):
    ws.append(num)
    내용 += str(num)
    내용 += "\n"
    print(num)
  while True:
    replay = int(input("다시 번호를 구하려면 1, 그대로 저장하려면 2를 눌러주세요 >> "))
    if (replay == 1 or replay == 2):
      break
    else:
      print("1과 2 중에 선택해주세요!")
  if(replay == 2):
    break

try:
  wb.save("C:\\Users\\User\\Desktop\\lotto\\lotto_result.xlsx")
  print("엑셀에 저장 완료")
except:
  print("엑셀에 저장 실패")
wb.close()

# 메일로 전송
try:
  b.실행(내용)
except:
  print("메일로 전송 실패")

print("실행완료")
print("5초 후 자동 종료됩니다")
for i in range(5,0,-1):
  print(i)
  time.sleep(1)

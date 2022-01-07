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

btn = input("엑셀 다운로드를 실행하려면 'y'입력, 건너뛰기는 'n' 입력 >> ")
if(btn == 'y'):
  a.엑셀다운()
else:
  print("엑셀 다운로드를 생략합니다.")

# 정답 예상지 작성
wb = Workbook()
ws = wb.active
cnt = int(input("구하고자 하는 추천번호의 갯수를 입력하세요 >> "))
내용 = ""
for num in ln.조합(cnt):
  ws.append(num)
  내용 += str(num)
  내용 += "\n"

wb.save("C:\\Users\\User\\Desktop\\lotto\\lotto_result.xlsx")
print("엑셀에 저장 완료")
wb.close()

# 메일로 전송
b.실행(내용)

print("실행완료")
input("종료하시려면 아무키나 입력하세요...")
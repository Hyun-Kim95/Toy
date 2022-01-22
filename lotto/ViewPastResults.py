import lotto_2 as ex
import lotto_3 as ls
import time
# 로또 과거번호 조회
전체숫자 = ex.전체숫자
while True:
  print("\n종료를 원하실 때는 'y'를 입력해주세요.")
  chk = input("\n조회하실 번호 6개를 띄어쓰기 기준으로 입력해주세요 >> ")
  
  if chk.strip() == 'y':
    print("5초 후에 종료합니다.")
    for i in range(5,0,-1):
      print(i)
      time.sleep(1)
    break
  
  chk = chk.split(" ")
  if len(chk) == 6:
    try:
      chk = [int(i) for i in chk]
      print(ls.과거등수(chk, 전체숫자))
    except:
      print("\n숫자만 입력해주세요!")
  else:
    print("\n6개의 숫자를 입력해주세요!")
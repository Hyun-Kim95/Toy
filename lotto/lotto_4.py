# 조합 생성
import math
import random

from sympy import false
import lotto_2 as ex
import lotto_3 as lo

cha = ex.cha
다음숫자 = ex.다음숫자
최근숫자 = ex.최근숫자
전체숫자 = ex.전체숫자
# 오차 비교용(번걸아가면 숫자에 적용)
bae = [lo.삼의배수(cha),lo.사의배수(cha)]

def 조합함수(cnt):
  # 추천조합 cnt개 구함
  조합 = []
  # 한개의 조합만 구하려면 마지막 숫자를 따로 구하는 로직을 실행할 수 없어서 여기 들어가야 함
  while (len(조합) < cnt - 1 or (cnt == 1 and len(조합) == 0)):
    result = []
    # 가능한 숫자에서 랜덤 조합과 중복 제거
    for i in range(6):
      result.append(다음숫자[i][random.randrange(1,len(다음숫자[i]))])
    result = lo.중복제거(result)
    if(result[0]==0):
      continue
    result = sorted(result)
    if(result not in 조합):
      if(lo.총합(result)):
        if (lo.소수갯수(result)):
          if (lo.이월수(result,최근숫자)):
            if (lo.연속수(result)):
              if (lo.동끝수(result)):
                if(lo.홀짝(result)):
                  # 4의 배수와 3의 배수를 이용한 오차적용
                  result = lo.배수변형(bae[len(조합)%2],result)
                  result = sorted(result)
                  result = lo.중복제거(result)
                  if(result[0]==0):
                    continue
                  if((result[0]) != 0):
                    if(result[0] != 1):
                      result[0] -= 1
                    if(result[5] <= 43):
                      result[5] += 2
                    if(result not in 조합):
                      # 다양성을 위해 추가(이번에 구한 조합의 첫 숫자가 이전 조합에 포함 안되있어야 함)
                      if (len(조합) > 0 and result[0] not in 조합[-1] and result[-1] not in 조합[-1]):
                        result.append(lo.과거등수(result, 전체숫자))
                        조합.append(result)
                      elif (len(조합) == 0):
                        result.append(lo.과거등수(result, 전체숫자))
                        조합.append(result)
  # 마지막 조합은 앞의 숫자들의 평균으로 구함
  # 만약 구하는 숫자가 1개면 실행 안함
  if(cnt != 1):
    last_list = []
    j = 0
    while (j < 6):
      chk = 0
      for i in range(cnt-1):
        chk += 조합[i][j]
      num = int(chk / (cnt-1))

      success = 0
      while (num < 45 and num > 1 and success == 0):
        for k in 조합:
          if(num in k):
            if (j >= 3):
              num += 1
            else:
              num -= 1
            break
          else:
            success = 1
      if (num in last_list):
        if(num == 45):
          num -= 1
        else:
          num += 1
      last_list.append(num)
      j += 1
    체크 = lo.과거등수(last_list, 전체숫자)
    if(체크 == false):
      emptyList = []
      return emptyList
    last_list.append(체크)
    조합.append(last_list)

  return 조합
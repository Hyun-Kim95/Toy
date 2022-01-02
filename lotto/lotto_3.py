# 사용할 함수 모음

def 중복제거(num):
  if (num[0] != num[1] and num[0] != num[2] and num[0] != num[3] and num[0] != num[4] and num[0] != num[5] and 
      num[1] != num[2] and num[1] != num[3] and num[1] != num[4] and num[1] != num[5] and
      num[2] != num[3] and num[2] != num[4] and num[2] != num[5] and
      num[3] != num[4] and num[3] != num[5] and
      num[4] != num[5]):
    result = [num[0],num[1],num[2],num[3],num[4],num[5]]
  else:
    result = [0,0,0,0,0,0]
  return result

def 삼의배수(cha):
  bae = []
  for i in range(6):
    beeg = (sum(cha[i]) + cha[i][0])
    if beeg % 3 == 0:
        bae.append(0)

    elif beeg >= 0:
      if beeg % 3 == 1:
        bae.append(-1)
      elif beeg % 3 == 2:
        bae.append(-2)

    else:
      beeg *= -1
      if beeg % 3 == 1:
        bae.append(1)
      elif beeg % 3 == 2:
        bae.append(2)
      
    baeLast = bae[-1]
    if baeLast < 0:
      baeLast *= -1
    if baeLast * 2 < beeg:
      bae[-1] += 3
  return bae

def 사의배수(cha):
  bae = []
  for i in range(6):
    beeg = (sum(cha[i]) + cha[i][0])
    if beeg % 4 == 0:
        bae.append(0)

    elif beeg >= 0:
      if beeg % 4 == 1:
        bae.append(-1)
      elif beeg % 4 == 2:
        bae.append(-2)
      else:
        bae.append(-3)

    else:
      beeg *= -1
      if beeg % 4 == 1:
        bae.append(1)
      elif beeg % 4 == 2:
        bae.append(2)
      else:
        bae.append(3)
      
    baeLast = bae[-1]
    if baeLast < 0:
      baeLast *= -1
    if baeLast * 2 < beeg:
      bae[-1] += 4
  return bae

def 총합(result):
  if(sum(result) > 80 and sum(result) < 230):
    return True
  else:
    False

def 소수갯수(result):
  sosu = 0
  for i in result:
    cnt = 0
    for j in range(2,i+1):
      if(i % j == 0):
        cnt+=1
    if cnt == 1:
      sosu += 1
  if sosu >= 1 and sosu <= 3:
    return True
  return False

def 이월수(result,최근숫자):
  cnt = 0
  for i in result:
    if i in 최근숫자:
      cnt += 1
  if cnt >= 0 and cnt <= 2:
    return True
  return False

def 연속수(result):
  cnt = 0
  for i in range(1,len(result)):
    if result[i] - result[i-1] == 1:
      cnt += 1
  if cnt <= 2:
    return True
  return False

def 동끝수(result):
  chk = []
  for i in result:
    if i % 10 not in chk:
      chk.append(i%10)
  if len(chk) >= 3:
    return True
  return False

def 홀짝(result):
  hol = 0
  zzak = 0
  for re in result:
    if re % 2 == 0:
      zzak += 1
    else:
      hol += 1
  if hol == 0 or zzak == 0:
    return False
  return True

def 배수변형(bae,result):
  for i in range(len(result)):
    if result[i] + bae[i] <= 0 or result[i] + bae[i] > 45:
      result = [0,0,0,0,0,0]
      break
    else:
      result[i] += bae[i]
  return result
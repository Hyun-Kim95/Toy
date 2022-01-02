# 결과 이메일로 보냄
import smtplib
# account : 이메일과 비번 저장된 파일
from account import *
from email.message import EmailMessage

# 호출용 함수
def 실행(내용):
    msg = EmailMessage()
    msg["subject"] = "로또 프로그램 결과"  # 제목
    msg["From"] = EMAIL_ADDRESS         # 보내는  사람
    msg["To"] = "khyun9512@naver.com"   # 받는 사람

    msg.set_content(내용)   # 본문

    with smtplib.SMTP("smtp.gmail.com", 587) as smtp:
        smtp.ehlo()                                 # 연결이 잘 수립되는지 확인
        smtp.starttls()                             # 모든 내용이 암호화 되어 전송
        smtp.login(EMAIL_ADDRESS, EMAIL_PASSWORD)   # 로그인
        smtp.send_message(msg)
    print("메일전송 완료")

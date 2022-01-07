### user생성 및 권한 부여
CREATE USER 'toyuser'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON `diary`.* TO 'toyuser'@'localhost';

### 데이터베이스 생성
DROP DATABASE IF EXISTS diary;
CREATE DATABASE diary;
USE diary;

### 일기 테이블 생성
CREATE TABLE diaryList(
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	userId INT(10) UNSIGNED NOT NULL,
	title CHAR(100) NOT NULL,
	`body` TEXT NOT NULL
);

### 회원 테이블 생성
CREATE TABLE diaryUser(
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	loginId CHAR(30) NOT NULL,
	loginPw VARCHAR(100) NOT NULL,
	`name` CHAR(30) NOT NULL,
	`nickname` CHAR(30) NOT NULL,
	`cellphoneNo` CHAR(20) NOT NULL,
	`email` CHAR(100) NOT NULL
);

### 로그인 ID로 검색했을 때 (인덱스 종류를 UNIQUE로 설정(같은 아이디 사용불가, 로그인 아이디로 검색시 속도향상))
ALTER TABLE `user` ADD UNIQUE INDEX (`loginId`);

### genFile 테이블 생성
CREATE TABLE genFile(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,	# 번호
	regDate DATETIME DEFAULT NULL,			# 작성날짜
	updateDate DATETIME DEFAULT NULL,		# 갱신날짜
	relId INT(10) UNSIGNED NOT NULL,		# 관련 데이터 번호
	originFileName VARCHAR(100) NOT NULL,		#업로드 당시의 파일 이름
	fileExt CHAR(10) NOT NULL,			# 확장자
	fileSize CHAR(10) NOT NULL,			# 파일의 사이즈
	fileExtTypeCode CHAR(10) NOT NULL,		# 파일규격코드(img, video)
	fileExtType2Code CHAR(10) NOT NULL,		# 파일규격2코드(jpg, mp4)
	fileNo SMALLINT(2) UNSIGNED NOT NULL,		# 파일번호(1)
	fileDir CHAR(20) NOT NULL,			# 파일이 저장되는 폴더명
	PRIMARY KEY (id),
	KEY relId(relId, fileNo)
);
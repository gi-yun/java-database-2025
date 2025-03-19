## 토이프로젝트
Python GUI - Oracle연동 프로그램

### GUI 프레임워크
- GUI 프레임워크 종류
    1. tkinter - 파이썬 내장된 GUI 라이브러리. 중소형 프로그램 사용. 간단하게 사용가능. 안 이쁨. 
    2. **PyQt** / PySide 
        - C/C++에서 사용하는 GUI프레임워크 Qt를 파이썬에 사용하게 만든 라이브러리. 현재 6버전 출시. 유료.
        - PyQt의 사용라이선스 문제로 PySide 릴리즈 PyQt에서 PyQt에서 PySide변경하는데 번거러움 존재
        - tkinter보다 난이도 있음
        - 아주 이쁨. QtDesigner툴로 포토샵처럼 GUI를 디자인 가능
        - Python GUI중에서 가장 많이 사용 중
    3. Kivy
        - OpenGL(게임엔진용 3D 그래픽엔진)으로 구현되는 GUI 프레임 워크
        - 안드로이드, ios 등 모바일용으로도 개발가능
        - 최신에 나온 기술이라 아직 불안정함.
    4. wxPython 
        - Kivy처럼 멀티플랫폼 GUI 프레임워크
        - 무지 어려움

### PyQt5 GUI 사용
- PyQt5 설치
    - 콘솔 `> pip install PyQt5` (*개발자는 경로를 알고있어야 한다. --version 으로 항상 경로를 찾아보자)


- QtDesigner 설치
    - https://build-system.fman.io/qt-designer-download 다운로드 후 설치

### PyQt5
1. PyQt 모듈 사용 윈앱 만들기
2. 윈도우 기본설정
3. PyQt 위젯 사용법(레이블, 버튼, 레이아웃, ...)
4. 시그널(이벤트) 처리방법
5. QtDesigner로 화면디자인, PyQt와 연동
    <img src="../image/database-storage.png" width=300>


### Oracle연동 GUI개발 시작
- 오라클 Python연동 DB(스키마) 생성
    ```SQL
    -- madang 스키마, 사용자 생성
    CREATE USER madang IDENTIFIED BY madang;

    -- sys(sysdba)로 작업
    -- 권한 설정
    GRANT CONNECT, resource TO madang;

    -- madang으로 사용 스키마 변경
    ```
- Student 테이블 생성, 더미데이터 추가
    ```sql
    -- 테이블 Student 생성
    CREATE TABLE Students (
        std_id 		NUMBER 			PRIMARY KEY,
        std_name 	varchar2(100) 	NOT NULL,
        std_mobile 	varchar2(15) 	NULL,
        std_regyear	number(4, 0) 	NOT null
    );

    -- Student용 시퀀스 생성
    CREATE SEQUENCE SEQ_STUDENT
        INCREMENT BY 1	-- 숫자를 1씩 증가
        START WITH 1;	-- 1부터 숫자가 증가됨.

    -- 사용자 madang으로 변경

    -- madang 로그인

    -- 조회
    SELECT *
    FROM STUDENTS s ;

    -- 더미데이터 삽입
    INSERT INTO STUDENTS(STD_ID, STD_NAME, STD_MOBILE, STD_REGYEAR) 
    VALUES (SEQ_STUDENT.nextval, '홍길동', '010-9999-8888', 1997);
    INSERT INTO STUDENTS(STD_ID, STD_NAME, STD_MOBILE, STD_REGYEAR) 
    VALUES (SEQ_STUDENT.nextval, '홍길순', '010-9999-8877', 2000);
    ```
- Python 오라클 연동 테스트
    - 오라클 모듈
        - oracledb - Oracle 최신버전에 매칭
        - **cx_Oracle** - 구버전까지 잘됨
    - 콘솔에서 `> pip install cx_Oracle`
    - Microsoft C++ Build Tools 필요
- QtDesigner로 화면 구성
- PyQt로 Oracle 연동 CRUD 구현

## 8일차 시작
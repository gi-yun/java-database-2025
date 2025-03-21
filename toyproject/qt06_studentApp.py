# Oracle Student 앱
# CRUD 데이터베이스 DML(SELECT, INSERT, UPDATE, DELETE)
## CREATE(INSERT), REQUEST(SELECT), UPDATE(UPDATE), DELETE(DELETE)
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5 import QtGui, QtWidgets, uic

# Oracle 모듈 
import cx_Oracle as oci

## DB연결 설정
sid = 'XE'
host = '127.0.0.1'
port = 1521
username = 'madang'
password = 'madang'
basic_msg = '학생정보 v1.0'

class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        
        self.initUI()
        self.loadData()

    def initUI(self):
        uic.loadUi('./toyproject/studentdb.ui', self)  # studentdb.ui 파일을 로드하여 화면을 구성
        self.setWindowTitle("학생관리 앱") # 타이틀 추가
        self.setWindowIcon(QIcon("./image/icons/students.png")) # 아이콘 추가

        # 상태바에 메시지 추가
        self.statusBar().showMessage(basic_msg)

        #버튼에 아이콘추가
        self.btn_add.setIcon(QIcon('./image/icons/add-user.png'))
        self.btn_mod.setIcon(QIcon('./image/icons/edit-user.png'))
        self.btn_del.setIcon(QIcon('./image/icons/del-user.png'))

        # 버튼 이벤트 추가
        self.btn_add.clicked.connect(self.btnAddClick)
        self.btn_mod.clicked.connect(self.btnModClick)
        self.btn_del.clicked.connect(self.btnDelClick)

        # 테이블위젯 클릭 이벤트
        self.tblStudent.doubleClicked.connect(self.tblStudentDoubleClick)

        # 화면에 보이기
        self.show()
    
    
    # 화면의 인풋위젯 데이터 초기화 함수.
    def clearInputs(self):
        self.input_std_id.clear()
        self.input_std_name.clear()
        self.input_std_mobile.clear()
        self.input_std_regyear.clear()


    # 테이블위젯 더블클릭 시그널처리 함수
    def tblStudentDoubleClick(self):
        # QMessageBox.about(self, '알림', '동작합니다.')
        selected = self.tblStudent.currentRow() # 현재 선택된 row의 index반환함수
        std_id = self.tblStudent.item(selected, 0).text()
        std_name = self.tblStudent.item(selected, 1).text()
        std_mobile = self.tblStudent.item(selected, 2).text()
        std_regyear = self.tblStudent.item(selected, 3).text()
        # QMessageBox.about(self, '더블클릭', f'{std_id}, {std_name}, {std_mobile}, {std_regyear}')

        # 상태바에 메시지 추가
        self.statusBar().showMessage(f'{basic_msg}| 수정모드')

        # 선택된 row의 데이터를 인풋위젯에 셋팅
        self.input_std_id.setText(std_id) 
        self.input_std_name.setText(std_name)
        self.input_std_mobile.setText(std_mobile)
        self.input_std_regyear.setText(std_regyear)
        

    # 추가버튼 클릭 시 시그널처리 함수
    def btnAddClick(self):
        print('추가버튼 클릭')
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        print(std_name, std_mobile, std_regyear)

        # 입력검증 필수 (Validation Check)
        if std_name == '' or std_regyear == '':
            QMessageBox.warning(self ,'경고', '학생이름과 입학년도는 필수 입력값입니다.')
            return # 함수를 탈출
        elif std_id != '' :
            QMessageBox.warning(self, '경고', '기학생정보를 다시 등록할수 없습니다!')
            return
        else:
            print('DB입력 진행!')
            values = (std_name, std_mobile, std_regyear) # 변수값 3개를 튜플변수 담고
            if self.addData(values) == True :# 튜플을 파라미터로 전달
                QMessageBox.about(self, '성공', '학생정보 등록 성공!')
            else:
                QMessageBox.warning(self, '실패', '학생정보 등록 실패!')    

            self.loadData() # 데이터베이스 입력 후 테이블위젯을 DB에서 조회

            self.clearInputs() # 입력값 초기화

        # 상태바에 메시지 추가
        self.statusBar().showMessage(f'{basic_msg}| 추가완료')

    def btnModClick(self):
        # print('수정버튼 클릭')
        std_id = self.input_std_id.text()
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        # print(std_id, std_name, std_mobile, std_regyear)

        if std_id == '' or std_name == '' or std_regyear == '':
            QMessageBox.warning(self, '경고', '학생번호, 학생이름 또는 입학년도는 필수입니다!')
            return # 함수 탈출
        else:
            print('DB수정 진행!')
            values = (std_name, std_mobile, std_regyear, std_id)
            self.modData(values)

        if self.modData(values) == True:
            QMessageBox.about(self, '성공', '학생정보 수정 성공!!!')
        else:
            QMessageBox.warning(self, '실패', '관리자에게 문의하세요')

        self.loadData() # 데이터베이스 입력 후 테이블위젯을 DB에서 조회
        self.clearInputs() # 입력값 초기화

        # 상태바에 메시지 추가
        self.statusBar().showMessage(f'{basic_msg}| 수정완료')

            

    def btnDelClick(self):
        print('삭제버튼 클릭')
        std_id = self.input_std_id.text()
        if std_id == '':
            QMessageBox.warning(self, '경고', '학생번호, 학생이름 또는 입학년도는 필수입니다!')
            return # 함수 탈출
        else:
            print('DB수정 진행!')
            values = (int(std_id), )
            # self.delData(values)

        if self.delData(values) == True:
            QMessageBox.about(self, '성공', '학생정보 삭제 성공!!!')
        else:
            QMessageBox.warning(self, '실패', '관리자에게 문의하세요')

        self.loadData() # 데이터베이스 입력 후 테이블위젯을 DB에서 조회
        self.clearInputs() # 입력값 초기화

        # 상태바에 메시지 추가
        self.statusBar().showMessage(f'{basic_msg}| 삭제완료')

    
    # 테이블위젯 데이터와 연관해서 화면 설정
    def makeTable(self, lst_student):
        self.tblStudent.setSelectionMode(QAbstractItemView.SingleSelection) # 단일 ROW 선택모드
        self.tblStudent.setEditTriggers(QAbstractItemView.NoEditTriggers) # 편집모드 비활성화
        self.tblStudent.setColumnCount(4)
        self.tblStudent.setRowCount(len(lst_student)) # 커서에 들어있는 데이터 길이만큼 row 생성
        self.tblStudent.setHorizontalHeaderLabels(['학생번호', '학생이름', '핸드폰', '입학년도'])

        # 전달받은 cursor를 반복문으로 테이블위젯에 뿌리는 작업        
        for i, (std_id, std_name, std_mobile, std_regyear) in enumerate(lst_student):
            self.tblStudent.setItem(i, 0, QTableWidgetItem(str(std_id)))  # oracle number타입은 뿌릴때 str()로 형변환 필요!
            self.tblStudent.setItem(i, 1, QTableWidgetItem(std_name))
            self.tblStudent.setItem(i, 2, QTableWidgetItem(std_mobile))
            self.tblStudent.setItem(i, 3, QTableWidgetItem(str(std_regyear)))            

    # C(INSERT)
    def addData(self, tuples):
        isSucced = False # 성공여부 플래그 변수
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin() # BEGIN TRANSACTION. 트랜잭션 시작

            #쿼리작성
            query = '''
                    INSERT INTO MADANG.STUDENTS (std_id, std_name, std_mobile, std_regyear)
                    VALUES (SEQ_STUDENT.NEXTVAL, :v_std_name, :v_std_mobile, :v_std_regyear)
                    '''
            cursor.execute(query, tuples) # query에 들어가는 동적변수 3개는 뒤의 tuples 순서대로 매핑시켜줌

            conn.commit()  # DB commit 동일기능
            last_id = cursor.lastrowid  # SEQ_STUDENT.CURRVAL
            print(last_id)
            isSucced = True # 트랜잭션 성공
        except Exception as e:
            print(e)
            conn.rollback()   # DB rollback 동일기능
            isSucced = False # 트랜잭션 실패        
        finally:
            cursor.close()
            conn.close()
        # 줄 제발 잘 맞춰주세요!!!
        return isSucced # 트랜잭션 성공여부 리턴
    
    # R(SELECT)
    def loadData(self):
        # db연결
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        query = '''SELECT std_id, std_name
                        , std_mobile, std_regyear 
                     FROM Students'''
        cursor.execute(query)

        # for i, item in enumerate(cursor, start=1):
        #     print(item)
        lst_student = []  # 리스트 생성
        for _, item in enumerate(cursor):
            lst_student.append(item)

        self.makeTable(lst_student) # 새로 생성한 리스트를 파라미터로 전달

        cursor.close()
        conn.close()

    # U(UPDATE)
    def modData(self, tuples):
        isSucced = False # 성공여부 플래그 변수
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin() # BEGIN TRANSACTION. 트랜잭션 시작

            #쿼리작성
            query = '''
                    UPDATE MADANG.STUDENTS
                    SET STD_NAME= :v_std_name
                        , STD_MOBILE=:v_std_mobile
                        , STD_REGYEAR=:v_std_regyear
                    WHERE STD_ID= :v_std_id
                    '''
            cursor.execute(query, tuples) # query에 들어가는 동적변수 4개는 뒤의 tuples 순서대로 매핑시켜줌

            conn.commit()  # DB commit 동일기능
            isSucced = True # 트랜잭션 성공
        except Exception as e:
            print(e)
            conn.rollback()   # DB rollback 동일기능
            isSucced = False # 트랜잭션 실패 
  
        finally:
            cursor.close()
            conn.close()
        # 줄 제발 잘 맞춰주세요!!!
        return isSucced # 트랜잭션 성공여부 리턴
    
    # D(DELETE)
    def delData(self, tuples):
        isSucced = False
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin() # BEGIN TRANSACTION. 트랜잭션 시작

            #쿼리작성
            query = '''
                    DELETE FROM MADANG.STUDENTS
                    WHERE STD_ID= :v_std_id
                    '''
            cursor.execute(query, tuples) # query에 들어가는 동적변수 4개는 뒤의 tuples 순서대로 매핑시켜줌

            conn.commit()  # DB commit 동일기능
            isSucced = True # 트랜잭션 성공
        except Exception as e:
            print(e)
            conn.rollback()   # DB rollback 동일기능
            isSucced = False # 트랜잭션 실패 
  
        finally:
            cursor.close()
            conn.close()
        # 줄 제발 잘 맞춰주세요!!!
        return isSucced # 트랜잭션 성공여부 리턴


if __name__ == "__main__":
    app = QApplication(sys.argv)
    win = MainWindow()
    app.exec_()



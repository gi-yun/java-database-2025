## PyQt5 첫 윈도우앱 개발
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *

class DevWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI() #화면 초기화는 분리
    
    def initUI(self):
        self.setWindowTitle("My First App") 
        self.setWindowIcon(QIcon("./image/database-storage.png"))
        self.setGeometry(100, 100, 800, 600) 
        self.resize(600, 350)

        # 라벨(레이블) 추가
        self.lbl1 = QLabel('버튼클릭', self)
        self.lbl1.move(10, 40) # 위젯 위치 조정
        self.lbl1.resize(250, 30) # 위젯 크기 조정

        #버튼 추가
        self.btn1 = QPushButton("Click", self) 
        self.btn1.move(10, 40)
        self.btn1.clicked.connect(self.btn1click) # 버튼 클릭시 시그널(이벤트)함수 연결
        self.btn1.clicked.connect(self.btn1click) # 버튼 클릭시 시그널(이벤트)함수 연결

        # 윈도우 화면 중앙에 위치
        qr = self.frameGeometry() 
        cp = QDesktopWidget().availableGeometry().center() 
        qr.moveCenter(cp) 
        self.move(qr.topLeft()) 
        
        self.show()
    def btn1click(self): # 버튼 클릭 시그널 처리함수
        # self.lbl1.setText('버튼을 클릭했네요.')
        QMessageBox.about(self, '알림',"버튼을 클릭했습니다.")
        
if __name__ == "__main__":  # 메인모듈이라면
    app = QApplication(sys.argv) 
    win = DevWindow() 
    app.exec_() 
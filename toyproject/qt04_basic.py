## PyQt5 첫 윈도우앱 개발
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *

class DevWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI() 
    
    def initUI(self):
        self.setWindowTitle("My First App") 
        self.setWindowIcon(QIcon("./image/database-storage.png"))
        self.setGeometry(100, 100, 800, 600) 
        self.resize(600, 350)

        self.lbl1 = QLabel("버튼클릭", self)
        self.lbl1.move(10, 40) 
        self.lbl1.resize(250, 30) 

        self.btn1 = QPushButton("Click", self) 
        self.btn1.move(10, 40)
        self.btn1.clicked.connect(self.btn1click) 

        self.hbox = QHBoxLayout() # 가로로 구성하는 레이아웃
        self.hbox.addStretch(1) # 레이아웃의 공백 추가
        self.hbox.addWidget(self.lbl1) # 라벨 추가
        self.hbox.addWidget(self.btn1) # 버튼 추가
        self.hbox.addStretch(1) # 레이아웃의 공백 추가

        self.vbox = QVBoxLayout() # 세로로 구성하는 레이아웃

        self.vbox.addStretch(1) # 레이아웃의 공백 추가
        self.vbox.addLayout(self.hbox) # 가로 레이아웃 추가

        qr = self.frameGeometry() 
        cp = QDesktopWidget().availableGeometry().center() 
        qr.moveCenter(cp) 
        self.move(qr.topLeft()) 
        
        self.show()
    def btn1click(self): 
        QMessageBox.about(self, '알림',"버튼을 클릭했습니다.")
        
if __name__ == "__main__": 
    app = QApplication(sys.argv) 
    win = DevWindow() 
    app.exec_() 
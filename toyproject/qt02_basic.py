## PyQt5 첫 윈도우앱 개발
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *

class DevWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("My First App") # 윈도우 타이틀 지정
        self.setWindowIcon(QIcon("./image/database-storage.png"))
        self.setGeometry(100, 100, 800, 600) # 윈도우 위치(x, y), 크기(w, h) 지정
        self.resize(600, 350) # 윈도우 크기 지정

        # 윈도우 화면 중앙에 위치
        qr = self.frameGeometry() #현재 만들어진 Qt앱 위치와 크기를 받아옴
        cp = QDesktopWidget().availableGeometry().center() #화면 중앙 위치를 받아옴
        qr.moveCenter(cp) #현재 만들어진 Qt앱 위치를 화면 왼쪽 위로 이동
        self.move(qr.topLeft()) #화면 중앙 위치로 이동
        
app = QApplication(sys.argv) 
win = DevWindow() 
win.show()  
app.exec_() 
## PyQt5 첫 윈도우앱 개발
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import Qt  # Qt 모듈 추가 (오류 해결)

class DevWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()  # 화면 초기화는 분리

    def initUI(self):
        self.setWindowTitle("My First App") 
        self.setWindowIcon(QIcon("./image/database-storage.png"))
        self.setGeometry(100, 100, 800, 600) 
        self.resize(600, 350)

        # 중앙 위젯과 레이아웃 설정
        central_widget = QWidget(self)  # 중앙 위젯 생성
        self.setCentralWidget(central_widget)  # 중앙 위젯 설정
        layout = QVBoxLayout()  # 수직 정렬 레이아웃

        # 라벨 추가 (위쪽에 배치)
        self.lbl1 = QLabel('버튼 클릭', self)
        self.lbl1.setAlignment(Qt.AlignCenter)  # ✅ NameError 해결: Qt.AlignCenter 사용
        layout.addWidget(self.lbl1)  # 레이아웃에 추가

        # 버튼 추가 (아래쪽에 배치)
        self.btn1 = QPushButton("Click", self) 
        self.btn1.clicked.connect(self.btn1click)  # 버튼 클릭 시 이벤트 연결
        layout.addWidget(self.btn1)  # 레이아웃에 추가

        central_widget.setLayout(layout)  # 중앙 위젯에 레이아웃 설정
        
        self.show()

    def btn1click(self):
        self.lbl1.setText('버튼을 클릭했네요!')

# 메인 실행 코드
if __name__ == "__main__":  
    app = QApplication(sys.argv) 
    win = DevWindow() 
    app.exec_()

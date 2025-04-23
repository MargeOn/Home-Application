import QtQuick 2.11
import QtQuick.Window 2.0
import QtQuick.Controls 2.4

ApplicationWindow {
    id: window
    visible: true
    maximumWidth: 1920
    maximumHeight: 1200
    minimumWidth: 1920
    minimumHeight: 1200
    Image {
        id: background
        width: 1920
        height: 1200
        source: "qrc:/Img/bg_full.png"
    }

    StatusBar {
        id: statusBar
        onBntBackClicked: stackView.pop(null)
        isShowBackBtn: stackView.depth == 1 ? false : true
    }

    StackView {
        id: stackView
        width: 1920
        anchors.top: statusBar.bottom
        initialItem: HomeWidget{id: homeWg}
        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -1920
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
        Keys.onPressed:{
            //Switch case
            switch (event.key){
            case Qt.Key_Escape:
                stackView.pop(null)
                break
            case Qt.Key_A:
                if(!homeWg.isDrag)
                    stackView.push("qrc:/App/Map/Map.qml")
                break
            case Qt.Key_C:
                if(!homeWg.isDrag)
                    stackView.push("qrc:/App/Climate/Climate.qml")
                break
            case Qt.Key_M:
                if(!homeWg.isDrag)
                    stackView.push("qrc:/App/Media/Media.qml")
                break
            case Qt.Key_S:
                if(!homeWg.isDrag)
                    stackView.push("qrc:/App/Settings/Settings.qml")
                break
            }
        }
    }

}

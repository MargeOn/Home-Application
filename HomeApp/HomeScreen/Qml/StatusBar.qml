import QtQuick 2.0
import QtQuick.Layouts 1.11
import "Common"
import QtQml 2.2

Item {
    width: 1920
    height: 104
    signal bntBackClicked
    property bool isShowBackBtn: false
    Button {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        icon: "qrc:/Img/StatusBar/btn_top_back"
        width: 135
        height: 90
        iconWidth: width
        iconHeight: height
        onClicked: bntBackClicked()
        visible: isShowBackBtn
    }

    Item {
        id: clockArea
        x: 660
        width: 300
        height: parent.height
        Image {
            anchors.left: parent.left
            height: 104
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
        Text {
            id: clockTime
            text: dateTimeSystem.currentTime//"10:28"
            color: "white"
            font.pixelSize: 64
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }
    Item {
        id: dayArea
        anchors.left: clockArea.right
        width: 300
        height: parent.height
        Text {
            id: day
            text: dateTimeSystem.currentDate//"Jun. 24"
            color: "white"
            font.pixelSize: 64
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }

    //    QtObject {
    //        id: time
    //        property var locale: Qt.locale()
    //        property date currentTime: new Date()

    //        Component.onCompleted: {
    //            clockTime.text = time.currentTime.toLocaleTimeString(locale, "hh:mm");
    //            if(translator.currentLanguage === "us"){
    //                day.text = time.currentTime.toLocaleDateString(Qt.locale("en_US"), "MMM. dd");
    //            }
    //            else if(translator.currentLanguage === "vn"){
    //                day.text = time.currentTime.toLocaleDateString(locale, "MMM. dd");
    //            }
    //            else if(translator.currentLanguage === "kr"){
    //                day.text = time.currentTime.toLocaleDateString(Qt.locale("ko_KR"), "MMM. dd");
    //            }
    //            else if(translator.currentLanguage === "jp"){
    //                day.text = time.currentTime.toLocaleDateString(Qt.locale("ja_JP"), "MMM. dd");
    //            }

    //        }
    //    }

    //    Timer{
    //        interval: 1000
    //        repeat: true
    //        running: true
    //        onTriggered: {
    //            time.currentTime = new Date()
    //            clockTime.text = time.currentTime.toLocaleTimeString(locale, "hh:mm");
    //            if(translator.currentLanguage === "us"){
    //                day.text = time.currentTime.toLocaleDateString(Qt.locale("en_US"), "MMM. dd");
    //            }
    //            else if(translator.currentLanguage === "vn"){
    //                day.text = time.currentTime.toLocaleDateString(locale, "MMM. dd");
    //            }
    //            else if(translator.currentLanguage === "kr"){
    //                day.text = time.currentTime.toLocaleDateString(Qt.locale("ko_KR"), "MMM. dd");
    //            }
    //            else if(translator.currentLanguage === "jp"){
    //                day.text = time.currentTime.toLocaleDateString(Qt.locale("ja_JP"), "MMM. dd");
    //            }
    //        }

    //    }
}

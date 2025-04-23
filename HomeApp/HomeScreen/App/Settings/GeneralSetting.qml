import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: root
    Text {
        id: titleId
        x: 105
        y: 110
        text: qsTr("SELECT_LANGUAGE") + translator.emptyString
        font.bold: true
        font.pixelSize: 40
        color: "black"
    }
    ComboBox{
        id: comboBoxId
        x: 105
        y: 190
        width: 980
        height: 110
        model: ListModel{
            id: model
            ListElement{ language: "English (US)" }
            ListElement{ language: "Vietnamese" }
            ListElement{ language: "Korean (한국어)" }
            ListElement{ language: "Japanese (日本語)" }
        }
        delegate: ItemDelegate{
            width: 980
            height: 110
            contentItem: Text {
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 30
                text: model.language
                font.pixelSize: 34
            }
        }
        contentItem: Text {
            id: contentTextId
            anchors.left: parent.left
            anchors.leftMargin: 20
            verticalAlignment: Text.AlignVCenter
            text: translator.currentLanguage === "us" ? "English (US)" :
                                                        (translator.currentLanguage === "vn" ? "Vietnamese" :
                                                                                               (translator.currentLanguage === "kr" ? "Korean (한국어)" : "Japanese (日本語)"))
            font.pixelSize: 36
        }
        background: Rectangle{
            id: bgrdComboBox
            width: parent.width
            height: parent.height
            border.color: comboBoxId.pressed ? "#2D78F0" : "#9F9F9F"
            border.width: comboBoxId.visualFocus ? 4 : 2
            radius: 20

        }
        indicator: Image{
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/App/Settings/Image/arrow.png"
        }
        onActivated: {
            translator.selectLanguage(comboBoxId.currentIndex)
            if(comboBoxId.currentIndex === 0){
                translator.currentLanguage = "us"
                dateTimeSystem.setLocalDate("us")
            }
            else if (comboBoxId.currentIndex === 1){
                translator.currentLanguage = "vn"
                dateTimeSystem.setLocalDate("vn")
            }
            else if (comboBoxId.currentIndex === 2){
                translator.currentLanguage = "kr"
                dateTimeSystem.setLocalDate("kr")
            }
            else{
                translator.currentLanguage = "jp"
                dateTimeSystem.setLocalDate("jp")
            }
            notifySuccess.visible = true
            hideTimer.start()
        }
    }
    Rectangle{
        id: notifySuccess
        width: 980
        height: 100
        anchors.top: comboBoxId.bottom
        anchors.topMargin: 40
        anchors.left: comboBoxId.left
        color: "#F0FDF4"
        border.color: "#BBF7D0"
        border.width: 1
        radius: 10
        visible: false
        Image{
            id: checkId
            width: 50
            height: 50
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/App/Settings/Image/check.png"
        }
        Text {
            id: textNotify
            anchors.left: checkId.right
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("NOTIFY_CHANGES") + translator.emptyString
            font.pixelSize: 34
            color: "#15803D"
        }
    }

    Timer{
        id: hideTimer
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            notifySuccess.visible = false
        }
    }
}

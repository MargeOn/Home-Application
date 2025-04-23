import QtQuick 2.0
import QtQuick.Controls 2.12

Item{
    id: root
    Text {
        id: titleNotifyId
        x: 105
        y: 70
        text: qsTr("APP_APPLICATION_NOTIFY")+ translator.emptyString
        font.bold: true
        font.pixelSize: 40
        color: "black"
    }
    ListView{
        id: listViewId
        x: 105
        y: 155
        width: 950
        height: 625
        spacing: 2
        clip: true
        model: ListModel{
            ListElement{ notifyUS: "Map"; notifyVN: "Bản đồ"; notifyKR: "지도"; notifyJP: "ちず";  source: "qrc:/App/Settings/Image/map.png" }
            ListElement{ notifyUS: "Climate"; notifyVN: "Điều hòa"; notifyKR: "에어컨"; notifyJP: "くうちょう"; source: "qrc:/App/Settings/Image/climate.png" }
            ListElement{ notifyUS: "Media"; notifyVN: "Nhạc"; notifyKR: "미디어"; notifyJP: "メディア"; source: "qrc:/App/Settings/Image/media.png" }
            ListElement{ notifyUS: "Phone"; notifyVN: "Điện thoại"; notifyKR: "전화"; notifyJP: "でんわ"; source: "qrc:/App/Settings/Image/phone.png" }
            ListElement{ notifyUS: "Radio"; notifyVN: "Radio"; notifyKR: "라디오"; notifyJP: "ラジオ"; source: "qrc:/App/Settings/Image/radio.png" }
        }
        delegate: Rectangle{
            width: 950
            height: 154
            color: "#374151"
            radius: 20
            Image{
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                width: 90
                height: 90
                source: model.source
            }
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 30 + 50 +90
                anchors.verticalCenter: parent.verticalCenter
                text: translator.currentLanguage === "us" ? model.notifyUS :
                    (translator.currentLanguage === "vn" ? model.notifyVN :
                    (translator.currentLanguage === "kr" ? model.notifyKR : model.notifyJP))
                font.pixelSize: 35
                font.bold: true
                color: "white"

            }
            Rectangle{
                anchors.left: centerNode.left
                anchors.bottom: centerNode.top
                anchors.bottomMargin: 30
                width: 5
                height: 5
                color: "#BDBDBD"
                radius: 5
            }
            Rectangle{
                id: centerNode
                anchors.right: switchId.left
                anchors.rightMargin: 40
                anchors.verticalCenter: parent.verticalCenter
                width: 5
                height: 5
                color: "#BDBDBD"
                radius: 5
            }
            Rectangle{
                anchors.left: centerNode.left
                anchors.top: centerNode.bottom
                anchors.topMargin: 30
                width: 5
                height: 5
                color: "#BDBDBD"
                radius: 5
            }

            Switch{
                id: switchId
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                indicator: Rectangle {
                    implicitWidth: 112
                    implicitHeight: 52
                    x: switchId.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 50
                    color: switchId.checked ? "#4e63ea" : "#9a9393"
                    Rectangle {
                        x: switchId.checked ? parent.width - width : 0
                        width: 52
                        height: 52
                        radius: 26
                        color: switchId.down ? "#BDBDBD" : "#ffffff"
                        Behavior on x{
                            NumberAnimation{duration: 200; easing.type: Easing.InOutQuad}
                        }
                    }
                }
            }
        }
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.12

Item{
    id: root
    Text {
        id: titleBatteryId
        x: 105
        y: 100
        text: qsTr("Title_Battery") + translator.emptyString
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
        interactive: false
        model: ListModel{
            ListElement{ titleUS:  "Power saving mode "; titleVN: "Trình tiết kiệm pin"; titleKR: "배터리 절약 모드"; titleJP: "省電力モード";
                stateUS: "Turned off"; stateVN: "Đang tắt"; stateKR: "꺼짐"; stateJP: "オフになっている" }
            ListElement{ titleUS: "Battery percentage"; titleVN: "Phần trăm pin"; titleKR: "배터리 퍼센트"; titleJP: "バッテリーのパーセント";
                stateUS: "Show battery percentage"; stateVN: "Hiển thị số phần trăm pin"; stateKR: "배터리 퍼센트 표시"; stateJP: "バッテリーのパーセントを表示" }
        }
        delegate: Rectangle{
            width: 950
            height: 154
            color: "#374151"
            radius: 20
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 80
                text: translator.currentLanguage === "us" ? model.titleUS :
                                                            (translator.currentLanguage === "vn" ? model.titleVN :
                                                                                                   (translator.currentLanguage === "kr" ? model.titleKR : model.titleJP))
                font.pixelSize: 40
                font.bold: true
                color: "white"
            }
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                text: translator.currentLanguage === "us" ? model.stateUS :
                                                            (translator.currentLanguage === "vn" ? model.stateVN :
                                                                                                   (translator.currentLanguage === "kr" ? model.stateKR : model.stateJP))
                font.pixelSize: 25
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

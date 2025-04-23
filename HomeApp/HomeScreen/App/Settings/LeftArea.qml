import QtQuick 2.0

Item {
    signal selectedSetting(int index)
    Rectangle{
        id: brgdId
        width: 548
        height: 821
        color: "#1F2937"
        opacity: 0.9
        radius: 10
    }
    ListView{
        id: lvSettings
        y: 70
        width: brgdId.width
        height: brgdId.height
        interactive: false
        model: ListModel{
            ListElement{ settingUS: "Display"; settingVN: "Màn hình"; settingKR: "디스플레이"; settingJP: "がめん";  sourceSetting: "qrc:/App/Settings/Image/monitor.png" }
            ListElement{ settingUS: "Sound"; settingVN: "Âm thanh"; settingKR: "사운드"; settingJP: "サウンド"; sourceSetting: "qrc:/App/Settings/Image/volume.png" }
            ListElement{ settingUS: "Notifications"; settingVN: "Thông báo"; settingKR: "알림"; settingJP: "つうち"; sourceSetting: "qrc:/App/Settings/Image/notification.png" }
            ListElement{ settingUS: "Battery"; settingVN: "Pin"; settingKR: "배터리"; settingJP: "バッテリー"; sourceSetting: "qrc:/App/Settings/Image/battery.png" }
            ListElement{ settingUS: "General"; settingVN: "Tổng quan"; settingKR: "일반"; settingJP: "いっぱん"; sourceSetting: "qrc:/App/Settings/Image/language.png" }
        }
        delegate: MouseArea{
            width: 518
            height: 139
            hoverEnabled: true
            Rectangle{
                id: rectSetting
                width: 518
                height: 139
                color: focus ? "#7C96BF" : "transparent"
                radius: 30
            }
            Image{
                width: 60
                height: 60
                anchors.left: parent.left
                anchors.leftMargin: 65
                anchors.verticalCenter: parent.verticalCenter
                source: model.sourceSetting
            }
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 185
                anchors.verticalCenter: parent.verticalCenter
                text: translator.currentLanguage === "us" ? model.settingUS :
                      (translator.currentLanguage === "vn" ? model.settingVN :
                      (translator.currentLanguage === "kr" ? model.settingKR : model.settingJP))
                font.pixelSize: 48
                color: "white"
            }
            onClicked: {
                lvSettings.currentIndex = index
                selectedSetting(lvSettings.currentIndex)
                rectSetting.focus = false
            }
            onPressed: {
                rectSetting.focus = true
            }
            onReleased: {
                if(!containsMouse){
                    rectSetting.focus = false
                }
            }
        }
        highlight: Rectangle{
            width: 518
            height: 139
            color: "#374151"
            radius: 30
        }
    }
}

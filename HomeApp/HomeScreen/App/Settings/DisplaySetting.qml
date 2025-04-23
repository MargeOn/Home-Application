import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: root
    Text {
        id: titleDisId
        x: 105
        y: 110
        text: qsTr("CHANGED_BRIGHTNESS")+ translator.emptyString
        font.bold: true
        font.pixelSize: 40
        color: "black"
    }
    Slider{
        id: sliderBrightness
        x: 105
        y: 210
        width: 600
        value: 100
        from: 0
        to: 100
        handle: Rectangle {
            x: sliderBrightness.leftPadding + sliderBrightness.visualPosition * (sliderBrightness.availableWidth - width)
            y: sliderBrightness.topPadding + sliderBrightness.availableHeight / 2 - height / 2
            implicitWidth: 15
            implicitHeight: 60
            radius: 10
            color: sliderBrightness.pressed ? "#37435D" : "#f6f6f6"
            border.color: "#bdbebf"
        }
    }

    Text{
        anchors.left: sliderBrightness.right
        anchors.leftMargin: 30
        anchors.verticalCenter: sliderBrightness.verticalCenter
        text: Math.floor(sliderBrightness.value)
        font.pixelSize: 32
    }
    // Night light
    Text {
        id: nightLight
        x: 105
        y: 300
        text: qsTr("NIGHT_LIGHT")+ translator.emptyString
        font.pixelSize: 36
        color: "black"
    }
    Switch{
        id: switchId
        x: 105
        y: 360
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

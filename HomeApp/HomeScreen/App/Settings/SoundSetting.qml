import QtQuick 2.0
import QtQuick.Controls 2.12

Item{
    id: root
    Text {
        id: titleSoundId
        x: 105
        y: 110
        text: qsTr("SYSTEM_VOLUME") + translator.emptyString
        font.pixelSize: 36
        color: "black"
    }

    Image{
        id: volumeId
        width: 60
        height: 60
        anchors.left: titleSoundId.left
        anchors.top: titleSoundId.bottom
        anchors.topMargin: 40
        source: sliderVolume.value < 1 ? "qrc:/App/Settings/Image/volume_umute_black.png" :
            ( sliderVolume.value < 30 ? "qrc:/App/Settings/Image/volume_1s.png" :
            ( sliderVolume.value < 70 ? "qrc:/App/Settings/Image/volume_2s.png" : "qrc:/App/Settings/Image/volume_3s.png"))
    }

    Slider{
        id: sliderVolume
        width: 600
        anchors.left: volumeId.right
        anchors.leftMargin: 40
        anchors.verticalCenter: volumeId.verticalCenter
        property int previousValue: value
        value: player.volume
        from: 0
        to: 100
        handle: Rectangle {
            x: sliderVolume.leftPadding + sliderVolume.visualPosition * (sliderVolume.availableWidth - width)
            y: sliderVolume.topPadding + sliderVolume.availableHeight / 2 - height / 2
            implicitWidth: 15
            implicitHeight: 60
            radius: 10
            color: sliderVolume.pressed ? "#37435D" : "#f6f6f6"
            border.color: "#bdbebf"
        }
        onMoved: {
            player.setVolume(Math.floor(sliderVolume.value))
        }
    }
    Text{
        anchors.left: sliderVolume.right
        anchors.leftMargin: 30
        anchors.verticalCenter: sliderVolume.verticalCenter
        text: Math.floor(sliderVolume.value)
        font.pixelSize: 32
    }
}


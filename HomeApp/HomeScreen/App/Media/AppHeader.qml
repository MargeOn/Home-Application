import QtQuick 2.0
import QtQuick.Controls 2.12
import "../../App"

BaseScreen{
    id: settingAppId
    property alias playlistButtonStatus: playlist_button.status
    signal clickPlaylistButton
    appTitle: qsTr("MAIN_MEDIA_PLAYER_TITLE") + translator.emptyString
    colorRectHeader: "#2b2937"
    SwitchButton {
        id: playlist_button
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        icon_off: "qrc:/App/Media/Image/drawer.png"
        icon_on: "qrc:/App/Media/Image/back.png"
        onClicked: {
            clickPlaylistButton()
        }
    }
    Text {
        anchors.left: playlist_button.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr("MAIN_PLAYLIST_TITLE") + translator.emptyString
        color: "white"
        font.pixelSize: 32
    }
}

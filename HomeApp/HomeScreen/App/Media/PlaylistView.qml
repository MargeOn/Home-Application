import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1

Drawer {
    id: drawerId
    property alias mediaPlaylist: mediaPlaylistId
    interactive: false
    modal: false
    background: Rectangle {
        id: playList_bg
        anchors.fill: parent
        color: "transparent"
    }
    ListView{
        id: mediaPlaylistId
        anchors.fill: parent
        model: playerModel
        clip: true
        spacing: 2
        currentIndex: utility.currentIndex
        delegate: MouseArea{
            property variant myData: model
            implicitWidth: playlistItemId.width
            implicitHeight: playlistItemId.height
            Image{
                id: playlistItemId
                width: 675
                height: 193
                source: "qrc:/App/Media/Image/playlist.png"
                opacity: 0.5
            }

            Text{
                id: textPlaylistItemId
                text: tenbaihat
                anchors.fill: parent
                anchors.leftMargin: 100
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.pointSize: 28
            }

            onClicked: {
                mediaPlaylistId.currentIndex = index
            }

            onPressed: {
                playlistItemId.source = "qrc:/App/Media/Image/hold.png"
            }

            onReleased: {
                playlistItemId.source = "qrc:/App/Media/Image/playlist.png"
            }
            onCanceled: {
                playlistItemId.source = "qrc:/App/Media/Image/playlist.png"
            }
        }
        highlight: Image{
            source: "qrc:/App/Media/Image/playlist_item.png"
            Image{
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/App/Media/Image/playing.png"
            }
        }
        ScrollBar.vertical: ScrollBar {
            parent: mediaPlaylistId.parent
            anchors.top: mediaPlaylistId.top
            anchors.left: mediaPlaylistId.right
            anchors.bottom: mediaPlaylistId.bottom
        }
        onCurrentItemChanged: {
            if(!utility.isOpenApp){
                if(utility.isPlay){
                    player.play()
                }
                else{
                    player.pause()
                }
            }
            else{
                if(mediaPlaylistId.currentIndex !== utility.currentIndex)
                    utility.currentIndex = currentIndex
                player.play()
            }
            console.log("changed current index Listview")
        }
        Component.onCompleted: {
            utility.isOpenApp = true
        }
        Component.onDestruction: {
            utility.isOpenApp = false
        }
    }
    Connections{
        target: utility
        onCurrentIndexChanged: {
            mediaPlaylistId.currentIndex = utility.currentIndex
            console.log("changed current index player")
        }
    }
}

import QtQuick 2.6
import QtQuick.Controls 2.4

Item {
    id: root
    width: 1920
    height: 1200 - 104
    //Header
    // Header
    AppHeader{
        id: appHeaderId
        width: root.width
        height: 141
        playlistButtonStatus: playlistId.visible
        onClickPlaylistButton: {
            if(playlistId.visible){
                playlistId.close()
            }
            else{
                playlistId.open()
            }
        }
    }

    //Playlist
    PlaylistView{
        id: playlistId
        y: 141 + 194/2 + 10
        width: 675
        height: root.height - 141
    }

    //Media Info
    MediaInfoControl{
        id: mediaInfoControlId
        property alias album_art: playlistId.mediaPlaylist
        anchors.top: appHeaderId.bottom
        anchors.right: root.right
        width: 1920 - 675*playlistId.position
        height: root.height - 104 - 141
    }
}

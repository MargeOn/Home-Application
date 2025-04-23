import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.9

Item {
    //Media Info
    Text{
        id: mediaTitleId
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 15
        anchors.leftMargin: 15
        text: playlistId.mediaPlaylist.currentItem.myData.tenbaihat
        color: "white"
        font.pointSize: 26
        onTextChanged: {
            textChangeAniId.restart()
        }
    }
    Text{
        id: singerTitleId
        anchors.top: mediaTitleId.bottom
        anchors.left: mediaTitleId.left
        text: playlistId.mediaPlaylist.currentItem.myData.tencasi
        color: "white"
        font.pointSize: 26
    }

    NumberAnimation {
        id: textChangeAniId
        targets: [mediaTitleId,singerTitleId]
        property: "opacity"
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }

    Text{
        id: musicCountId
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 15
        text: playlistId.mediaPlaylist.count
        color: "white"
        font.pointSize: 28
    }
    Image{
        id: musicImageId
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: musicCountId.left
        anchors.rightMargin: 10
        source: "qrc:/App/Media/Image/music.png"
    }

    //AlbumArt
    Component{
        id: delegateId
        Item {
            width: 400; height: 400
            scale: PathView.iconScale
            Image {
                id: myIcon
                width: parent.width
                height: parent.height
                y: 15
                anchors.horizontalCenter: parent.horizontalCenter
                source: anhbaihat
            }

            MouseArea {
                anchors.fill: parent
                onClicked:{
                    album_art_viewId.currentIndex = index
                }
            }
        }
    }

    PathView{
        id: album_art_viewId
        anchors.left: parent.left
        anchors.leftMargin: (parent.width - 1200)/2
        anchors.top: parent.top
        anchors.topMargin: 300
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: playerModel
        delegate: delegateId
        pathItemCount: 3
        currentIndex: utility.currentIndex
        path: Path{
            // Starting Point
            startX: 20
            startY: 50
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathLine { x: 610; y: 50 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine { x: 1200; y: 50 }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }
        onCurrentIndexChanged: {
            if(album_art_viewId.currentIndex !== utility.currentIndex)
                utility.currentIndex = currentIndex

            console.log("changed current index pathview")
        }
    }

    Text{
        id: currentTimeId
        anchors.verticalCenter: progressBarId.verticalCenter
        anchors.right: progressBarId.left
        anchors.rightMargin: 15
        text: utility.getTimeInfo(player.position)
        color: "white"
        font.pointSize: 20
        Component.onCompleted: {
            console.log("Width text " + currentTimeId.width)
        }
    }

    Slider{
        id: progressBarId
        width: 1568 - 675*playlistId.position
        anchors.verticalCenter: totalTimeId.verticalCenter
        anchors.right: totalTimeId.left
        anchors.rightMargin: 15
        from: 0
        to: player.duration
        value: player.position
        background: Rectangle {
            x: progressBarId.leftPadding
            y: progressBarId.topPadding + progressBarId.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: progressBarId.availableWidth
            height: implicitHeight
            radius: 2
            color: "gray"
            Rectangle {
                width: progressBarId.visualPosition * parent.width
                height: parent.height
                color: "white"
                radius: 2
            }
        }
        handle: Image {
            anchors.verticalCenter: parent.verticalCenter
            x: progressBarId.leftPadding + progressBarId.visualPosition * (progressBarId.availableWidth - width)
            y: progressBarId.topPadding + progressBarId.availableHeight / 2 - height / 2
            source: "qrc:/App/Media/Image/point.png"
            Image {
                anchors.centerIn: parent
                source: "qrc:/App/Media/Image/center_point.png"
            }
        }
        onMoved: {
            if (player.seekable){
                utility.seek(progressBarId.value)
            }
        }
    }

    Text{
        id: totalTimeId
        anchors.top: parent.top
        anchors.topMargin: 638
        anchors.right: parent.right
        anchors.rightMargin: 93
        text: utility.getTimeInfo(player.duration)
        color: "white"
        font.pointSize: 20
        Component.onCompleted: {
            console.log("Width text " + currentTimeId.width)
        }
    }

    //Media control
    SwitchButton{
        id: shuffleButtonId
        anchors.top: parent.top
        anchors.topMargin: 768
        anchors.left: currentTimeId.left
        icon_on: "qrc:/App/Media/Image/shuffle-1.png"
        icon_off: "qrc:/App/Media/Image/shuffle.png"
        status: utility.shuffle
        onClicked: {
                utility.shuffle = !utility.shuffle
        }
    }

    ButtonControl{
        id: previousButtonId
        anchors.verticalCenter: shuffleButtonId.verticalCenter
        anchors.right: playButtonId.left
        icon_default: "qrc:/App/Media/Image/prev.png"
        icon_pressed: "qrc:/App/Media/Image/hold-prev.png"
        icon_released: "qrc:/App/Media/Image/prev.png"
        onClicked: {
            if (shuffleButtonId.status) {
                utility.nextShuffleMedia()
            }
            else{
                utility.setPreviousMedia()
            }
        }
    }

    ButtonControl{
        id: playButtonId
        //property bool isPlay: true
        anchors.horizontalCenter: progressBarId.horizontalCenter
        anchors.verticalCenter: previousButtonId.verticalCenter
        icon_default: utility.isPlay ? "qrc:/App/Media/Image/pause.png" : "qrc:/App/Media/Image/play.png"
        icon_pressed: utility.isPlay ? "qrc:/App/Media/Image/hold-pause.png" : "qrc:/App/Media/Image/hold-play.png"
        icon_released: utility.isPlay ? "qrc:/App/Media/Image/play.png" : "qrc:/App/Media/Image/pause.png"
        onClicked: {
            if(utility.isPlay){
                player.pause()
                utility.isPlay = false
            }
            else{
                if(player.position <= 1){
                    utility.currentIndex = album_art_viewId.currentIndex
                }
                player.play()
                utility.isPlay = true
            }
        }
        Connections {
            target: utility
            onCurrentIndexChanged:{
                if(!utility.isPlay){
                    utility.isPlay = true
                    playButtonId.source = "qrc:/App/Media/Image/pause.png"
                }
            }
        }
    }

    ButtonControl{
        id: nextButtonId
        anchors.verticalCenter: playButtonId.verticalCenter
        anchors.left: playButtonId.right
        icon_default: "qrc:/App/Media/Image/next.png"
        icon_pressed: "qrc:/App/Media/Image/hold-next.png"
        icon_released: "qrc:/App/Media/Image/next.png"
        onClicked: {
            if (shuffleButtonId.status) {
                utility.nextShuffleMedia()
            }
            else{
                utility.setNextMedia()
            }
        }
    }

    SwitchButton{
        id: repeatButtonId
        anchors.verticalCenter: playButtonId.verticalCenter
        anchors.right: totalTimeId.right
        icon_on: "qrc:/App/Media/Image/repeat1_hold.png"
        icon_off: "qrc:/App/Media/Image/repeat.png"
        status: utility.loop
        onClicked: {
            utility.loop = !utility.loop
        }
    }
    // khi bai hat duoc choi cho den het bai, danh sach phat se cap nhat bai tiep theo. Nhung index cua ListView
    // va PathView chua duoc cap nhat. Ta phai ket noi voi QMediaPlaylist de lam dieu nay
    Connections{
        target: utility
        onCurrentIndexChanged: {
            album_art_viewId.currentIndex = utility.currentIndex
        }
    }
}

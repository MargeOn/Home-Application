import QtQuick 2.0
import QtGraphicalEffects 1.0

MouseArea {
    id: root
    x: 5 + 635 + 5 + 635 + 10
    implicitWidth: 635
    implicitHeight: 570
    hoverEnabled: true
    Rectangle {
        anchors{
            fill: parent
            margins: 10
        }
        opacity: 0.7
        color: "#111419"
    }
    Image {
        id: bgBlur
        x:10
        y:10
        width: 615
        height: 550
        source: {
            if (playerModel.rowCount() > 0 && playerModel.rowCount() >  player.playlist.currentIndex)
                return playerModel.data(playerModel.index(utility.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    FastBlur {
        anchors.fill: bgBlur
        source: bgBlur
        radius: 18
    }
    Image {
        id: idBackgroud
        source: ""
        width: root.width
        height: root.height
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
        text: qsTr("USB_MUSIC") + translator.emptyString//"USB Music"
        color: "white"
        font.pixelSize: 32
    }
    Image {
        id: bgInner
        x:201
        y:119
        width: 258
        height: 258
        source: {
            if (playerModel.rowCount() > 0 && playerModel.rowCount() >  player.playlist.currentIndex)
                return playerModel.data(playerModel.index(utility.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    Image{
        x:201
        y:119
        width: 258
        height: 258
        source: "qrc:/Img/HomeScreen/widget_media_album_bg.png"
    }
    Text {
        id: txtSinger
        x: 42
        y: (56+343)
        width: 551
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (playerModel.rowCount() > 0 && playerModel.rowCount() >  player.playlist.currentIndex)
                return playerModel.data(playerModel.index(utility.currentIndex,0), 258)
        }
        color: "white"
        font.pixelSize: 28
    }
    Text {
        id: txtTitle
        x: 42
        y: (56+343+55)
        width: 551
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (playerModel.rowCount() > 0 && playerModel.rowCount() >  player.playlist.currentIndex)
                return playerModel.data(playerModel.index(utility.currentIndex,0), 257)
        }
        color: "white"
        font.pixelSize: 40
    }
    Image{
        id: imgDuration
        x: 62
        y: (56+343+55+62)
        width: 511
        source: "qrc:/Img/HomeScreen/widget_media_pg_n.png"
    }
    Image{
        id: imgPosition
        x: 62
        y: (56+343+55+62)
        width: 0
        source: "qrc:/Img/HomeScreen/widget_media_pg_s.png"
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: ""
            }
        }
    ]
    onPressed: {
        root.state = "Pressed"
        console.log("Focus media pressed")
    }
    onReleased:{
        if(containsMouse){
            root.state = "Focus"
            root.forceActiveFocus()
        }
        else if(!containsMouse && root.focus) {
            root.state = "Focus"
        }
        else{
            root.state = "Normal"
        }
    }
    onFocusChanged: {
        console.log("Focus media changed")
        if (root.focus == true ){
            root.state = "Focus"
        }
        else{
            root.state = "Normal"
        }
    }

    Connections{
        target: utility
        onCurrentIndexChanged:{
            if (playerModel.rowCount() > 0 && playerModel.rowCount() >  player.playlist.currentIndex) {
                bgBlur.source = playerModel.data(playerModel.index(utility.currentIndex,0), 260)
                bgInner.source = playerModel.data(playerModel.index(utility.currentIndex,0), 260)
                txtSinger.text = playerModel.data(playerModel.index(utility.currentIndex,0), 258)
                txtTitle.text = playerModel.data(playerModel.index(utility.currentIndex,0), 257)
            }
        }
    }

    Connections{
        target: player
        onDurationChanged:{
            imgDuration.width = 511
        }
        onPositionChanged: {
            imgPosition.width = (player.position / player.duration)*(511);
            console.log(player.position)
        }
    }
}

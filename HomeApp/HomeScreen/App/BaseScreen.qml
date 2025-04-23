import QtQuick 2.0

Item {
    width: 1920
    height: 1200 - 104
    property string appTitle: ""
    property alias colorRectHeader: headerAppId.color
    Rectangle{
        id: headerAppId
        width: parent.width
        height: 141
        color: "#37435D"
        Text {
            id: titleApp
            anchors.centerIn: parent
            text: appTitle
            color: "white"
            font.pixelSize: 50
        }
    }
}

import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1

FocusScope {
    id: root
    width: 1920
    height: 1096
    property string currentFocusWidget: "map"
    property int    currentFocusApp:    0
    property bool   isDrag:             false
    property string currentAppUrl:      ""
    function openApplication(url){
        parent.push(url)
    }
    function openWidget(){
        if(root.currentFocusWidget === "map"){
            openApplication("qrc:/App/Map/Map.qml")
        }
        else if(root.currentFocusWidget === "climate"){
            openApplication("qrc:/App/Climate/Climate.qml")
        }
        else if(root.currentFocusWidget === "media"){
            openApplication("qrc:/App/Media/Media.qml")
        }
    }

    function moveLeftWidget(){
        if(root.currentFocusWidget === "climate"){
            root.currentFocusWidget = "map"
        }
        else if(root.currentFocusWidget === "media"){
            root.currentFocusWidget = "climate"
        }
    }
    function moveRightWidget(){
        if(root.currentFocusWidget === "map"){
            root.currentFocusWidget = "climate"
        }
        else if(root.currentFocusWidget === "climate"){
            root.currentFocusWidget = "media"
        }
    }
    function moveUpWidget(){
        root.currentFocusWidget = "map"
    }

    function moveLeftApp(){
        if(root.currentFocusApp > 1)
            root.currentFocusApp--
        lvApplication.positionViewAtIndex(root.currentFocusApp - 1, ListView.Visible)
    }
    function moveRightApp(){
        if(root.currentFocusApp < visualModel.items.count)
            root.currentFocusApp++
        lvApplication.positionViewAtIndex(root.currentFocusApp - 1, ListView.Visible)
    }
    function moveUpApp(){
        root.currentFocusWidget = "map"
        root.currentFocusApp = 0
        lvApplication.positionViewAtBeginning()
    }

    function moveDownWidgetOrApp(){
        root.currentFocusWidget = "none"
        root.currentFocusApp = 1
        lvApplication.positionViewAtBeginning()
    }

    ListView {
        id: lvWidget
        orientation: ListView.Horizontal
        width: 1920
        height: 570
        interactive: false

        model: ListModel {
            id: widgetModel
            ListElement { type: "map" }//@disable-check M16
            ListElement { type: "climate" }//@disable-check M16
            ListElement { type: "media" }//@disable-check M16
        }

        delegate: Loader {
            id: iconWidget
            width: 635; height: 570
            anchors {
                horizontalCenter: parent.horizontalCenter;
                verticalCenter: parent.verticalCenter
            }

            sourceComponent: {
                switch(model.type) {
                case "map": return mapWidget
                case "climate": return climateWidget
                case "media": return mediaWidget
                }
            }
        }
        Component {
            id: mapWidget
            MapWidget{
                focus: root.currentFocusWidget === "map"
                onClicked: {
                    root.currentFocusWidget = "map"
                    root.currentFocusApp = 0
                    openApplication("qrc:/App/Map/Map.qml")
                }
            }
        }
        Component {
            id: climateWidget
            ClimateWidget {
                focus: root.currentFocusWidget === "climate"
                onClicked: {
                    root.currentFocusWidget = "climate"
                    root.currentFocusApp = 0
                    openApplication("qrc:/App/Climate/Climate.qml")
                }
            }
        }
        Component {
            id: mediaWidget
            MediaWidget{
                focus: root.currentFocusWidget === "media"
                onClicked: {
                    root.currentFocusWidget = "media"
                    root.currentFocusApp = 0
                    openApplication("qrc:/App/Media/Media.qml")
                }
            }
        }
    }
    ListView {
        id: lvApplication
        x: 0
        y:570
        width: 1920; height: 604
        orientation: ListView.Horizontal
        spacing: 5
        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }
        property string urlApp: ""
        model: DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                id: delegateRoot
                width: 316; height: 604
                keys: "AppButton"
                onEntered: {
                    visualModel.items.move(drag.source.visualIndex, icon.visualIndex)
                    appsModel.moveItem(drag.source.visualIndex, icon.visualIndex)
                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: icon; property: "visualIndex"; value: visualIndex }

                FocusScope {
                    id: icon
                    property int visualIndex: 0
                    width: 316; height: 604
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }
                    AppButton{
                        id: app
                        anchors.fill: parent
                        title: qsTr(model.title) + translator.emptyString
                        icon: model.iconPath
                        focus: root.currentFocusApp === delegateRoot.visualIndex + 1
                        onClicked: {
                            openApplication(model.url)
                            app.state = "Focus"
                            root.currentFocusApp = delegateRoot.visualIndex + 1
                            root.currentFocusWidget = "none"
                        }
                        onFocusChanged: {
                            if(focus){
                                lvApplication.urlApp = model.url
                            }
                        }
                        onPressAndHold: {
                            app.state = "Normal"
                            if(root.currentFocusWidget !== "none" || root.currentFocusApp != 0){
                                root.currentFocusWidget = "none"
                                root.currentFocusApp = 0
                            }
                            app.drag.target = icon
                            root.isDrag = true
                        }
                        onReleased: {
                            app.drag.target = null
                            root.currentFocusApp = delegateRoot.visualIndex + 1
                            app.forceActiveFocus()
                            if(root.isDrag)
                                root.isDrag = false
                        }
                    }

                    Drag.active: app.drag.active
                    Drag.keys: "AppButton"

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }

        }
        ScrollBar.horizontal: ScrollBar {
            parent: lvApplication
            anchors.bottom: lvApplication.top
            anchors.left: lvApplication.left
            anchors.right: lvApplication.right
            orientation: Qt.Horizontal
            contentItem: Rectangle{
                implicitWidth: 10
                implicitHeight: 8
                color: "grey"
                radius: 10
            }
        }
    }

    Keys.onPressed: {
        // switch case
        if(root.currentFocusWidget !== "none"){
            switch (event.key){
            case Qt.Key_Left:
                root.moveLeftWidget()
                break
            case Qt.Key_Right:
                root.moveRightWidget()
                break
            case Qt.Key_Up:
                root.moveUpWidget()
                break
            case Qt.Key_Down:
                root.moveDownWidgetOrApp()
                break
            case Qt.Key_Enter:
                root.openWidget()
                break
            case Qt.Key_Return:
                root.openWidget()
                break
            }
        }
        else if(root.currentFocusApp !== 0){
            switch (event.key){
            case Qt.Key_Left:
                root.moveLeftApp()
                break
            case Qt.Key_Right:
                root.moveRightApp()
                break
            case Qt.Key_Up:
                root.moveUpApp()
                break
            case Qt.Key_Down:
                root.moveDownWidgetOrApp()
                break
            case Qt.Key_Enter:
                root.openApplication(lvApplication.urlApp)
                break
            case Qt.Key_Return:
                root.openApplication(lvApplication.urlApp)
                break
            }
        }
    }
}

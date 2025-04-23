import QtQuick 2.0
MouseArea {
    id: root
    x: 5 + 635 + 5
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
        id: idBackgroud
        source: ""
        width: root.width
        height: root.height
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
        text: qsTr("TITLE_CLIMATE_WIDGET") + translator.emptyString//"Climate"
        color: "white"
        font.pixelSize: 34
    }
    //Driver
    Text {
        x: 43
        y: 135
        width: 184
        text: qsTr("TITLE_DRIVER") + translator.emptyString//"DRIVER"
        color: "white"
        font.pixelSize: 34
        horizontalAlignment: Text.AlignHCenter
    }
    Image {
        x:43
        y: (135+41)
        width: 184
        source: "qrc:/Img/HomeScreen/widget_climate_line.png"
    }
    Image {
        x: (55+25+26)
        y:205
        width: 110
        height: 120
        source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
    }
    Image {
        x: (55+25)
        y:(205+34)
        width: 70
        height: 50
        source: climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"

    }
    Image {
        x: 55
        y:(205+34+26)
        width: 70
        height: 50
        source: climateModel.driver_wind_mode == 1 || climateModel.driver_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
    }
    Text {
        id: driver_temp
        x: 43
        y: (248 + 107)
        width: 184
        text: "°C"
        color: "white"
        font.pixelSize: 46
        horizontalAlignment: Text.AlignHCenter
    }

    //Passenger
    Text {
        x: (43+184+182)
        y: 135
        width: 184
        text: qsTr("TITLE_PASSENGER") + translator.emptyString//"PASSENGER"
        color: "white"
        font.pixelSize: 34
        horizontalAlignment: Text.AlignHCenter
    }
    Image {
        x: (43+184+182)
        y: (135+41)
        width: 184
        source: "qrc:/Img/HomeScreen/widget_climate_line.png"
    }
    Image {
        x: (55+25+26+314+25+26)
        y:205
        width: 110
        height: 120
        source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
    }
    Image {
        x: (55+25+26+314+25)
        y: (205+34)
        width: 70
        height: 50
        source: climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
    }
    Image {
        x: (55+25+26+314)
        y: (205+34+26)
        width: 70
        height: 50
        source: climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
    }
    Text {
        id: passenger_temp
        x: (43+184+182)
        y: (248 + 107)
        width: 184
        text: "°C"
        color: "white"
        font.pixelSize: 46
        horizontalAlignment: Text.AlignHCenter
    }
    //Wind level
    Image {
        x: 172
        y: 248
        width: 290
        height: 100
        source: "qrc:/Img/HomeScreen/widget_climate_wind_level_bg.png"
    }
    Image {
        id: fan_level
        x: 172
        y: 248
        width: 290
        height: 100
        source: "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
    }
    Connections{
        target: translator
        onLanguageChanged: {
            if (climateModel.driver_temp == 16.5) {
                driver_temp.text = qsTr("STR_LOW")
            } else if (climateModel.driver_temp == 31.5) {
                driver_temp.text = qsTr("STR_HIGH")
            } else {
                driver_temp.text = climateModel.driver_temp+"°C"
            }

            //set data for passenger temp
            if (climateModel.passenger_temp == 16.5) {
                passenger_temp.text = qsTr("STR_LOW")
            } else if (climateModel.passenger_temp == 31.5) {
                passenger_temp.text = qsTr("STR_HIGH")
            } else {
                passenger_temp.text = climateModel.passenger_temp+"°C"
            }
        }
    }

    Connections{
        target: climateModel
        onDataChanged: {
            //set data for fan level
            if (climateModel.fan_level < 1) {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
            }
            else if (climateModel.fan_level < 10) {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_0"+climateModel.fan_level+".png"
            } else {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_"+climateModel.fan_level+".png"
            }
            //set data for driver temp
            if (climateModel.driver_temp == 16.5) {
                driver_temp.text = qsTr("STR_LOW")
            } else if (climateModel.driver_temp == 31.5) {
                driver_temp.text = qsTr("STR_HIGH")
            } else {
                driver_temp.text = climateModel.driver_temp+"°C"
            }

            //set data for passenger temp
            if (climateModel.passenger_temp == 16.5) {
                passenger_temp.text = qsTr("STR_LOW")
            } else if (climateModel.passenger_temp == 31.5) {
                passenger_temp.text = qsTr("STR_HIGH")
            } else {
                passenger_temp.text = climateModel.passenger_temp+"°C"
            }
        }
    }

    //Fan
    Image {
        x: (172 + 115)
        y: (248 + 107)
        width: 60
        height: 60
        source: "qrc:/Img/HomeScreen/widget_climate_ico_wind.png"
    }
    //Bottom
    Text {
        x:30
        y:(466 + 18)
        width: 172
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("TITLE_AUTO_MODE") + translator.emptyString//"AUTO"
        color: !climateModel.auto_mode ? "white" : "gray"
        font.pixelSize: 46
    }
    Text {
        x:(30+172+30)
        y:466
        width: 171
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("TITLE_OUTSIDE") + translator.emptyString//"OUTSIDE"
        color: "white"
        font.pixelSize: 26
    }
    Text {
        x:(30+172+30)
        y:(466 + 18 + 21)
        width: 171
        horizontalAlignment: Text.AlignHCenter
        text: "27.5°C"
        color: "white"
        font.pixelSize: 38
    }
    Text {
        x:(30+172+30+171+30)
        y:(466 + 18)
        width: 171
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("TITLE_SYNC_MODE") + translator.emptyString//"SYNC"
        color: !climateModel.sync_mode ? "white" : "gray"
        font.pixelSize: 46
    }
    //
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
        console.log("Focus climate pressed")
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
        console.log("Focus climate changed")
        if (root.focus == true ){
            root.state = "Focus"
        }
        else{
            root.state = "Normal"
        }
    }
}


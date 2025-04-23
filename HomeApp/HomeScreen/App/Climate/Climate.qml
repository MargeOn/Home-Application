import QtQuick 2.0
import "../../App"

BaseScreen{
    id: settingAppId
    appTitle: qsTr("TITLE_CLIMATE") + translator.emptyString
    colorRectHeader: "#2b2937"
    Item{
        anchors.centerIn: parent
        implicitWidth: 615
        implicitHeight: 570
        Text {
            id: title
            anchors.horizontalCenter: parent.horizontalCenter
            y: 40
            text: qsTr("TITLE_CLIMATE") + translator.emptyString
            color: "white"
            font.pixelSize: 34
        }
        //Driver
        Text {
            x: 43
            y: 135
            width: 184
            text: qsTr("DRIVER") + translator.emptyString
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
            id: driverFaceModeId
            x: (55+25)
            y:(205+34)
            width: 70
            height: 50
            source: climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"

        }
        Image {
            id: driverFootModeId
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
            text: qsTr("PASSENGER") + translator.emptyString
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
            id: passengerFaceModeId
            x: (55+25+26+314+25)
            y: (205+34)
            width: 70
            height: 50
            source: climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
        }
        Image {
            id: passengerFootModeId
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
            target: climateModel
            onDataChanged: {
                driverFaceModeId.source = climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                            "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
                driverFootModeId.source = climateModel.driver_wind_mode == 1 || climateModel.driver_wind_mode == 2 ?
                            "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
                passengerFaceModeId.source = climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                            "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
                passengerFootModeId.source = climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                            "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
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
                autoMode.color = !climateModel.auto_mode ? "white" : "gray"
                syncMode.color = !climateModel.sync_mode ? "white" : "gray"
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
            id: autoMode
            x:30
            y:(466 + 18)
            width: 172
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("AUTO_MODE") + translator.emptyString
            color: !climateModel.auto_mode ? "white" : "gray"
            font.pixelSize: 46
        }
        Text {
            x:(30+172+30)
            y:466
            width: 171
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("OUTSIDE") + translator.emptyString
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
            id: syncMode
            x:(30+172+30+171+30)
            y:(466 + 18)
            width: 171
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("SYNC_MODE") + translator.emptyString
            color: !climateModel.sync_mode ? "white" : "gray"
            font.pixelSize: 46
        }
        Component.onCompleted: {
            driverFaceModeId.source = climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
            driverFootModeId.source = climateModel.driver_wind_mode == 1 || climateModel.driver_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
            passengerFaceModeId.source = climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
            passengerFootModeId.source = climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                        "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"

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

            autoMode.color = !climateModel.auto_mode ? "white" : "gray"
            syncMode.color = !climateModel.sync_mode ? "white" : "gray"
        }
    }
}

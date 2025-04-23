import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Climate simulator")

    function saveData() {
        climate.setData(driverTemp.realValue,passengerTemp.realValue,fanLevel.value,driver_wind_mode.currentIndex,passenger_wind_mode.currentIndex,auto_mode.currentIndex,sync_mode.currentIndex)
    }

    Text {
        id: temp1
        x: 20
        y: 20
        text: "Temperature driver: "
        horizontalAlignment: Text.AlignHCenter
    }

    SpinBox {
        id: driverTemp
        anchors.left: passengerTemp.left
        anchors.verticalCenter: temp1.verticalCenter
        from: 165
        to: 315
        stepSize: 5

        property int decimals: 1
        property real realValue: value / 10

        validator: DoubleValidator {
            bottom: Math.min(driverTemp.from, driverTemp.to)
            top:  Math.max(driverTemp.from, driverTemp.to)
        }

        textFromValue: function(value, locale) {
            return Number(value / 10).toLocaleString(locale, 'f', driverTemp.decimals)
        }

        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text)
        }

        onRealValueChanged: saveData()
    }

    Text {
        id: temp2
        anchors.top: temp1.bottom
        anchors.topMargin: 30
        anchors.left: temp1.left
        text: "Temperature passenger: "
        horizontalAlignment: Text.AlignHCenter
    }
    SpinBox {
        id: passengerTemp
        anchors.left: temp2.right
        anchors.leftMargin: 20
        anchors.verticalCenter: temp2.verticalCenter
        from: 165
        to: 315
        stepSize: 5

        property int decimals: 1
        property real realValue: value / 10

        validator: DoubleValidator {
            bottom: Math.min(driverTemp.from, driverTemp.to)
            top:  Math.max(driverTemp.from, driverTemp.to)
        }

        textFromValue: function(value, locale) {
            return Number(value / 10).toLocaleString(locale, 'f', driverTemp.decimals)
        }

        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text)
        }

        onRealValueChanged: saveData()
    }
    Text {
        id: fan
        anchors.top: temp2.bottom
        anchors.topMargin: 30
        anchors.left: temp2.left
        text: "Fan: "
        horizontalAlignment: Text.AlignHCenter
    }

    Row {
        id: r1
        anchors.right: passengerTemp.right
        anchors.verticalCenter: fan.verticalCenter
        Slider {
            id: fanLevel
            from : 1
            to: 10
            stepSize: 1
            value: 0
            onValueChanged: saveData()
        }
        Text {
            id: valueSlider
            text: fanLevel.value
            horizontalAlignment: Text.AlignHCenter
        }
    }
    Text {
        id: driver_wind_mode_txt
        anchors.top: fan.bottom
        anchors.topMargin: 30
        anchors.left: temp1.left
        text: "Driver wind direction"
        horizontalAlignment: Text.AlignHCenter
    }

    ComboBox {
        id: driver_wind_mode
        anchors.verticalCenter: driver_wind_mode_txt.verticalCenter
        anchors.left: passengerTemp.left
        textRole: "key"
        model: ListModel {
            ListElement {
                key: "on face"
                value: 0
            }
            ListElement {
                key: "on foot"
                value: 1
            }
            ListElement {
                key: "on face and foot"
                value: 2
            }
        }
        onCurrentIndexChanged: saveData()
    }
    Text {
        id: passenger_wind_mode_txt
        anchors.top: driver_wind_mode_txt.bottom
        anchors.topMargin: 30
        anchors.left: temp1.left
        text: "Passenger wind direction"
        horizontalAlignment: Text.AlignHCenter
    }

    ComboBox {
        id: passenger_wind_mode
        anchors.verticalCenter: passenger_wind_mode_txt.verticalCenter
        anchors.left: passengerTemp.left
        textRole: "key"
        model: ListModel {
            ListElement {
                key: "on face"
                value: 0
            }
            ListElement {
                key: "on foot"
                value: 1
            }
            ListElement {
                key: "on face and foot"
                value: 2
            }
        }
        onCurrentIndexChanged:saveData()
    }
    Text {
        id: auto_mode_txt
        anchors.left: temp1.left
        anchors.top: passenger_wind_mode_txt.bottom
        anchors.topMargin: 30
        text: "AUTO mode: "
        horizontalAlignment: Text.AlignHCenter
    }

    ComboBox {
        id: auto_mode
        anchors.left: passengerTemp.left
        anchors.verticalCenter: auto_mode_txt.verticalCenter
        textRole: "key"
        model: ListModel {
            ListElement {
                key: "ON"
                value: 0
            }
            ListElement {
                key: "OFF"
                value: 1
            }
        }
        onCurrentIndexChanged: saveData()
    }
    Text {
        id: sync_mode_txt
        anchors.left: temp1.left
        anchors.top: auto_mode_txt.bottom
        anchors.topMargin: 30
        text: "SYNC mode: "
        horizontalAlignment: Text.AlignHCenter
    }

    ComboBox {
        id: sync_mode
        anchors.left: passengerTemp.left
        anchors.verticalCenter: sync_mode_txt.verticalCenter
        textRole: "key"
        model: ListModel {
            ListElement {
                key: "ON"
                value: 0
            }
            ListElement {
                key: "OFF"
                value: 1
            }
        }
        onCurrentIndexChanged: saveData()
    }

    Component.onCompleted: {
        saveData()
    }
}

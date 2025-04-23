import QtQuick 2.0
import "../../App"

BaseScreen{
    id: settingAppId
    appTitle: qsTr("TITLE_SETTINGS_APP") + translator.emptyString
    LeftArea{
        id: listSettings
        x: 105
        y: 200
    }
    RightArea{
        id: doSettings
        x: 653
        y: 200
    }
}

import QtQuick 2.0

Item {
    Rectangle{
        id: brgdId
        width: 1161
        height: 821
        color: "#F2F2F2"
        radius: 10
    }

    DisplaySetting{
        id: disSetting
        visible: true
    }

    SoundSetting{
        id: soundSetting
        visible: false
    }

    NotifySetting{
        id: notifySetting
        visible: false
    }

    BatterySetting{
        id: batterySetting
        visible: false
    }

    GeneralSetting{
        id: genSetting
        visible: false
    }
    Connections{
        target: listSettings
        onSelectedSetting:{
            if(index == 0){
                disSetting.visible = true
                soundSetting.visible = false
                notifySetting.visible = false
                batterySetting.visible = false
                genSetting.visible = false
            }
            else if(index === 1){
                disSetting.visible = false
                soundSetting.visible = true
                notifySetting.visible = false
                batterySetting.visible = false
                genSetting.visible = false
            }
            else if(index == 2){
                disSetting.visible = false
                soundSetting.visible = false
                notifySetting.visible = true
                batterySetting.visible = false
                genSetting.visible = false
            }
            else if(index == 3){
                disSetting.visible = false
                soundSetting.visible = false
                notifySetting.visible = false
                batterySetting.visible = true
                genSetting.visible = false
            }
            else if(index == 4){
                disSetting.visible = false
                soundSetting.visible = false
                notifySetting.visible = false
                batterySetting.visible = false
                genSetting.visible = true
            }
        }
    }
}

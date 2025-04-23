#include "climatemodel.h"

ClimateModel::ClimateModel(QObject *parent) : QObject(parent)
{
    m_climate = new local::Climate("org.ivi","/Climate", QDBusConnection::sessionBus(), this);
    if (m_climate->isValid()){
        qDebug() << "Climate dbus connect success";
        QObject::connect(m_climate,&local::Climate::dataChanged,this,&ClimateModel::dataChanged);
    } else {
        qDebug() << "Climate dbus connect error";
    }
}

double ClimateModel::GetDriverTemperature()
{
    return m_climate->getTemp_driver();
}

double ClimateModel::GetPassengerTemperature()
{
    return m_climate->getTemp_passenger();
}

int ClimateModel::GetFanLevel()
{
    return m_climate->getFan_speed();
}

int ClimateModel::GetDriverWindMode()
{
    return m_climate->getDriverWind_mode();
}

int ClimateModel::GetPassengerWindMode()
{
    return m_climate->getPassengerWind_mode();
}

int ClimateModel::GetAutoMode()
{
    return m_climate->getAuto_mode();
}

int ClimateModel::GetSyncMode()
{
    return m_climate->getSync_mode();
}

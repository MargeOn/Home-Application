#include "climate.h"


Climate::Climate(QObject *parent) : QObject(parent)
{
    m_climateAdaptor = new ClimateAdaptor(this);
    // connect to D-Bus and register as an object:
    QDBusConnection::sessionBus().registerObject("/Climate", this);
    QDBusConnection::sessionBus().registerService("org.ivi");
}

int Climate::getAuto_mode()
{
    return m_auto_mode;
}

int Climate::getDriverWind_mode()
{
    return m_driver_wind_mode;
}

int Climate::getFan_speed()
{
    return m_fan_level;
}

int Climate::getPassengerWind_mode()
{
    return m_passenger_wind_mode;
}

int Climate::getSync_mode()
{
    return m_sync_mode;
}

double Climate::getTemp_driver()
{
    return m_driver_temp;
}

double Climate::getTemp_passenger()
{
    return m_passenger_temp;
}

void Climate::setData(double temp_driver, double temp_passenger, int fan_speed, int driver_wind_mode, int passenger_wind_mode, int auto_mode, int sync_mode)
{
    m_driver_temp = temp_driver;
    m_passenger_temp = temp_passenger;
    m_fan_level = fan_speed;
    m_driver_wind_mode = driver_wind_mode;
    m_passenger_wind_mode = passenger_wind_mode;
    m_auto_mode = auto_mode;
    m_sync_mode = sync_mode;
    emit m_climateAdaptor->dataChanged();
}

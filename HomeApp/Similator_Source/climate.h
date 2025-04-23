#ifndef CLIMATE_H
#define CLIMATE_H
#include <climate_adaptor.h>
#include <QDBusConnection>

#include <QObject>

class Climate : public QObject
{
    Q_OBJECT
public:
    explicit Climate(QObject *parent = nullptr);

private:
    ClimateAdaptor* m_climateAdaptor;
    double m_driver_temp;
    double m_passenger_temp;
    int m_fan_level;
    int m_driver_wind_mode;
    int m_passenger_wind_mode;
    int m_auto_mode;
    int m_sync_mode;

signals:
    void dataChanged();

public slots:
    int getAuto_mode();
    int getDriverWind_mode();
    int getFan_speed();
    int getPassengerWind_mode();
    int getSync_mode();
    double getTemp_driver();
    double getTemp_passenger();
    void setData(double temp_driver, double temp_passenger, int fan_speed, int driver_wind_mode, int passenger_wind_mode, int auto_mode, int sync_mode);

};

#endif // CLIMATE_H

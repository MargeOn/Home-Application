#ifndef CLIMATEMODEL_H
#define CLIMATEMODEL_H

#include <QObject>
#include <climate_interface.h>
#include <QDBusConnection>

class ClimateModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double driver_temp READ GetDriverTemperature NOTIFY dataChanged)
    Q_PROPERTY(double passenger_temp READ GetPassengerTemperature NOTIFY dataChanged)
    Q_PROPERTY(int driver_wind_mode READ GetDriverWindMode NOTIFY dataChanged)
    Q_PROPERTY(int passenger_wind_mode READ GetPassengerWindMode NOTIFY dataChanged)
    Q_PROPERTY(int fan_level READ GetFanLevel NOTIFY dataChanged)
    Q_PROPERTY(int auto_mode READ GetAutoMode NOTIFY dataChanged)
    Q_PROPERTY(int sync_mode READ GetSyncMode NOTIFY dataChanged)
public:
    explicit ClimateModel(QObject *parent = nullptr);

private:
    double GetDriverTemperature();
    double GetPassengerTemperature();
    int GetFanLevel();
    int GetDriverWindMode();
    int GetPassengerWindMode();
    int GetAutoMode();
    int GetSyncMode();

    local::Climate* m_climate;

signals:
    void dataChanged();
public slots:
};

#endif // CLIMATEMODEL_H

#ifndef TIMER_H
#define TIMER_H

#include <QObject>
#include <QDateTime>
#include <QLocale>

class Timer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentDate READ currentDate WRITE setCurrentDate NOTIFY currentDateChanged)
    Q_PROPERTY(QString currentTime READ currentTime WRITE setCurrentTime NOTIFY currentTimeChanged)

public:
    explicit Timer(QObject *parent = nullptr);
    QString currentDate() const;
    QString currentTime() const;

public slots:
    void setCurrentDate(QString currentDate);
    void setCurrentTime(QString currentTime);
    void setLocalTime();
    Q_INVOKABLE void setLocalDate(QString language);

signals:
    void currentDateChanged();
    void currentTimeChanged();

private:
    QString m_currentDate;
    QString m_currentTime;
};

#endif // TIMER_H

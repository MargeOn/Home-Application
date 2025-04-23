#include "timer.h"
#include <QTimer>

Timer::Timer(QObject *parent) : QObject(parent)
{
    QTimer *timer = new QTimer(this);
    timer->setInterval(1000);
    QObject::connect(timer, &QTimer::timeout, this, &Timer::setLocalTime);
    timer->start();
}

QString Timer::currentDate() const
{
    return m_currentDate;
}

QString Timer::currentTime() const
{
    return m_currentTime;
}

void Timer::setCurrentDate(QString currentDate)
{
    if (m_currentDate == currentDate)
        return;
    m_currentDate = currentDate;
    emit currentDateChanged();
}

void Timer::setLocalDate(QString language)
{
    QDate date = QDate::currentDate();
    QString s_date;
    if(language == "us"){
        QLocale locale(QLocale::English,QLocale::UnitedStates);
        s_date = locale.toString(date, "MMM. dd");
    }
    else if(language == "vn"){
        QLocale locale(QLocale::Vietnamese,QLocale::Vietnam);
        s_date = locale.toString(date, "MMM. dd");
    }
    else if(language == "kr"){
        QLocale locale(QLocale::Korean,QLocale::SouthKorea);
        s_date = locale.toString(date, "MMM. dd");
    }
    else if(language == "jp"){
        QLocale locale(QLocale::Japanese,QLocale::Japan);
        s_date = locale.toString(date, "MMM. dd");
    }
    setCurrentDate(s_date);
}

void Timer::setCurrentTime(QString currentTime)
{
    if (m_currentTime == currentTime)
        return;

    m_currentTime = currentTime;
    emit currentTimeChanged();
}

void Timer::setLocalTime()
{
    QTime m_time;
    QString tempTime = m_time.currentTime().toString("hh:mm");
    setCurrentTime(tempTime);
}

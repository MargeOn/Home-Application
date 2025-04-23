#ifndef TRANSLATORSETTING_H
#define TRANSLATORSETTING_H

#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include <QDebug>

class TranslatorSetting : public QObject
{
    Q_OBJECT
    // Biến emptyString dùng để QML nhận biết và hiển thị ngôn ngữ mới khi có sự thay đổi ngôn ngữ
    Q_PROPERTY(QString emptyString READ emptyString NOTIFY languageChanged)
    Q_PROPERTY(QString currentLanguage READ currentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
public:
    TranslatorSetting( QGuiApplication *app, QObject *parent = nullptr);
    enum LANGUAGE{
        UnitedStates,
        Vietnamese,
        Korean,
        Japanese
    };
    Q_INVOKABLE void selectLanguage(int indexLanguage);
    void selectedCurrentLanguage(int indexLanguage);
    QString emptyString() const;
    QString currentLanguage() const;

public slots:
    void setCurrentLanguage(QString currentLanguage);

signals:
    void languageChanged();
    void currentLanguageChanged();

private:
    QTranslator *translator;
    QGuiApplication *m_app;
    QString m_currentLanguage;
};

#endif // TRANSLATORSETTING_H

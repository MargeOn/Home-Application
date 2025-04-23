#include "translatorsetting.h"

TranslatorSetting::TranslatorSetting( QGuiApplication *app, QObject *parent)
    : QObject(parent), translator(new QTranslator(this)),
      m_app(app)
{

}


void TranslatorSetting::selectLanguage(int indexLanguage)
{
    selectedCurrentLanguage(indexLanguage);
    emit languageChanged();
}

void TranslatorSetting::selectedCurrentLanguage(int indexLanguage)
{
    if(indexLanguage == TranslatorSetting::UnitedStates){
        if(translator->load(":/translation_us.qm")){
            qDebug() << "us";
        }
        else{
            qDebug() << "Cannot open file us.qm";
        }
        m_app->installTranslator(translator);
        m_currentLanguage = "us";
    }
    else if(indexLanguage == TranslatorSetting::Vietnamese){
        if(translator->load(":/translation_vn.qm")){
            qDebug() << "vn";
        }
        else{
            qDebug() << "Cannot open file vn.qm";
        }
        m_app->installTranslator(translator);
        m_currentLanguage = "vn";
    }
    else if(indexLanguage == TranslatorSetting::Korean){
        if(translator->load(":/translation_kr.qm")){
            qDebug() << "kr";
        }
        else{
            qDebug() << "Cannot open file kr.qm";
        }
        m_app->installTranslator(translator);
        m_currentLanguage = "kr";
    }
    else if(indexLanguage == TranslatorSetting::Japanese){
        if(translator->load(":/translation_jp.qm")){
            qDebug() << "jp";
        }
        else{
            qDebug() << "Cannot open file jp.qm";
        }
        m_app->installTranslator(translator);
        m_currentLanguage = "jp";
    }
    emit currentLanguageChanged();
}

QString TranslatorSetting::emptyString() const
{
    return "";
}

QString TranslatorSetting::currentLanguage() const
{
    return m_currentLanguage;
}

void TranslatorSetting::setCurrentLanguage(QString currentLanguage)
{
    if (m_currentLanguage == currentLanguage)
        return;

    m_currentLanguage = currentLanguage;
    emit currentLanguageChanged();
}


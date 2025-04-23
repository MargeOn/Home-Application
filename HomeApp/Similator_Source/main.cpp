#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "climate.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Climate* climate = new Climate(&app);
    QQmlContext *ctx = engine.rootContext();
    ctx->setContextProperty("climate", climate);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}

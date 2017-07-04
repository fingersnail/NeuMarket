#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <QtQml>
#include <QGraphicsEffect>
#include "controllayer.h"
#include "colortransformer.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    // 首先注册一下单例
    qmlRegisterType<ControlLayer>("neuintership.market.ControlLayer",
                                           1,0,"ControlLayer");
    qmlRegisterType<TheClassModel>("neuintership.market.TheClassModel",
                                               1,0,"TheClassModel");
    qmlRegisterType<ColorTransFormer>("ColorTransFormer",
                                      1,0,"MColorTransFormer");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();

}


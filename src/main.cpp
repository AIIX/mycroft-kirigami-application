#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "mycroftinterface_dbus.h"
#include <QtDBus>
#include <QtQml>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    MycroftDbusAdapterInterface MycroftDbusAdapterInterface(&app);
    engine.rootContext()->setContextProperty("MycroftDbusAdapterInterface", &MycroftDbusAdapterInterface);
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    return app.exec();
}

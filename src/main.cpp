#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "mycroftinterface_dbus.h"
#include "msmapp.h"
#include <QtDBus>
#include <QtQml>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<MsmApp>("MsmInstaller", 1, 0, "MsmApp");
    MycroftDbusAdapterInterface MycroftDbusAdapterInterface(&app);
    engine.rootContext()->setContextProperty("MycroftDbusAdapterInterface", &MycroftDbusAdapterInterface);
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    return app.exec();
}

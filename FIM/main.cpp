#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "post_req_camera.h"


int main(int argc, char *argv[])
{
//#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setApplicationName("FAITH IN ME");
    QGuiApplication::setOrganizationName("KOMTEK");
//#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Imagine");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<POST_REQ_CAMERA>("POST_REQ_CAMERA", 1, 0, "POST_REQ_CAMERA");
    engine.load(url);

    return app.exec();
}

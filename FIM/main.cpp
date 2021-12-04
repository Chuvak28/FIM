#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QStandardPaths>
#include <QSqlDatabase>
#include <QSqlError>
#include <QtQml>
#include "post_req_camera.h"
#include "sqlcontactmodel.h"
#include "sqlconversationmodel.h"
#include "post_req.h"

static void connectToDatabase()
{
    QSqlDatabase database = QSqlDatabase::database();
    if (!database.isValid()) {
        database = QSqlDatabase::addDatabase("QSQLITE");
        if (!database.isValid())
            qFatal("Cannot add database: %s", qPrintable(database.lastError().text()));
    }

    const QDir writeDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    if (!writeDir.mkpath("."))
        qFatal("Failed to create writable directory at %s", qPrintable(writeDir.absolutePath()));

    // Ensure that we have a writable location on all devices.
    const QString fileName = writeDir.absolutePath() + "/chat-database.sqlite3";
    // When using the SQLite driver, open() will create the SQLite database if it doesn't exist.
    database.setDatabaseName(fileName);
    if (!database.open()) {
        qFatal("Cannot open database: %s", qPrintable(database.lastError().text()));
        QFile::remove(fileName);
    }
}



int main(int argc, char *argv[])
{
//#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setApplicationName("FAITH IN ME");
    QGuiApplication::setOrganizationName("KOMTEK");
//#endif

    QGuiApplication app(argc, argv);
    qmlRegisterType<SqlContactModel>("komtek.fim", 1, 0, "SqlContactModel");
    qmlRegisterType<SqlConversationModel>("komtek.fim", 1, 0, "SqlConversationModel");
    qmlRegisterType<POST_REQ>("POST_REQ", 1, 0, "POST_REQ");
    connectToDatabase();

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

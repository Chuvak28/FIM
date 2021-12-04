#include "post_req.h"
#include <QQmlEngine>
#include <QQmlContext>
#include <QtQuick/QQuickImageProvider>
#include <QDebug>
#include <QFileInfo>

POST_REQ::POST_REQ(QObject *parent) : QObject(parent)
{

}

void POST_REQ::processImage(const QString& path) {
    QUrl imageUrl(path);
    qDebug() << path << "========PATH=========";
    QQmlEngine* engine = QQmlEngine::contextForObject(this)->engine();
    QQmlImageProviderBase* imageProviderBase = engine->imageProvider(imageUrl.host());
    QQuickImageProvider* imageProvider = static_cast<QQuickImageProvider*>(imageProviderBase);

    QSize imageSize;
    QString imageId = imageUrl.path().remove(0,1);
    qDebug() << imageId << "========ID=========";
    QImage image = imageProvider->requestImage(imageId, &imageSize, imageSize);
    QString strPath="/home/jasuryuldashev/camera.jpeg";
    if( !image.isNull()) {
        // обработка изображения
        qDebug() << "img.format() Foto" << image.format();
        qDebug() << "working" << endl;

        image.save(strPath,"JPEG");
    }
}

void POST_REQ::upload(const QString &name,
                      const QString &nameDept,
                      const QString &problem1,
                      const QString &problem2,
                      const QString &problem3,
                      const QString &problem4,
                      const QString &comment)
{
   QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    //name
    QHttpPart name1;
    //latitude.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("text/plain"));
    name1.setHeader(QNetworkRequest::ContentDispositionHeader,
                       QVariant("form-data; name=\"name\""));
    name1.setBody(name.toUtf8());

    //nameDept
    QHttpPart nameDept1;
    //longitude.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("text/plain"));
    nameDept1.setHeader(QNetworkRequest::ContentDispositionHeader,
                        QVariant("form-data; name=\"nameDept\""));
    nameDept1.setBody(nameDept.toUtf8());

    //problem1
    QHttpPart problem11;
    //longitude.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("text/plain"));
    problem11.setHeader(QNetworkRequest::ContentDispositionHeader,
                        QVariant("form-data; name=\"problem1\""));
    problem11.setBody(problem1.toUtf8());

    //problem2
    QHttpPart problem12;
    //longitude.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("text/plain"));
    problem12.setHeader(QNetworkRequest::ContentDispositionHeader,
                        QVariant("form-data; name=\"problem2\""));
    problem12.setBody(problem2.toUtf8());

    //problem3
    QHttpPart problem13;
    //longitude.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("text/plain"));
    problem13.setHeader(QNetworkRequest::ContentDispositionHeader,
                        QVariant("form-data; name=\"problem3\""));
    problem13.setBody(problem3.toUtf8());

    //problem4
    QHttpPart problem14;
    //longitude.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("text/plain"));
    problem14.setHeader(QNetworkRequest::ContentDispositionHeader,
                        QVariant("form-data; name=\"problem4\""));
    problem14.setBody(problem4.toUtf8());


    //complains
    QHttpPart comment1;
    //complains.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("text/plain"));
    comment1.setHeader(QNetworkRequest::ContentDispositionHeader,
                        QVariant("form-data; name=\"Comment\""));
    comment1.setBody(comment.toUtf8());


    multiPart->append(name1);
    multiPart->append(nameDept1);
    multiPart->append(problem11);
    multiPart->append(problem12);
    multiPart->append(problem13);
    multiPart->append(problem14);
    multiPart->append(comment1);



    //QUrl url("http://192.168.0.105:5000/add");
    QUrl url("http://localhost:5000/add");
    QNetworkRequest request(url);
    QNetworkAccessManager *networkManager= new QNetworkAccessManager;
    QNetworkReply *reply = networkManager->post(request,multiPart);
    multiPart->setParent(reply);


    connect(networkManager,SIGNAL(finished(QNetworkReply*)),this,SLOT(replyfinished(QNetworkReply*)));
    connect(reply, SIGNAL(uploadProgress(qint64, qint64)),
            this, SLOT  (uploadProgress(qint64, qint64)));
}

void POST_REQ::uploadProgress(qint64 bytesSent, qint64 bytesTotal)
{
    qDebug() << "---------Uploaded--------------" << bytesSent<< "of" <<bytesTotal;
}

void POST_REQ::replyfinished(QNetworkReply* reply1)
{
    qDebug() << QString(reply1->readAll());
    qDebug() << QString(reply1->errorString());
}

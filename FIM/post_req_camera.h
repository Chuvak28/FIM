#ifndef POST_REQ_CAMERA_H
#define POST_REQ_CAMERA_H

#include <QObject>
#include <QNetworkReply>
#include <QHttpMultiPart>
#include <QFile>
#include <QNetworkAccessManager>
#include <QQuickImageProvider>

class POST_REQ_CAMERA : public QObject
{
    Q_OBJECT
public:
    explicit POST_REQ_CAMERA(QObject *parent = nullptr);

    Q_INVOKABLE void upload(const QString &name, const QString &nameDept, const QString &problem1, const QString &problem2, const QString &problem3, const QString &problem4, const QString &comment);
    Q_INVOKABLE void processImage(const QString& path);


private slots:
   void replyfinished(QNetworkReply* reply);
   void uploadProgress(qint64 bytesSent, qint64 bytesTotal);

//signals:

};

#endif // POST_REQ_CAMERA_H

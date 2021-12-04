#ifndef SQLCONTACTMODEL_H
#define SQLCONTACTMODEL_H

#include <QSqlQueryModel>

class SqlContactModel : public QSqlQueryModel
{
public:
    explicit SqlContactModel(QObject *parent = nullptr);
};

#endif // SQLCONTACTMODEL_H

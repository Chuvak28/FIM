#ifndef SQLCONVERSATIONMODEL_H
#define SQLCONVERSATIONMODEL_H

#include <QSqlTableModel>

class SqlConversationModel : public QSqlTableModel
{
public:
    explicit SqlConversationModel(QObject *parent = nullptr);
};

#endif // SQLCONVERSATIONMODEL_H

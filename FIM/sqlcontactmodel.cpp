#include "sqlcontactmodel.h"
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>

static void createTable()
{
    if(QSqlDatabase::database().tables().contains(QStringLiteral("Contacts")))
    {
        return;
    }

    QSqlQuery query;
    if(!query.exec(
                "CREATE TABLE IF NOT EXISTS  'Contacts' ("
                " 'name' TEXT NOT NULL,"
                " PRIMARY KEY(name)"
                " )"))
    {
        qFatal("failed to query database: %s", qPrintable(query.lastError().text()));
    }

    query.exec("INSERT INTO Contacts VALUES('Albert Einstein')");
    query.exec("INSERT INTO Contacts VALUES('Ernest Hemingway')");
    query.exec("INSERT INTO Contacts VALUES('Hans Gude')");
}


SqlContactModel::SqlContactModel(QObject *parent) : QSqlQueryModel(parent)
{
    createTable();

    QSqlQuery query;
    if(!query.exec("Select * from Contacts"))
    {
        qFatal("Contacts  Select query failed: %s", qPrintable(query.lastError().text()));
    }

    setQuery(query);
    if(lastError().isValid())
    {
        qFatal("Cannot set query model on SqlContactModel: %s", qPrintable(lastError().text()));
    }
}


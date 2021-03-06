#ifndef SQLQUERYMODEL_H
#define SQLQUERYMODEL_H

#include <QSqlQueryModel>

class SqlQueryModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit SqlQueryModel(QObject *parent = nullptr);

    void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase());
    void setQuery(const QSqlQuery &query);
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const {	return m_roleNames;	}
    void refresh(QString query);

private:
    void generateRoleNames();
    QHash<int, QByteArray> m_roleNames;
};

#endif // SQLQUERYMODEL_H

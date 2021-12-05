#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQuick>
#include <QtQuickWidgets/QQuickWidget>
#include <QSplitter>
#include <QLabel>

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    createGUI();
    sqlModel = new SqlQueryModel(this);
    bool check = createConnection();
    if(check==true)
    {
        sqlModel->setQuery("select name,nameDept,"
                           "problem1,problem2,problem3,problem4,Comment from user_problems");
        ui->dataMapView->setModel(sqlModel);

    }
}

MainWindow::~MainWindow()
{
    delete ui;
}

bool MainWindow::createConnection()
{
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("hackathon2021");
    db.setUserName("jasur");
    db.setPassword("Jasur@295");
    if(!db.open())
    {
        return false;

    }
    return true;
}


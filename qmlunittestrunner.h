#ifndef QMLUNITTESTRUNNER_H
#define QMLUNITTESTRUNNER_H

#include <QtGui/QApplication>
#include <QObject>
#include <QFileInfo>
#include <QStringList>
#include "qmllogger.h"

class QmlUnitTestRunner : public QObject
{
    Q_OBJECT
public:
    explicit QmlUnitTestRunner(QApplication *app);
    int exec();

private:
    void setup();
    QApplication *app;
    QStringList tests;

private:
    void findTests(QString path);
    bool isDir(QFileInfo file);
    bool isTest(QFileInfo file);
    bool isTest(QString filePath);

signals:

public slots:

};

#endif // QMLUNITTESTRUNNER_H

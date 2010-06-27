#ifndef QMLLOGGER_H
#define QMLLOGGER_H

#include <QDialog>
#include <QDeclarativeView>
#include <QDeclarativeEngine>

class QmlLogger : public QObject
{
    Q_OBJECT

public:
    explicit QmlLogger(QString qmlUnitPath, QObject *parent);

    QDeclarativeEngine *engine();
    void setup();

private:
    QDialog *dialog;

    QString qmlUnitPath;
    QDeclarativeView *view;

};

#endif // QMLLOGGER_H

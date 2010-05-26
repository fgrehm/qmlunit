#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include <QDeclarativeView>

//! [Dialog header]
class Dialog : public QDialog
{
    Q_OBJECT

public:
    Dialog(QString appPath, QString input);

private:
    QDeclarativeView *view;
};
//! [Dialog header]

#endif

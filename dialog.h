#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include <QDeclarativeView>
#include <QStringList>
#include <QFileInfo>

//! [Dialog header]
class Dialog : public QDialog
{
    Q_OBJECT

public:
    Dialog(QString appPath, QStringList input);

private:
    QDeclarativeView *view;
    QStringList tests;

    void findTests(QString path);
    bool isDir(QFileInfo file);
    bool isTest(QFileInfo file);
    bool isTest(QString filePath);
};
//! [Dialog header]

#endif

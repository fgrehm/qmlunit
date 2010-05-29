#include <QtGui>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QDeclarativeComponent>
#include <QScrollArea>
#include <QList>
#include <QFileInfo>
#include <QStringList>

#include "dialog.h"

Dialog::Dialog(QString qmlUnitPath, QStringList input)
{
    setWindowTitle(tr("QmlUnit"));

    view = new QDeclarativeView(this);

    QStringListIterator i(input);
    while(i.hasNext())
        findTests(i.next());

    i = QStringListIterator(tests);
    qDebug() << "Tests files found:";
    while(i.hasNext()) {
        QString currentArg = i.next();
        qDebug() << "\t" << currentArg;
    }

    view->engine()->setOfflineStoragePath(QDir::currentPath() + "/storage");
    view->rootContext()->setContextProperty("testsInput", tests);
    view->rootContext()->setContextProperty("currentPath", QDir::currentPath());

    view->setSource(QUrl(qmlUnitPath + "/qmlunit.qml"));

    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);

    QHBoxLayout* layout = new QHBoxLayout();
    layout->setSpacing(0);
    layout->setMargin(0);

    layout->addWidget(view);
    setLayout(layout);
}

void Dialog::findTests(QString path) {
    if (isTest(path)) {
        tests << path;
        return;
    }

    QStringList filters; filters << "*";
    QDir dir = QDir(QDir(path).absolutePath());

    QListIterator<QFileInfo> files(dir.entryInfoList(filters, QDir::AllEntries | QDir::NoDotAndDotDot));
    while(files.hasNext()) {
        QFileInfo file = files.next();
        if (file.fileName() == "." || file.fileName() == "..") continue;

        if (isTest(file))
            tests << file.absoluteFilePath();
        else if (isDir(file))
            findTests(file.absoluteFilePath());
    }
}

bool Dialog::isTest(QFileInfo file){
    return isTest(file.fileName());
}

bool Dialog::isTest(QString filePath){
    return filePath.endsWith("Test.qml");
}

bool Dialog::isDir(QFileInfo file){
    return QDir(file.absoluteFilePath()).exists();
}

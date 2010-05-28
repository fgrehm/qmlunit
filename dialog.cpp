#include <QtGui>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QDeclarativeComponent>
#include <QScrollArea>

#include "dialog.h"

Dialog::Dialog(QString appPath, QString input)
{
    setWindowTitle(tr("QmlUnit"));

    view = new QDeclarativeView(this);

    view->engine()->setOfflineStoragePath(QDir::currentPath() + "/storage");

    view->rootContext()->setContextProperty("testSuiteInput", input);

    view->setSource(QUrl(appPath + "/qmlunit.qml"));

    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);

    QHBoxLayout* layout = new QHBoxLayout();
    layout->setSpacing(0);
    layout->setMargin(0);

    layout->addWidget(view);
    setLayout(layout);
}

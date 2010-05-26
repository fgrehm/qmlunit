#include <QtGui>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QDeclarativeComponent>
#include <QScrollArea>

#include "dialog.h"

Dialog::Dialog()
{
    setWindowTitle(tr("QmlUnit"));

    view = new QDeclarativeView(this);

    view->engine()->setOfflineStoragePath(QDir::currentPath() + "/storage");

    view->setSource(QUrl("qmlunit.qml"));

    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);

    QHBoxLayout* layout = new QHBoxLayout();
    layout->setSpacing(0);
    layout->setMargin(0);

    layout->addWidget(view);
    setLayout(layout);
}

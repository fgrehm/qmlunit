#include "qmllogger.h"
#include <QtGui>

QmlLogger::QmlLogger(QString qmlUnitPath, QObject *parent) :
    QObject(parent) {

    dialog = new QDialog();

    this->qmlUnitPath = qmlUnitPath;
    dialog->setWindowTitle(tr("QmlUnit"));

    view = new QDeclarativeView(dialog);

    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);

    QHBoxLayout* layout = new QHBoxLayout();
    layout->setSpacing(0);
    layout->setMargin(0);

    layout->addWidget(view);
    dialog->setLayout(layout);
}

void QmlLogger::setup(){
    view->setSource(QUrl(qmlUnitPath + "/QmlTestRunner.qml"));
    dialog->setMinimumSize(800, 600);
    dialog->show();
}

QDeclarativeEngine* QmlLogger::engine(){
    return view->engine();
}

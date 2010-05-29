#include <QtGui/QApplication>
#include "dialog.h"
#include <QDebug>
#include <QDir>
#include <QList>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QStringList args = a.arguments();
    // Skips executable
    args.removeAt(0);

    if (args.count() == 0) {
        qDebug() << "No arguments passed, failing back to qmlunit Test Suite (" << (a.applicationDirPath() + "/test") << ")\n";
        args = QStringList(a.applicationDirPath() + "/");
    }

    Dialog w(a.applicationDirPath(), args);

#if defined(Q_WS_S60)
    w.showMaximized();
#else
    w.setMinimumSize(800, 600);
    w.show();
#endif

    return a.exec();
}

#include <QtGui/QApplication>
#include "dialog.h"
#include <QDebug>
#include <QDir>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QListIterator<QString> i(a.arguments());
    // Skips executable
    i.next();

    QString input;

    if (i.hasNext()) {
        input = QDir().absoluteFilePath(i.next());

        if (!QDir().exists(input)) {
            qDebug() << "File not found:" << input << "\n";
            return 1;
        }

        qDebug() << "Testing:" << input << "\n";
    } else {
        input = a.applicationDirPath() + "/" + QString("test/AllTests.qml");

        qDebug() << "No input file specified, failing back to qmlunit Test Suite (" << input << ")\n";
    }

    Dialog w(a.applicationDirPath(), input);

#if defined(Q_WS_S60)
    w.showMaximized();
#else
    w.setMinimumSize(800, 600);
    w.show();
#endif

    return a.exec();
}

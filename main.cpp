#include <QtGui/QApplication>
#include "dialog.h"
#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QListIterator<QString> i(a.arguments());

    // Skips executable
    i.next();
    while (i.hasNext())
        qDebug() << i.next();

    Dialog w;
#if defined(Q_WS_S60)
    w.showMaximized();
#else
    w.setMinimumSize(800, 600);
    w.show();
#endif
    return a.exec();
}

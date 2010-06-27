#include <QtGui/QApplication>
#include <qmlunittestrunner.h>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QmlUnitTestRunner runner(&a);

    return runner.exec();
}

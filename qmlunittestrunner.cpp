#include "qmlunittestrunner.h"
#include "qmllogger.h"
#include <QDeclarativeContext>
#include <QDebug>
#include <QDir>

QmlUnitTestRunner::QmlUnitTestRunner(QApplication *app) :
    QObject(app)
{
    this->app = app;

    QStringList args = app->arguments();
    // Skips executable
    args.removeAt(0);
    
    // Parse possible xmlUnitOutput arg
    bool xmlOutput = false;
    
    if ((args.count() > 0) && args.contains("-xml")) {
        xmlOutput = true;
        args.removeAt(args.indexOf("-xml"));
    }
    
    if (args.count() == 0) {
        // Surpress all non-xml output if xml output was requested
        if (!xmlOutput) 
          qDebug() << "No arguments passed, failing back to qmlunit Test Suite (" << (app->applicationDirPath() + "/test") << ")\n";
        args = QStringList(app->applicationDirPath() + "/test");
    }

    QStringListIterator i(args);
    while(i.hasNext())
        findTests(i.next());

    i = QStringListIterator(tests);
    
    // Surpress all non-xml output if xml output was requested
    if (!xmlOutput) {
      qDebug() << "Tests files found:";
      while(i.hasNext()) {
          QString currentArg = i.next();
          qDebug() << "\t" << currentArg;
      }
    }
}

void QmlUnitTestRunner::setup(){
    QmlLogger *logger = new QmlLogger(app->applicationDirPath(), this);

    QDeclarativeEngine *engine = logger->engine();

    engine->setOfflineStoragePath(QDir::currentPath() + "/storage");
    engine->addImportPath(QDir::currentPath() + "/QmlUnit");
    engine->rootContext()->setContextProperty("testsInput", tests);
    engine->rootContext()->setContextProperty("currentPath", QDir::currentPath());

    logger->setup();
}

int QmlUnitTestRunner::exec() {
    setup();
    return app->exec();
}

void QmlUnitTestRunner::findTests(QString path) {
    if (isTest(path)) {
        tests << QDir(path).absolutePath();
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

bool QmlUnitTestRunner::isTest(QFileInfo file){
    return isTest(file.fileName());
}

bool QmlUnitTestRunner::isTest(QString filePath){
    return filePath.endsWith("Test.qml");
}

bool QmlUnitTestRunner::isDir(QFileInfo file){
    return QDir(file.absoluteFilePath()).exists();
}

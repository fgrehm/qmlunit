#-------------------------------------------------
#
# Project created by QtCreator 2010-05-25T11:44:36
#
#-------------------------------------------------

QT          += core gui declarative sql

TARGET = qmlunit
TEMPLATE = app

macx:CONFIG-=app_bundle


SOURCES += main.cpp\
    qmlunittestrunner.cpp \
    qmllogger.cpp

HEADERS  += \
    qmlunittestrunner.h \
    qmllogger.h

FORMS    +=

OTHER_FILES += \
    qmlunit.qml \
    scripts/qmlunit.js \
    lib/QmlTestCase.qml \
    test/TestTest.qml \
    test/SameTest.qml \
    scripts/support.js \
    test/SetupAndTearDownTest.qml \
    test/TeardownAndStopTest.qml \
    test/AsyncTestTest.qml \
    test/JsDumpTest.qml \
    test/ScopeTest.qml \
    QmlTestRunner.qml \
    test/InteractingWithQmlElementTest.qml \
    scripts/interaction.js \
    components/Banner.qml \
    components/Separator.qml \
    components/Status.qml \
    components/Results.qml \
    components/ProgressBar.qml \
    test/AsyncSetupTest.qml \
    test/AsyncTeardownTest.qml \
    test/QUnitCompatibilityTest.qml \
    lib/QUnitTestSuite.qml \
    scripts/QUnitTestSuite.js \
    components/QmlLogger.qml \
    TestRunner.qml \
    QmlUnit/qmldir

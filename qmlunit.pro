#-------------------------------------------------
#
# Project created by QtCreator 2010-05-25T11:44:36
#
#-------------------------------------------------

QT          += core gui declarative sql

TARGET = qmlunit
TEMPLATE = app


SOURCES += main.cpp\
        dialog.cpp

HEADERS  += dialog.h

FORMS    +=

OTHER_FILES += \
    qmlunit.qml \
    scripts/qmlunit.js \
    QmlTestCase.qml \
    test/TestTest.qml \
    test/SameTest.qml \
    test/AllTests.qml \
    QmlTestSuite.qml \
    scripts/support.js \
    test/SetupAndTearDownTest.qml \
    test/TeardownAndStopTest.qml \
    test/AsyncTestTest.qml \
    test/JsDumpTest.qml \
    test/ScopeTest.qml \
    QmlTestRunner.qml \
    test/InteractingWithQmlElementTest.qml \
    scripts/interaction.js

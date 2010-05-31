import Qt 4.7
import "scripts/support.js" as Support
import "scripts/qmlunit.js" as QmlUnit

Item {
    id: runner

    function setTimeout(callback, timeout) {
        var obj = Qt.createQmlObject('import Qt 4.7; Timer {running: false; repeat: false; interval: ' + timeout + '}', runner, "setTimeout");
        obj.triggered.connect(callback);
        obj.running = true;

        return obj;
    }

    function clearTimeout(timer) {
        timer.running = false;
        timer.destroy(1);

        return timer;
    }

    function initializeTests() {
        testsInput.each(function(t){
            var folder = t.substring(0, t.lastIndexOf('/'));
            var testCase = t.substring(t.lastIndexOf('/') + 1, t.lastIndexOf('.qml'));
            var relativeFilePath = t.substring(currentPath.length);

            Qt.createQmlObject('import Qt 4.7; import "' + folder + '"; ' + testCase + ' { name: "' + relativeFilePath + '" }', runner, testCase);
        });
    }

    Component.onCompleted: {
        if (logger.registered)
            QmlUnit.Runner.onTestCaseRegistered = logger.registered;

        if(logger.testCaseStart)
            QmlUnit.QUnit.moduleStart = logger.testCaseStart;

        if(logger.testFinished)
            QmlUnit.QUnit.testDone = logger.testFinished;

        initializeTests();

        QmlUnit.window.setTimeout = runner.setTimeout;
        QmlUnit.window.clearTimeout = runner.clearTimeout;

        QmlUnit.onCompleted();

        if (logger.state)
            logger.state = 'running';

        QmlUnit.Runner.testCases.each(function(tc){
            QmlUnit.QUnit.module(tc.name, tc.testEnvironment);

            tc.tests.each(function(test){
                if (test.length == 4)
                    QmlUnit.QUnit[test[0]](test[1], test[2], test[3]);
                else
                    QmlUnit.QUnit[test[0]](test[1], test[2]);
            });
        });
    }
}

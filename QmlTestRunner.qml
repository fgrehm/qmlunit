import Qt 4.7
import "components"
import "scripts/support.js" as Support
import "scripts/qmlunit.js" as QmlUnit

Rectangle {
    id: runner

    property int testsRan : 0
    property int numAssertions : 0;
    property int totalFailures : 0;

    Column {

        anchors.fill: parent

        Banner { }

        Separator { }

        FilePathBanner { id: filePathBanner }

        Results {
            id: results

            anchors.top: filePathBanner.bottom
            anchors.bottom: separator.top
        }

        Separator {
            id: separator
            anchors.bottom: status.top
            height: 2
            color: "white"
        }

        Status { id: status }
    }

    function setTimeout(callback, timeout) {
        var obj = createQmlObject('import Qt 4.7; Timer {running: false; repeat: false; interval: ' + timeout + '}', runner, "setTimeout");
        obj.triggered.connect(callback);
        obj.running = true;

        return obj;
    }

    function clearTimeout(timer) {
        timer.running = false;
        timer.destroy(1);

        return timer;
    }

    function parseInput(input) {
        var folder = input.substring(0, input.lastIndexOf('/'));
        var testCase = input.substring(input.lastIndexOf('/') + 1, input.lastIndexOf('.qml'));

        return {folder: folder, testCase: testCase};
    }

    function newTestCase(name) {
        results.appendTestCase(name);
    }

    function newTest(testName, failures, totalAssertions, assertions) {
        QmlUnit.QUnit.stop();

        if (failures > 0) status.state = 'error';

        totalFailures += failures;
        numAssertions += totalAssertions;
        status.text = (++testsRan) + ' tests, ' + numAssertions + ' assertions, ' + totalFailures + ' failures and still running...';

        results.appendTest(testName + " <b>(failed: <font color='red'>" + failures + "</font>, passed: <font color='green'>" + (totalAssertions - failures) + "</font>, total: " + totalAssertions + ")</b>");

        for ( var i = 0; i < assertions.length; i++ ) {
            var assertion = assertions[i];

            var msg = assertion.result ? "<font color='green'>pass" : "<font color='red'>fail";
            msg += ': ' + (assertion.message || "(no message)") + '</font>';

            results.appendResult(msg);
        }

        QmlUnit.QUnit.start();
    }

    function testsCompleted() {
        status.text = '<b>Tests completed in '  + (arguments[2] / 1000).toFixed(3)  + ' seconds</b>: ' + status.text.replace('and still running...', '');
    }

    Component.onCompleted: {
        QmlUnit.window.setTimeout = runner.setTimeout;
        QmlUnit.window.clearTimeout = runner.clearTimeout;

        QmlUnit.QUnit.moduleStart = newTestCase;
        QmlUnit.QUnit.testDone = newTest;
        QmlUnit.QUnit.done = testsCompleted;

        QmlUnit.onCompleted();

        var input = parseInput(testSuiteInput);
        createQmlObject('import Qt 4.7; import "' + input.folder + '"; ' + input.testCase + ' { }', runner, input.testCase).runTests();
    }
}

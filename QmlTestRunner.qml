import Qt 4.7
import "test"
import "scripts/support.js" as Support
import "scripts/qmlunit.js" as QmlUnit

Rectangle {
    id: runner

    Text {
        id: resultsHeader
        text: "RESULTS"
        font.pixelSize: 23
        font.bold: true
        anchors.horizontalCenter: runner.horizontalCenter
    }

    Rectangle {
        border.color: 'black'
        border.width: 2
        width: parent.width

        anchors.top: resultsHeader.bottom
        anchors.topMargin: 10

        anchors.bottom: banner.top
        anchors.bottomMargin: 10

        Flickable {
            anchors.fill: parent

            clip: true

            width: parent.width

            contentHeight: results.height
            contentWidth: results.width

            flickDirection: Flickable.VerticalFlick

            Text {
                id: results

                text: ""

                function appendTestCase(line) {
                    text += '<br />&nbsp;&nbsp;&nbsp;TestCase: <b>' + line + "</b><br />";
                }

                function appendTest(line) {
                    text += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Test: " + line + "<br />";
                }

                function appendResult(line) {
                    text += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + line + "<br />";
                }

                textFormat: Text.RichText
            }
        }
    }

    Text {
        id: banner
        anchors.bottom: runner.bottom
        textFormat: Text.RichText

        anchors.horizontalCenter: runner.horizontalCenter
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

    Component.onCompleted: {
        var testsRan = 0;
        var numAssertions = 0;
        var totalFailures = 0;

        QmlUnit.window.setTimeout = runner.setTimeout;
        QmlUnit.window.clearTimeout = runner.clearTimeout;

        QmlUnit.QUnit.moduleStart = function(name) {
            results.appendTestCase(name);
        };

        QmlUnit.QUnit.testDone = function(testName, failures, totalAssertions, assertions) {
            QmlUnit.QUnit.stop();

            totalFailures += failures;
            numAssertions += totalAssertions;
            banner.text = (++testsRan) + ' tests, ' + numAssertions + ' assertions, <font color="red">' + totalFailures + '</font> failures and still running...';

            results.appendTest(testName + " <b>(failed: <font color='red'>" + failures + "</font>, passed: <font color='green'>" + (totalAssertions - failures) + "</font>, total: " + totalAssertions + ")</b>");

            for ( var i = 0; i < assertions.length; i++ ) {
                var assertion = assertions[i];

                var msg = assertion.result ? "<font color='green'>pass" : "<font color='red'>fail";
                msg += ': ' + (assertion.message || "(no message)") + '</font>';

                results.appendResult(msg);
            }

            QmlUnit.QUnit.start();
        };

        QmlUnit.QUnit.done = function() {
            banner.text = '<b>Tests completed in '  + (arguments[2] / 1000).toFixed(3)  + ' seconds</b>: ' + banner.text.replace('and still running...', '');
        };

        QmlUnit.onCompleted();

        var input = 'test/AllTests.qml';
        input = parseInput(input);
        createQmlObject('import Qt 4.7; import "' + input.folder + '"; ' + input.testCase + ' { }', runner, "Loading TestSuite").runTests();
    }
}

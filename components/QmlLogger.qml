import Qt 4.7
import "../scripts/qmlunit.js" as QmlUnit

Column {
    id: logger

    property alias totalTests : status.totalTests
    property alias testsRan : status.testsRan
    property alias totalAssertions : status.totalAssertions
    property alias totalFailures : status.totalFailures
    property alias state : status.state

    anchors.fill: parent

    Banner { id: banner }

    Separator { id: separator }

    Results {
        id: results
        height: parent.height - banner.height - separator.height - status.height
    }

    Status {
        id: status
        state: 'loading'
    }

    function testCaseStart(name) {
        var tc = {
            name: name,
            failures: 0,
            tests: [ ]
        };
        results.appendTestCase(tc);
    }

    function testFinished(testName, failures, totalAssertions, assertions) {
        QmlUnit.QUnit.stop();

        testsRan += 1;
        totalFailures += (failures > 0) ? 1 : 0;
        logger.totalAssertions += totalAssertions;

        var test = {
            name: testName,
            failures: failures,
            assertions: assertions
        };

        results.appendTest(test);

        QmlUnit.QUnit.start();
    }

    function registered(tc) {
        totalTests += tc.tests.length;
    }
}

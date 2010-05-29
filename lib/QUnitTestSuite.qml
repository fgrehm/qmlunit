import Qt 4.7
import "../scripts/qmlunit.js" as QmlUnit
import '../scripts/QUnitTestSuite.js' as JS

QmlTestCase {
    name: 'QUnitTestSuite'

    function test(name, expected, callback) {
        if ( arguments.length === 2 ) {
            callback = expected;
            expected = 0;
        }

        JS.appendTest('test', name, expected, callback);
    }

    function asyncTest(name, expected, callback) {
        if ( arguments.length === 2 ) {
            callback = expected;
            expected = 0;
        }

        JS.appendTest('asyncTest', name, expected, callback);
    }

    function module(name, testEnvironment) {
        JS.newTestCase(name, testEnvironment);
    }

    function body() { /* to be defined on real tests */ }

    function registerTestCase() {
        JS.suiteName = name;
        JS.register = QmlUnit.Runner.registerTestCase;
        body();
        JS.registerTestCases();
    }
}

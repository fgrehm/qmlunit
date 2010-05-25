import Qt 4.7
import "scripts/qmlunit.js" as QmlUnit

Item {
	property variant main : parent

	function setTimeout(callback, timeout) {
		var obj = createQmlObject('import Qt 4.7; Timer {running: false; repeat: false; interval: ' + timeout + '}', main, "setTimeout");
		obj.triggered.connect(callback);
		obj.running = true;
		obj.destroy(timeout + 50);
	}

	function module(name, testEnvironment) {
		QmlUnit.QUnit.module(name, testEnvironment);
	}

	function test(testName, expected, callback) {
		if (arguments.length === 2)
			QmlUnit.QUnit.test(testName, expected);
		else
			QmlUnit.QUnit.test(testName, expected, callback);
	}

	function asyncTest(testName, expected, callback) {
		if (arguments.length === 2)
			QmlUnit.QUnit.asyncTest(testName, expected);
		else
			QmlUnit.QUnit.asyncTest(testName, expected, callback);
	}

	function ok(a, msg) {
		QmlUnit.QUnit.ok(a, msg);
	}

	function equals(actual, expected, message) {
		QmlUnit.QUnit.equals(actual, expected, message);
	}

	function same(a, b, message) {
		QmlUnit.QUnit.same(a, b, message);
	}

	function expect(asserts) {
		QmlUnit.QUnit.expect(asserts);
	}

	function stop() {
		QmlUnit.QUnit.stop();
	}

	function start() {
		QmlUnit.QUnit.start();
	}

	function runTests() {
		console.log('No tests found');
	}
}

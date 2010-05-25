import Qt 4.7
import "QmlTestSuite.qml"
import "test"
import "scripts/qmlunit.js" as QmlUnit

Rectangle {
	width: 1024
	height: 768
	id: main

	Flickable {
		width: parent.width
		height: parent.height

		contentHeight: col.height
		contentWidth: col.width

		flickDirection: Flickable.VerticalFlick

		Column {
			id: col
			spacing: 30

			Text {
				id: banner

				textFormat: Text.RichText
			}

			Text {
				id: results
				text: "Results:<br />"

				function appendTest(line) {
					text += "<br /><br />" + line + "<br />";
				}

				function appendResult(line) {
					text += line + "<br />";
				}

				textFormat: Text.RichText
			}
		}
	}

	function setTimeout(callback, timeout) {
		var obj = createQmlObject('import Qt 4.7; Timer {running: false; repeat: false; interval: ' + timeout + '}', main, "setTimeout");
		obj.triggered.connect(callback);
		obj.running = true;
		obj.destroy(timeout + 50);
	}

	Component.onCompleted: {
		var testsRan = 0;
		var numAssertions = 0;
		var totalFailures = 0;

		QmlUnit.window.setTimeout = setTimeout;

		QmlUnit.QUnit.testDone = function(testName, failures, totalAssertions, assertions) {
			QmlUnit.QUnit.stop();

			totalFailures += failures;
			numAssertions += totalAssertions;
			banner.text = (++testsRan) + ' tests, ' + numAssertions + ' assertions, ' + totalFailures + ' failures';

			results.appendTest(testName + " <b>(failed: " + failures + ", passed: " + (totalAssertions - failures) + ", total: " + totalAssertions + ")</b>");

			for ( var i = 0; i < assertions.length; i++ ) {
				var assertion = assertions[i];

				var msg = assertion.result ? "pass" : "fail";
				msg += ': ' + (assertion.message || "(no message)");

				results.appendResult(msg);
			}

			QmlUnit.QUnit.start();
		};

//		QmlUnit.QUnit.start();
		suite.runTests();
	}


	QmlTestSuite {
		id: suite

		TestTest{}
		SameTest{}
	}
}

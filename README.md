QmlUnit
=========

QmlUnit is an easy-to-use Unit Testing framework with asynchronous testing
support for [Qt Declarative UI framework](http://doc.qt.nokia.com/4.7-snapshot/declarativeui.html)
that can be used for testing javascript libraries and QML applications.

It comes with a GUI runner and depends on a modified version of [QUnit](
http://github.com/jquery/qunit) for tests execution.


Screenshots
-----------

http://github.com/fgrehm/qmlunit/tree/master/screenshots


Writing tests
-------------

Please refer to [QUnit API docs](http://docs.jquery.com/QUnit#API_documentation)
to find out how to write tests in QmlUnit as well.

Altough 100% compatible with QUnit, a QmlUnit test case has a few differences
from plain QUnit tests:

1.  The tests go into a class `*Test.qml` file.

2.  `import QmlUnit 0.1` is required

3.  The test is an instance of `QmlTestCase` or `QUnitTestSuite` element (most
of the time).

4.  On `QmlTestCase` tests are element methods named test\_* or asyncTest\_* (for
`QUnitTestSuite` check out "Compatibility with QUnit" below).

    When writing async tests with QmlTestCase you can write the number of
    expectations in the method name itself like `asyncTest_2_assync_testing_with_expect_on_definition`.

You can check out [QmlUnit own tests](http://github.com/fgrehm/qmlunit/tree/master/test/)
to have an idea of how it works.

### Basic structure

A really simple test might look like this (setup and teardown are commented out to
indicate that they are completely optional):

    import Qt 4.7
    import QmlUnit 0.1

    QmlTestCase {
        //function setup() {
        //}

        //function teardown() {
        //}

        function test_fail() {
            ok(false);
        }
    }

### Assertions and asynchronous testing

QmlUnit assertions and methods for dealing with asynchronous testing are the same
as QUnit's.

#### Assertions

*   _ok( state [, message] )_

	  A boolean assertion, equivalent to JUnit's assertTrue. Passes if the first
	  argument is truthy.

*   _equals( actual, expected [, message] )_

	  A comparison assertion, equivalent to JUnit's assertEquals.
	
*   _same( actual, expected [, message] )_
	
	  A deep recursive comparison assertion, working on primitive types, arrays and
	  objects.

#### Asynchronous testing

*   _start()_
	
	  Start running tests again after the testrunner was stopped. See _stop()_.
	
*   _stop( [timeout] )_

    Stop the testrunner to wait to async tests to run. Call _start()_ to
    continue. You can specify a timeout to fail the test after the given time
    in milliseconds.

### Interacting with QML elements

Although not fully tested, QmlUnit allows you to interact with QML elements pretty
much like you would do in an QML app:

    import Qt 4.7
    import QmlUnit 0.1

    QmlTestCase {
        TextInput {
            id: input
            validator: IntValidator { }
        }

        function setup() {
            // Clean up input for testing
            input.text = '';
        }

        function test_text_input_with_invalid_text() {
            input.text = 'text';
            ok(!input.acceptableInput, 'invalid text');
        }

        function test_text_input_with_valid_text() {
            input.text = '5';
            ok(input.acceptableInput, 'valid text');
        }
    }

When testing signals / slots make sure you disconnect signals from elements when
you are done testing or use our _connect()_ method which will disconnect them all
after a test is run.

#### Helpers

Two simple helpers are provided to make interaction with QML elements easier:

*   _connect( signal, function )_

    Same as _[Function.connect()](http://doc.trolltech.com/4.3/qtscript.html#using-signals-and-slots)_
    but it keeps all connected functions in an array for disconnecting after a
    test is run. Check out [interaction.js](http://github.com/fgrehm/qmlunit/blob/master/scripts/interaction.js#L13)
    to find out how it works.

*   _click( mouseAreaElement )_

    Shortcut for sending a left button clicked signal to a MouseArea element 
    to avoid writing:

        mouseAreaElement.clicked({
            button: Qt.LeftButton,
            buttons: 0,
            modifiers: Qt.NoModifier
        });

If you think we could make use of some other helper just let me know :-)

Example usage:

    import Qt 4.7
    import QmlUnit 0.1

    QmlTestCase {
        MouseArea {
            id: mouseArea
        }

        function teardown() {
            input.text = '';
        }

        function asyncTest_1_clicking_on_mouse_area() {
            connect(mouseArea.clicked, function (){
                ok(true, 'MouseArea clicked');
                start();
            });

            click(mouseArea);
        }
    }

### Compatibility with QUnit

QmlUnit is 100% compatible with QUnit but remember that we don't have a [Document
Object Model](http://en.wikipedia.org/wiki/Document_Object_Model) available so
make sure your code does not depend on it.

QUnit tests should be an instance of QUnitTestSuite and should define a _body()_
method which contains any QUnit test code:

    import Qt 4.7
    import QmlUnit 0.1

    QUnitTestSuite {
        function body() {
            module("setup test", {
                setup: function() {
                    ok(true);
                }
            });

            test("module with setup", function() {
                expect(2); // http://docs.jquery.com/QUnit/expect#amount
                ok(true);
            });
        }
    }


Running tests
-------------

As you tipically will have all your tests grouped in some folder, you can run them
all with `./path/to/qmlunit <tests/folder>`. This will make QmlUnit look for
all files ending in `Test.qml` in the folder specified.

If you wanna focus on some specific test case you can supply the desired file to
QmlUnit executable like `./path/to/qmlunit tests/SomeTest.qml`.

When a test is completed, you can click on its name to check out assertions that
were run.

Dependencies and compilation
----------------------------

The framework was compiled and tested against 27/05/2010 [sources](http://qt.gitorious.org/qt)
on Ubuntu 10.04 and depends on:

*   [QUnit](http://docs.jquery.com/QUnit) (distributed with the framework).

    Please note that the version distributed has all HTML related code removed /
    commented out in order to make it work with QML and is based on [my fork](
    http://github.com/fgrehm/qunit) which allows for async setup and teardown
    methods.

*   Qt compiled with declarative ui enabled.


Bugs and Contributions
----------------------

If you find a bug, please [report it](http://github.com/fgrehm/qmlunit) or fork the
project, fix the problem and send me a pull request.

Thanks goes to [John Resig](http://github.com/jeresig) and other [QUnit contributors](
http://github.com/jquery/qunit/contributors) for their work on QUnit.


TODO
----

* Create a XUnit-like logger
* Ability to rerun tests
* Toggle display of errors only
* Mobile version
* Provide some way of interacting with C++ code
* Change mouse cursor for tests names to indicate that it can be clicked


License
-------

This work is licensed under the [MIT license](http://en.wikipedia.org/wiki/MIT_License).

QmlUnit
=========

QmlUnit is an easy-to-use Unit Testing framework with asynchronous testing
support for [Qt Declarative UI framework](http://doc.qt.nokia.com/4.7-snapshot/declarativeui.html)
that can be used for testing javascript libraries and QML applications.

It comes with a GUI runner and depends on a modified version of [QUnit](
http://github.com/jquery/qunit) for tests execution.


Screenshots
-----------

    TODO


Writing tests
-------------

Please refer to [QUnit API docs](http://docs.jquery.com/QUnit#API_documentation)
to find out how to write tests in QmlUnit as well.

Altough 100% compatible with QUnit, a QmlUnit test case has a few differences
from plain QUnit tests:

1.  The tests go into a class `*Test.qml` file.

2.  The element is an instance of `QmlTestCase` (most of the time).

3.  The tests are element methods that are named test\_* or asyncTest\_*.

    When testing async code you can write the number of expectations in the method
    name itself like `asyncTest_2_assync_testing_with_expect_on_definition`.

You can check out QmlUnit [own tests](http://github.com/fgrehm/qmlunit/tree/master/test/)
to have an idea of how it works.

### Basic structure

A really simple test might look like this (setup and teardown are commented out to
indicate that they are completely optional):

    import Qt 4.7
    import QmlUnit // TODO

    QmlTestCase {
        //function setup() {
        //}

        //function teardown() {
        //}

        function test_fail() {
            ok(false);
        }
    }

### Assertions

    TODO

### Interacting with QML elements

Although not fully tested QmlUnit allows you to interact with QML elements pretty
much like you would do in an QML app:

    TODO

Just make sure you disconnect signals from elements or use our connect method
when testing signals / slots otherwise it may cause some undesired effects.

#### Helpers

* connect
* click
* others?

### Compatibility with QUnit

QmlUnit is 100% compatible with QUnit but remember that we don't have a [Document
Object Model](http://en.wikipedia.org/wiki/Document_Object_Model) available so
make sure your code does not depend on it.

    EXEMPLO


Running tests
-------------

As you tipically will have all your tests grouped in some folder, you can run them
all with `./path/to/qmlunit &lt;tests/folder&gt;`. This will make QmlUnit look for
all files ending in `Test.qml` in the folder specified.

If you wanna focus on some specific test case you can supply the desired file to
QmlUnit executable like `./path/to/qmlunit tests/SomeTest.qml`.


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


License
-------

This work is licensed under the [MIT license](http://en.wikipedia.org/wiki/MIT_License).

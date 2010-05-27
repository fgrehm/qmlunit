import Qt 4.7
import "../lib"

QmlTestCase {
    name: 'Testing TestCase scope'

    property string foo

    function setup() {
        foo = "bar";
    }

    function teardown() {
        same(foo, "bar");
    }

    function test_scope_check() {
        expect(2);
        same(foo, "bar");
    }
}

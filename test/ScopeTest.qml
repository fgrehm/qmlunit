import Qt 4.7
import "../"

QmlTestCase {
    name: 'Testing TestCase scope'

    function setup() {
        this.foo = "bar";
    }

    function teardown() {
        same(this.foo, "bar");
    }

    function test_scope_check() {
        expect(2);
        same(this.foo, "bar");
    }
}

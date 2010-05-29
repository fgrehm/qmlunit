import Qt 4.7
import "../lib"

QmlTestCase {
    function setup() {
        ok(true);
    }

    function teardown() {
        ok(true);
    }

    function test_test_case_with_setup_and_teardown() {
        expect(3);
        ok(true);
    }
}

import Qt 4.7
import QmlUnit 0.1

QmlTestCase {
    property string state;

    function teardown() {
        equals(state, "done", "Test teardown.");
    }

    function test_teardown_must_be_called_after_test_ended() {
        expect(1);
        stop();
        setTimeout(function() {
            state = "done";
            start();
        }, 13);
    }
}

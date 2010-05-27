import Qt 4.7
import "../lib"

QmlTestCase {
    name: 'Async testing'

    function asyncTest_assync_testing() {
        expect(2);
        ok(true);

        setTimeout(function() {
            ok(true);
            start();
        }, 20);
    }

    function asyncTest_2_assync_testing_with_expect_on_definition() {
        ok(true);

        setTimeout(function() {
            ok(true);
            start();
        }, 13);
    }
}

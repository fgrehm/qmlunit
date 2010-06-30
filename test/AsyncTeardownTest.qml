import Qt 4.7
import QmlUnitTest 0.1

QmlTestCase {
    function teardown() {
        stop();
        setTimeout(function(){
            ok(true);
            start();
        }, 500);
    }

    function asyncTest_2_async_teardown() {
        ok(true);
        start();
    }
}

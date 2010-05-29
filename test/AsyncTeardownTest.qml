import Qt 4.7
import "../lib"

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

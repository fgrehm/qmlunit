import Qt 4.7
import QmlUnit 0.1

QmlTestCase {
    function setup() {
        stop();
        setTimeout(function(){
            ok(true);
            start();
        }, 500);
    }

    function asyncTest_2_async_setup() {
        ok(true);
        start();
    }
}

import Qt 4.7
import "../"

QmlTestCase {
    MouseArea {
        id: fixture
    }

    name: 'Interacting with QML elements'

    function asyncTest_1_clicking_on_mouse_area() {
        connect(fixture.clicked, function (){
            ok(true, 'MouseArea clicked');
            start();
        });

        click(fixture);
    }

    function test_1_signals_are_disconnected_on_teardown() {
        click(fixture);

        ok(true);
    }
}

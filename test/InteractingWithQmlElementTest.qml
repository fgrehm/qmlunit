import Qt 4.7
import "../lib"

QmlTestCase {
    MouseArea {
        id: mouseArea
    }

    TextInput {
        id: input
        validator: IntValidator { }
    }

    id: test
    name: 'Interacting with QML elements'

    function teardown() {
        input.text = '';
    }

    function asyncTest_1_clicking_on_mouse_area() {
        connect(mouseArea.clicked, function (){
            ok(true, 'MouseArea clicked');
            start();
        });

        click(mouseArea);
    }

    function test_1_signals_are_disconnected_on_teardown() {
        click(mouseArea);

        ok(true);
    }

    function test_text_input_with_validator() {
        input.text = 'text';
        ok(!input.acceptableInput, 'invalid input');

        input.text = '5';
        ok(input.acceptableInput, 'valid input');
    }
}

import Qt 4.7
import QmlUnitTest 0.1
import "../scripts/qmlunit.js" as QmlUnitJS

QmlTestCase {
    function test_jsDump_output() {
        equals( QmlUnitJS.QUnit.jsDump.parse([1, 2]), "[ 1, 2 ]" );
        equals( QmlUnitJS.QUnit.jsDump.parse({top: 5, left: 0}), "{ \"top\": 5, \"left\": 0 }" );
    }
}

import Qt 4.7
import "../lib"
import "../scripts/qmlunit.js" as QmlUnit

QmlTestCase {
    name: 'jsDump testing'

    function test_jsDump_output() {
        equals( QmlUnit.QUnit.jsDump.parse([1, 2]), "[ 1, 2 ]" );
        equals( QmlUnit.QUnit.jsDump.parse({top: 5, left: 0}), "{ \"top\": 5, \"left\": 0 }" );
    }
}

import Qt 4.7

Item {
    function runTests() {
        for (var i = 0; i < children.length; i++)
            children[i].runTests();
    }
}

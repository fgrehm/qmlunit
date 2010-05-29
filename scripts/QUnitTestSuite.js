var register;
var suiteName;
var testCases = [];
var currentTestCase;

function newTestCase(name, testEnvironment) {
    if (currentTestCase) testCases.unshift(currentTestCase);

    currentTestCase = {
        name: suiteName + ': ' + name,
        testEnvironment: testEnvironment,
        tests: []
    };
}

function appendTest(testType, name, expected, test) {
    if (!currentTestCase) newTestCase('Default TestCase', {});

    if (expected)
        currentTestCase.tests.push([testType, name, expected, test]);
    else
        currentTestCase.tests.push([testType, name, test]);
}

function registerTestCases() {
    testCases.unshift(currentTestCase);
    testCases.each(function(tc){
        register(tc);
    });
}

var currentTestSuite;
var testSuites = [];                                            

function addTestSuite(name) {

  currentTestSuite = {
    name: name,
    errors: 0,
    testsTotal: 0,
    time: 0.0, 
    failures: 0,
    tests: []
  };
  testSuites.push(currentTestSuite)
}

function parseFailureMessage(assertions) {
  var message = ""
  for (var i=0; i<assertions.length; i++) {
    if (!assertions[i].result && assertions[i].message)
      message += assertions[i].message + "; "
  }
  
  return message
}

function addTestCase(testSuite, name, testsTotal, failures, assertions) {
  var testCase = {
    name: name,
    time: 0,
    testsTotal: testsTotal,
    failures: failures,
    failureMessage: parseFailureMessage(assertions)
  };

  testSuite.testsTotal += testsTotal
  testSuite.failures += failures
  
  testSuite.tests.push(testCase)
}

function printTestResultsInXUnitFormat(logger) {  
  
  logger.log("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>")
  logger.log("<testsuites>")
  
  testSuites.forEach(function(testSuite) {
    logger.log("  <testsuite name=\"" + testSuite.name + "\" tests=\"" +testSuite.testsTotal + 
                "\" failures=\"" + testSuite.failures + "\" errors=\"" + testSuite.errors + 
                "\" time=\"" + testSuite.time + "\">")
    
    testSuite.tests.forEach(function(test) {
      if (test.failures == 0) {    
        logger.log("    <testcase name=\"" + test.name + "\" time=\"" + test.time + "\"/>")
      } 
      else {
        logger.log("    <testcase name=\"" + test.name + "\" time=\"" + test.time + "\">")
        logger.log("      <failure type=\"qmlunit test failure\" message=\"" + test.failureMessage + "\"/>")
        logger.log("    </testcase>")
      }        
    });
    
    logger.log("  </testsuite>")
  });
  
  logger.log("</testsuites>")
}



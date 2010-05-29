import Qt 4.7
import "../lib"

QmlTestCase {
    // default
    function test_no_setup_and_teardown() {
        expect(1);
        ok(true);
    }

    function test_3_expect_3_in_test_definition() {
        ok(true);
        ok(true);
        ok(true);
    }

    function test_1_expect_1_on_test_definition() {
        ok(true);
    }


//  TODO: Check out if these tests are needed
//
//		module("simple testEnvironment setup", {
//			foo: "bar",
//			bugid: "#5311" // example of meta-data
//		});
//		test("scope check", function() {
//			same(this.foo, "bar");
//		});
//		test("modify testEnvironment",function() {
//			this.foo="hamster";
//		});
//		test("testEnvironment reset for next test",function() {
//			same(this.foo, "bar");
//		});

//		module("testEnvironment with object", {
//			options:{
//				recipe:"soup",
//				ingredients:["hamster","onions"]
//			}
//		});
//		test("scope check", function() {
//			same(this.options, {recipe:"soup",ingredients:["hamster","onions"]}) ;
//		});
//		test("modify testEnvironment",function() {
//			// since we do a shallow copy, the testEnvironment can be modified
//			this.options.ingredients.push("carrots");
//		});
//		test("testEnvironment reset for next test",function() {
//			same(this.options, {recipe:"soup",ingredients:["hamster","onions","carrots"]}, "Is this a bug or a feature? Could do a deep copy") ;
//		});

//		module("testEnvironment tests");

//		function makeurl() {
//			var testEnv = QmlUnit.QUnit.current_testEnvironment;
//			var url = testEnv.url || 'http://example.com/search';
//			var q   = testEnv.q   || 'a search test';
//			return url + '?q='+encodeURIComponent(q);
//		}

//		test("makeurl working",function() {
//			equals( QmlUnit.QUnit.current_testEnvironment, this, 'The current testEnvironment is global');
//			equals( makeurl(), 'http://example.com/search?q=a%20search%20test', 'makeurl returns a default url if nothing specified in the testEnvironment');
//		});

//		module("testEnvironment with makeurl settings",{
//			url:'http://google.com/',
//			q:'another_search_test'
//		});
//		test("makeurl working with settings from testEnvironment",function() {
//			equals( makeurl(), 'http://google.com/?q=another_search_test', 'rather than passing arguments, we use test metadata to form the url');
//		});
//		test("each test can extend the module testEnvironment", {q:'hamstersoup'}, function() {
//			equals( makeurl(), 'http://google.com/?q=hamstersoup', 'url from module, q from test');
//		});
}

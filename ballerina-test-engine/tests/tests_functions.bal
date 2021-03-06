import ballerina/test;
import dilhasha/static_test_analyzer as _;

@test:Config{}
function new1() {
    test:assertEquals("hello", "hello1");
}

@test:Config{}
function new2() {
    test:assertEquals("hello", "hello");
}

@test:Init{}
function testInit() returns error?{
    foreach string  keyVal in getTests().keys() {
        function? f = getTests()[keyVal];
        if(!(f is ())){
            () v = check test:registerTest(keyVal, f);
        }
    }
}

@test:Init{}
function testInit2() returns error?{
    //DDT
    string[] fruits = ["apple", "banana", "cherry"];
    foreach string v in fruits {
        () v1 = check test:registerTest(v + "Test", function() {
            test:assertEquals(v.length(), 6);
        });
    }
}


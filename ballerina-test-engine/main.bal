import ballerina/test;
import dilhasha/static_test_analyzer as _;
import ballerina_test_engine.dtest;

public function main() returns error? {
    dtest:Registrar registrar = check dtest:getRegistrar();
    foreach string  keyVal in getTests().keys() {
        function? f = getTests()[keyVal];
        if(!(f is ())){
            registrar.register(keyVal, f);
        }
    }

    //DDT
    string[] fruits = ["apple", "banana", "cherry"];
    foreach string v in fruits {
        registrar.register(v + "Test", function() {
            test:assertEquals(v.length(), 6);
        });
    }
    dtest:Executer executer = new ();
    map<future<error?>> testWorkers = check executer.execute();
    dtest:Reporter reporter = new (testWorkers);
    reporter.print();
}


function getTests() returns map<function> {
    function f1 = function() {
        test:assertTrue(false);
    };
    function f2 = function() {
        test:assertEquals("apple", "apple");
    };
    function f3 = function() {
        test:assertNotEquals(false, true);
    };
    return {"f1": f1,"f2":f2,"f3":f3};
}



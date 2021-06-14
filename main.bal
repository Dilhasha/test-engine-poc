import test_engine_poc.dtest;
import ballerina/test;

public function main() {
    function f1 = function() {
        test:assertTrue(false);
    };
    function f2 = function() {
        test:assertEquals("apple", "apple");
    };
    function f3 = function() {
        test:assertNotEquals(false, true);
    };
    dtest:register("test1", f1);
    dtest:register("test2", f2);
    dtest:register("test3", f3);

    //DDT
    string[] fruits = ["apple", "banana", "cherry"];
    foreach string v in fruits {
        dtest:register(v + "Test", function() {
            test:assertEquals(v.length(), 6);
        });
    }

    dtest:Executer executer = new ();
    map<future<error?>> testWorkers = executer.execute();
    dtest:Reporter reporter = new (testWorkers);
    reporter.print();
}

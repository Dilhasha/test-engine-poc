import test_engine_poc.dtest;
import ballerina/test;

public function main() {
    function f1 = function() {
        test:assertTrue(false);
    };
    function f2 = function() {
        test:assertEquals("apple", "apple");
    };
    dtest:register("test1", f1);
    dtest:register("test2", f2);
    dtest:Executer executer = new();
    map<future<error?>> testWorkers = executer.execute();
    dtest:Reporter reporter = new(testWorkers);
    reporter.report();
}
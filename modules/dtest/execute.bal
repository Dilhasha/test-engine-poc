import ballerina/io;
public class Executer {

    private function startTest(function () returns ()  f) returns future<error?> {
        return start f();
    }

    public function execute() returns map<future<error?>> {
        io:println("Executing tests\n\n");
        map<future<error?>> testWorkers = {};
        foreach string item in testFunctions.keys() {
            function testFunc = testFunctions.get(item).test;
            if (testFunc is function () returns ()) {
                future<error?> startTestResult = self.startTest(testFunc);
                testWorkers[item] = startTestResult;
            }
        }
        return testWorkers;
    }

}

public class Executer {

    public function startTest(TFunction f) returns future<error?> {
        return start f();
    }

    public function execute() returns map<future<error?>>{
        map<future<error?>> testWorkers = {};
        foreach string item in testFunctions.keys(){
            function testFunc = testFunctions.get(item);
            if (testFunc is function () returns ()) {
                future<error?> startTestResult = self.startTest(testFunc);
                testWorkers[item] = startTestResult;
            }
        }
        return testWorkers;
    }


}

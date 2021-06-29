import ballerina/io;

public class Reporter {

    map<future<error?>> testWorkers = {};

    public function init(map<future<error?>> testWorkers) {
        self.testWorkers = testWorkers;
    }

    public function printTestResult(string testName) returns boolean {
        boolean isPassed = false;
        future<error?> w = self.testWorkers.get(testName);
        error? result = trap wait w;
        if (result is error) {
            isPassed = false;
            io:println("[FAILED] " + testName);
            io:println(result.message() + "\n");
        } else {
            isPassed = true;
            io:println("[PASSED] " + testName + "\n");
        }
        return isPassed;
    }

    public function print() {
        map<future<boolean>> testReporters = {};
        int totalTestCount = 0;
        int passedTestCount = 0;
        int failedTestCount = 0;
        future<boolean> testReporter;
        foreach string testName in self.testWorkers.keys() {
            testReporter = start self.printTestResult(testName);
            testReporters[testName] = testReporter;
        }
        foreach string testName in testReporters.keys() {
            boolean|error result = wait testReporters.get(testName);
            if (result is boolean) {
                totalTestCount = totalTestCount + 1;
                if (result) {
                    passedTestCount = passedTestCount +1;
                } else{
                    failedTestCount = failedTestCount +1;
                }
            }
        }
        io:println("\nTotal Tests : " +  totalTestCount.toBalString() + ", Passed : " + passedTestCount.toBalString() + ", Failed : " + failedTestCount.toBalString() + "\n");
    }

}

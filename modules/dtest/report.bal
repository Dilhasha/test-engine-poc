import ballerina/io;

public class Reporter {

    map<future<error?>> testWorkers = {};
    map<boolean> testResults = {};

    public function init(map<future<error?>> testWorkers) {
        self.testWorkers = testWorkers;
    }

    public function report() {
        string[] keys = self.testWorkers.keys();
        foreach string workerkKey in keys {
            future<error?> w = self.testWorkers.get(workerkKey);
            error? result = trap wait w;
            if (result is error) {
                self.testResults[workerkKey] = false;
            } else {
                self.testResults[workerkKey] = true;
            }
        }
        keys = self.testResults.keys();
        io:println("Test Results\n");
        foreach string item in keys {
            io:println("Test : " + item);
            io:println("Passed : " + self.testResults[item].toString());
        }
    }
}

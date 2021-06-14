import ballerina/io;

type TFunction record {
    boolean enable = true;
    function[] before = [];
    function[] after = [];
    function[] dependsOn = [];
    string[] groups = [];
    function () returns () test;
};


map<TFunction> testFunctions = {};
int i = 1;

public function register(string name, function f, function[] afterTests = [], function[] beforeTests = [], function[] dependsOnTests = [], string[] groups = []) {
    string testName = name;
    if (isDuplicateKey(name)) {
        testName = name + i.toBalString();
        io:println("Warning: Provided test name " + name + " already exists. Renaming to " + testName + "\n");
        i = i + 1;
    }
    if (f is function () returns ()) {
        testFunctions[testName] = {test: f};
    }
}

function isDuplicateKey(string testName) returns boolean {
    foreach string key in testFunctions.keys() {
        if (testName == key) {
            return true;
        }
    }
    return false;
}


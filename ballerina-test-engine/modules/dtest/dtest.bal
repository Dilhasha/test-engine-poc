import ballerina/cache;
import ballerina/io;

public type TFunction record {
    boolean enable = true;
    function[] before = [];
    function[] after = [];
    function[] dependsOn = [];
    string[] groups = [];
    function () returns () test;
};

public map<TFunction[]> testSuite = {};

public cache:Cache cache = new();

public const string regstrar_key = "registrar";

public function getRegistrar() returns Registrar|error {
    Registrar registrar;
    if (cache.hasKey(regstrar_key)){
        registrar = <Registrar>check cache.get(regstrar_key);            
    } else {
        registrar = new Registrar();
        _ = check cache.put(regstrar_key, registrar);
    }
    return registrar;
}

public function registerTest(string name, function f, function[] afterTests = [], function[] beforeTests = [], function[] dependsOnTests = [], string[] groups = []) returns error? {
    Registrar registrar = check getRegistrar();
    registrar.register(name, f);
}

public class Registrar {
    map<TFunction> testFunctions = {};

    public function getTestFunctions() returns map<TFunction>{
        return self.testFunctions;
    }
    
    int i = 1;

    public function register(string name, function f, function[] afterTests = [], function[] beforeTests = [], function[] dependsOnTests = [], string[] groups = []) {
        string testName = name;
        if (self.isDuplicateKey(name)) {
            testName = name + self.i.toBalString();
            io:println("Warning: Provided test name " + name + " already exists. Renaming to " + testName + "\n");
            self.i = self.i + 1;
        }
        if (f is function () returns ()) {
            self.testFunctions[testName] = {test: f};
        }

        [string, int] tuple = ["john", 20];
    }

    function isDuplicateKey(string testName) returns boolean {
        foreach string key in self.testFunctions.keys() {
            if (testName == key) {
                return true;
            }
        }
        return false;
    }
}



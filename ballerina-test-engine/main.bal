import ballerina/test;

public function main() returns error? {

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



type TFunction function () returns ();
//type DDTFunction function (any) returns error?;

map<function> testFunctions = {};

public function register(string name, function f) {
    if (f is function() returns () ) {
        testFunctions[name] = f;
    } 
    //Register data driven functions
}





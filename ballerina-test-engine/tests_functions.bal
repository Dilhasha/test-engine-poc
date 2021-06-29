import ballerina/test;

@test:Config{}
function new1() {
    test:assertEquals("hello", "hello1");
}

@test:Config{}
function new2() {
    test:assertEquals("hello", "hello");
}

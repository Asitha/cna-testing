import ballerina/http;
import ballerina/crypto;
import ballerina/io;

configurable string greeting = "Hello ";

# A service representing a network-accessible API
# bound to port `9090`.
service /greeter on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting(string name) returns string|error {
        // Send a response back to the caller.
        if name is "" {
            return error("name should not be empty!");
        }
        return greeting + name;
    }

}

service /util on new http:Listener(9091) {

    resource function get md5sum(string value) returns string|error {
        byte[] hashedBytes = crypto:hashMd5(value.toBytes());
        return hashedBytes.toBalString();
    }


    resource function get header(http:Request req) returns string[]|error? {
        // Send a response back to the caller.
        string[] headers = [];
        req.getHeaderNames().forEach(function (string headerName) {
            string|http:HeaderNotFoundError headerValue = req.getHeader(headerName);
            if (headerValue is string) {
                io:println(headerName + ": " + headerValue);
                headers.push(headerName + ": " + headerValue);
            } else {
                io:println(headerName + ": not found ");
            }
        });
        return headers;

    }
}

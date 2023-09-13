import ballerina/http;
import ballerina/crypto;
import ballerina/io;
import ballerina/jwt;

configurable string greeting = "Hello ";
public listener http:Listener httpListener = check new(9090);
public listener http:Listener httpListener2 = check new(9091);
# A service representing a network-accessible API
# bound to port `9090`.
service /greeter on httpListener {

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

service /util on httpListener2 {

    resource function get md5sum(string value) returns string|error {
        byte[] hashedBytes = crypto:hashMd5(value.toBytes());
        return hashedBytes.toBalString();
    }


    resource function get headers(http:Request req) returns string[]|error? {
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

    resource function get headers/jwt/subject(@http:Header string x\-jwt\-assertion) returns string?|error {
        [jwt:Header, jwt:Payload] [_, payload] = check jwt:decode(x\-jwt\-assertion);
        return payload.sub;
    }
}

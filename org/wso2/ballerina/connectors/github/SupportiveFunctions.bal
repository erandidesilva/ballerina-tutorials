package org.wso2.ballerina.connectors.github;

import ballerina.utils;
import ballerina.lang.system;

function getBase64EncodedKey (string value1,string value2) (string encodedString) {
    string toEncode = value1 + ":" + value2;
    encodedString = <string>utils:base64encode(toEncode);
    return;
}




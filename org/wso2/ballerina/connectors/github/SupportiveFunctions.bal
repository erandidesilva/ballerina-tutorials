package org.wso2.ballerina.connectors.github;

import ballerina.util;

function getBase64EncodedKey (string value1,string value2) (string encodedString) {
    string toEncode = value1 + ":" + value2;
    encodedString = <string>util:base64encode(toEncode);
    return;
}




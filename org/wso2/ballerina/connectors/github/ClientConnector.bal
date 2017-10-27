package org.wso2.ballerina.connectors.github;

import ballerina.net.http;
import ballerina.doc;
import ballerina.lang.system;
@doc:Description {
    value:"GitHub Client Connector"
}
@doc:Param {
    value:"username: github username"
}
@doc:Param {
    value:"token: github personal token"
}
public connector ClientConnector (string username, string token) {
    http:ClientConnector gitEP = create http:ClientConnector("https://api.github.com", {});

    string authHeader = getBase64EncodedKey(username, token);
    @doc:Description {
        value:"Retrieve repositories for the authenticated user"
    }
    @doc:Return {
        value:"Response object"
    }
    
    action getReposOfUser () (http:Response) {
         http:Request request = {};
         string gitPath = "/user/repos";
         authHeader = "Basic " + authHeader;
         request.setHeader("Authorization", authHeader);
         http:Response response = gitEP.get(gitPath, request);
         return response;
    }
    @doc:Description {
        value:"List repositories for an organization"
    }
    @doc:Param {
        value:"organization: name of the orgnization on which repositories should be fetched"
    }
    @doc:Return {
        value:"Response object"
    }
    action getReposOfOrg (string orgnization) (http:Response) {
        http:Request request = {};
        string gitPath =string `/orgs/{{orgnization}}/repos`;
        request.setHeader("Authorization", "Basic "+ authHeader);
        http:Response response = gitEP.get(gitPath, request);
        return response;
    }
}
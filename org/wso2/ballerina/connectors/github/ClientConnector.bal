package org.wso2.ballerina.connectors.github;

import ballerina.net.http;

@Description {
    value:"GitHub Client Connector"
}
@Param {
    value:"username: github username"
}
@Param {
    value:"token: github personal token"
}
public connector ClientConnector (string username, string token) {
    endpoint<http:HttpClient> gitEP { create http:HttpClient("https://api.github.com", {});}

    string authHeader = getBase64EncodedKey(username, token);
    @Description {
        value:"Retrieve repositories for the authenticated user"
    }
    @Return {
        value:"Response object"
    }
    
    action getReposOfUser () (http:Response, http:HttpConnectorError) {
         http:Request request = {};
         string gitPath = "/user/repos";
         request.setHeader("Authorization", "Basic "+ authHeader);
         http:Response response = {};
         http:HttpConnectorError err;
         response, err = gitEP.get(gitPath, request);
         return response, err;
    }
    @Description {
        value:"List repositories for an organization"
    }
    @Param {
        value:"organization: name of the orgnization on which repositories should be fetched"
    }
    @Return {
        value:"Response object"
    }
    action getReposOfOrg (string orgnization) (http:Response, http:HttpConnectorError) {
        http:Request request = {};
        string gitPath = string `/orgs/{{orgnization}}/repos`;
        request.setHeader("Authorization", "Basic "+ authHeader);
        http:Response response = {};
        http:HttpConnectorError err;
        response, err = gitEP.get(gitPath, request);
        return response, err;
    }

    @Description {
        value:"List all issues under a given repository"
    }
    @Param {
        value:"organization: name of the orgnization on which issues should be fetched"
    }
    @Return {
        value:"Response object"
    }
    action getIssuesOfRepoByState (string orgnization, string repository, string state) (http:Response, http:HttpConnectorError) {
        http:Request request = {};
        string gitPath = string `/repos/{{orgnization}}/{{repository}}/issues?state={{state}}`;
        request.setHeader("Authorization", "Basic "+ authHeader);
        http:Response response = {};
        http:HttpConnectorError err;
        response, err = gitEP.get(gitPath, request);
        return response, err;
    }

}
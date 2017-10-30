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
    http:ClientConnector gitEP = create http:ClientConnector("https://api.github.com", {});

    string authHeader = getBase64EncodedKey(username, token);
    @Description {
        value:"Retrieve repositories for the authenticated user"
    }
    @Return {
        value:"Response object"
    }
    
    action getReposOfUser () (http:Response) {
         http:Request request = {};
         string gitPath = "/user/repos";
         request.setHeader("Authorization", "Basic "+ authHeader);
         http:Response response = gitEP.get(gitPath, request);
         return response;
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
    action getReposOfOrg (string orgnization) (http:Response) {
        http:Request request = {};
        string gitPath = string `/orgs/{{orgnization}}/repos`;
        request.setHeader("Authorization", "Basic "+ authHeader);
        http:Response response = gitEP.get(gitPath, request);
        return response;
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
    action getIssuesOfRepoByState (string orgnization, string repository, string state) (http:Response) {
        http:Request request = {};
        string gitPath = string `/repos/{{orgnization}}/{{repository}}/issues?state={{state}}`;
        request.setHeader("Authorization", "Basic "+ authHeader);
        http:Response response = gitEP.get(gitPath, request);
        return response;
    }

}
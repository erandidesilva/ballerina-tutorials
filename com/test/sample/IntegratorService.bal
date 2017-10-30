package com.test.sample;

import org.wso2.ballerina.connectors.github;
import ballerina.net.http;
import ballerina.util;

@http:configuration {
    basePath:"/integrate"
}
service<http> service1 {
    @http:resourceConfig {
        methods:["POST"],
        path:"/get/repo/{org}"
    }
    resource getReposForOrganization (http:Request req,http:Response res, string org) {
        github:ClientConnector gitHubConnector;
        string username = req.getHeader("Username");
        string tokenEnc = req.getHeader("Token");
        gitHubConnector = create github:ClientConnector(username, tokenEnc);
        http:Response gitHubResponse = {};
        gitHubResponse = gitHubConnector.getReposOfOrg(org);
        res.forward(gitHubResponse);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/get/issues/{org}/{repo}/{state}"
    }
    resource getIssuesPerRepoPerState (http:Request req,http:Response res, string org, string repo, string state) {
        github:ClientConnector gitHubConnector;
        string username = req.getHeader("Username");
        string tokenEnc = req.getHeader("Token");
        gitHubConnector = create github:ClientConnector(username, tokenEnc);
        http:Response gitHubResponse = {};
        gitHubResponse = gitHubConnector.getIssuesOfRepoByState(org, repo, state);
        res.forward(gitHubResponse);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/get/repo/authuser"
    }
    resource getReposOfAuthUser (http:Request req,http:Response res) {
        github:ClientConnector gitHubConnector;
        string username = req.getHeader("Username");
        string tokenEnc = req.getHeader("Token");
        gitHubConnector = create github:ClientConnector(username, tokenEnc);
        http:Response gitHubResponse = {};
        gitHubResponse = gitHubConnector.getReposOfUser();
        res.forward(gitHubResponse);
    }
}
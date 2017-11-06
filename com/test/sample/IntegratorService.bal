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
        endpoint<github:ClientConnector> gitHubConnector{
        }
        string username;
        string tokenEnc;
        username, _ = req.getHeader("Username");
        tokenEnc, _ = req.getHeader("Token");
        github:ClientConnector gitHubConn = create github:ClientConnector(username, tokenEnc);
        bind gitHubConn with gitHubConnector;
        http:Response gitHubResponse = {};
        gitHubResponse, _ = gitHubConnector.getReposOfOrg(org);
        res.forward(gitHubResponse);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/get/issues/{org}/{repo}/{state}"
    }
    resource getIssuesPerRepoPerState (http:Request req,http:Response res, string org, string repo, string state) {
        endpoint<github:ClientConnector> gitHubConnector{
        }
        string username;
        string tokenEnc;
        username, _ = req.getHeader("Username");
        tokenEnc, _ = req.getHeader("Token");
        github:ClientConnector gitHubConn = create github:ClientConnector(username, tokenEnc);
        bind gitHubConn with gitHubConnector;
        http:Response gitHubResponse = {};
        gitHubResponse, _ = gitHubConnector.getIssuesOfRepoByState(org, repo, state);
        res.forward(gitHubResponse);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/get/repo/authuser"
    }
    resource getReposOfAuthUser (http:Request req,http:Response res) {
        endpoint<github:ClientConnector> gitHubConnector{
        }
        string username;
        string tokenEnc;
        username, _ = req.getHeader("Username");
        tokenEnc, _ = req.getHeader("Token");
        github:ClientConnector gitHubConn = create github:ClientConnector(username, tokenEnc);
        bind gitHubConn with gitHubConnector;
        http:Response gitHubResponse = {};
        gitHubResponse, _ = gitHubConnector.getReposOfUser();
        res.forward(gitHubResponse);
    }
}
# README
# GitHub Client Connector Using Ballerina

### Overview
This client connector is a sample to demonstrate the functionality of Ballerina Connectors. This connector uses the following capabilities of github
 * View repositories for the authenticated user
 * List repositories for an organization
 * List issues per repository according to the state

### Deploying the service

* Clone the repo to your local machine. The folder structure will look as below
    ```sh
    -rootLocation
     |-com
     |-org
    ```
* Download [Ballerina Tools Distribution](https://ballerinalang.org/downloads/) and unzip it.
* Set your path so that it includes the bin folder of the ballerina distribution. 
    ```sh
    export PATH=$PATH:<LOCATION>/ballerina-tools-<version>/bin
    ```
* Go the cloned loction e.g. rootLocation and issue the following command to deploy the services 
    ```sh
    ballerina run com/test/sample
    ```
### Invoking the service
* A POST request to the /get/repo/authuser will provide the list of repositories of the authenticated user
    ```sh
    Method: POST
    Request: http://<host>:<port>/integrate/get/repo/authuser
    Headers:
    Username -> github authenticated user
    Token -> token of the authenticated user
    ```
* A POST request to the get/repo/{name of organization} will provide the list of repositories of the given organization
    ```sh
    Method: POST
    Request: http://<host>:<port>/integrate/get/repo/ballerinalang
    Headers:
    Username -> github authenticated user
    Token -> token of the authenticated user
    ```
* A POST request to the /get/issues/{name of organization}/{name of repository}/{required issue state} will provide a list of issues per organization, per repository filtered according to the state. The required state can be one of following [open, closed, or all]
    ```sh
    Method: POST
    Request: http://<host>:<port>/integrate/get/issues/ballerinalang/ballerina/open
    Headers:
    Username -> github authenticated user
    Token -> token of the authenticated user
    ```

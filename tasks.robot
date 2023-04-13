*** Settings ***
Documentation       Salesforce API examples.
...                 Prerequisites: See README.md

Resource  resources/CommonEnvironment.robot
#Resource  C:/Users/upiscopo/AppData/Local/Programs/Python310/Lib/site-packa
# ges/cumulusci/robotframework/Salesforce.robot
library  SeleniumLibrary  timeout=20
library  OperatingSystem
Library             Collections
Library             RPA.Robocorp.Vault
Library             RPA.Salesforce
Library             String
Library             RPA.Tables
Library    RPA.Browser.Selenium
Library    RPA.Word.Application

Suite Setup         Authenticate
Task Setup          Generate random name

*** Variables ***
${ACCOUNT_TEST}    001B000001SbJzNIAV
${URL}             https://ssss6-dev-ed.develop.lightning.force.com/lightning/page/home
${search_NameFieldAccount}    //*[@name="Name"]

*** Tasks ***

Get the metadata for a Salesforce object
    ${metadata}=    Get Salesforce Object Metadata    Opportunity
    Log Dictionary    ${metadata}


*** Keywords ***
Authenticate
    ${secret}=    Get Secret    salesforce
    Auth With Token
    ...    ${secret}[username]
    ...    ${secret}[password]
    ...    ${secret}[token]

Generate random name
    ${random_string}=    Generate Random String
    Set Suite Variable    ${RANDOM_NAME}    Random name ${random_string}
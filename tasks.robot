*** Settings ***
Documentation       Salesforce API examples.
...                 Prerequisites: See README.md

Library             Collections
Library             RPA.Robocorp.Vault
Library             RPA.Salesforce
Library             String
Library             RPA.Tables

Task Setup  Authorize Salesforce


*** Tasks ***
Get and log the value of the vault secrets using the Get Secret keyword
    ${secret}=    Get Secret    credentials
    # Note: In real robots, you should not print secrets to the log.
    # This is just for demonstration purposes. :)
    Log    ${secret}[username]
    Log    ${secret}[password]
    
Create a new Salesforce object (Opportunity)
    # Salesforce -> Setup -> Object Manager -> Opportunity -> Fields & Relationships.
    # Pass in data as a dictionary of object field names.
    ${account}=
    ...    Salesforce Query Result As Table
    ...    SELECT Id FROM Account WHERE Name = 'Burlington Textiles Corp of America'
    ${object_data}=
    ...    Create Dictionary
    ...    AccountId=${account}[0][0]
    ...    CloseDate=2022-02-22
    ...    Name=${RANDOM_NAME}
    ...    StageName=Closed Won
    ${object}=    Create Salesforce Object    Opportunity    ${object_data}
    ${opportunity}=    Get Salesforce Object By Id    Opportunity    ${object}[id]
    Log Dictionary    ${opportunity}

Query objects using Salesforce Object Query Language (SOQL)
    # Salesforce -> Documentation -> Example SELECT Clauses.
    # Salesforce -> Setup -> Object Manager -> <Type> -> Fields & Relationships.
    ${opportunity}=
    ...    Salesforce Query Result As Table
    ...    SELECT AccountId, Amount, CloseDate, Description, Name FROM Opportunity
    ${list}=    Export Table    ${opportunity}
    Log List    ${list}

Describe a Salesforce object by type
    ${description}=    Describe Salesforce Object    Opportunity
    Log Dictionary    ${description}

Describe all picklist values for a Salesforce object field
    ${description}=    Describe Salesforce Object    Opportunity
    FOR    ${field}    IN    @{description}[fields]
        IF    "${field}[name]" == "StageName"
            Log List    ${field}[picklistValues]
        END
    END

Get the metadata for a Salesforce object
    ${metadata}=    Get Salesforce Object Metadata    Opportunity
    Log Dictionary    ${metadata}


*** Keywords ***
Authorize Salesforce
    ${secrets}=     Get Secret   salesforce
    Auth With Token
    ...        username=${secrets}[USERNAME]
    ...        password=${secrets}[PASSWORD]
    ...        api_token=${secrets}[API_TOKEN]

Generate random name
    ${random_string}=    Generate Random String
    Set Suite Variable    ${RANDOM_NAME}    Random name ${random_string}

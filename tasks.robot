*** Settings ***
Library     RPA.Salesforce
Task Setup  Authorize Salesforce

*** Variables ***
${ACCOUNT_NOKIA}    0015I000002jBLDQA2

*** Tasks ***
Change account details in Salesforce
    &{account}=      Get Salesforce Object By Id   Account  ${ACCOUNT_NOKIA}
    &{update_obj}=   Create Dictionary   Name=Nokia Ltd  BillingStreet=Nokia bulevard 1
    ${result}=       Update Salesforce Object  Account  ${ACCOUNT_NOKIA}  ${update_obj}

*** Keywords ***
Authorize Salesforce
    ${secrets}=     Get Secret   salesforce
    Auth With Token
    ...        username=${secrets}[USERNAME]
    ...        password=${secrets}[PASSWORD]
    ...        api_token=${secrets}[API_TOKEN]

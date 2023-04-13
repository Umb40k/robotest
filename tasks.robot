*** Settings ***
Documentation       Salesforce API examples.
...                 Prerequisites: See README.md

Resource  resources/CommonEnvironment.robot
#Resource  C:/Users/upiscopo/AppData/Local/Programs/Python310/Lib/site-packa
# ges/cumulusci/robotframework/Salesforce.robot
library  SeleniumLibrary  timeout=20
library  OperatingSystem
Library             Collections
Library             RPA.Salesforce
Library             String
Library             RPA.Tables
Library    RPA.Browser.Selenium

Suite Setup         Authenticate
Task Setup          Generate random name

*** Variables ***
${ACCOUNT_TEST}    001B000001SbJzNIAV
${URL}             https://ssss6-dev-ed.develop.lightning.force.com/lightning/page/home
${search_NameFieldAccount}    //*[@name="Name"]

*** Tasks ***
Change account details in Salesforcepy
  #  &{account}=      Get Salesforce Object By Id   Account  ${ACCOUNT_TEST}
  #  &{update_obj}=   Create Dictionary   Name=Nokia Ltd  BillingStreet=Nokia bulevard 1
  #  ${result}=       Update Salesforce Object  Account  ${ACCOUNT_TEST}  ${update_obj}

Create a new Salesforce object (Opportunity)
    # Salesforce -> Setup -> Object Manager -> Opportunity -> Fields & Relationships.
    # Pass in data as a dictionary of object field names.
    ${account}=
    ...    Salesforce Query Result As Table
    ...    SELECT Id FROM Account WHERE Name = 'Accord Lemo Auto Supplier'
    ${object_data}=
    ...    Create Dictionary
    ...    AccountId=${account}[0][0]
    ...    CloseDate=2022-02-22
    ...    Name=${RANDOM_NAME}
    ...    StageName=Closed Won
    ${object}=    Create Salesforce Object    Opportunity    ${object_data}
    ${opportunity}=    Get Salesforce Object By Id    Opportunity    ${object}[id]
    Log Dictionary    ${opportunity}

Create a new Salesforce object (Account)
    # Salesforce -> Setup -> Object Manager -> Account -> Fields & Relationships.
    # Pass in data as a dictionary of object field names.//div[@class="slds-form-element__control slds-grow"]....umberto32//*[@id="input-189"]
    ${object_data}=
    ...    Create Dictionary
    ...    Name=${RANDOM_NAME}
    ${object}=    Create Salesforce Object    Account    ${object_data}
    ${account}=    Get Salesforce Object By Id    Account    ${object}[id]
    Log Dictionary    ${account}

Create_Account
    Open Chrome Browser    ${URL}
	RPA.Browser.Selenium.Wait Until Element Is Visible      xpath://input[@id='username']
	RPA.Browser.Selenium.Wait Until Element Is Visible   xpath://input[@id='password']
	RPA.Browser.Selenium.Click Element       xpath://input[@id='username']
    RPA.Browser.Selenium.input text     //*[@id="username"]       pdev@sf.com
	RPA.Browser.Selenium.Click Element   xpath://input[@id='password']
	RPA.Browser.Selenium.input text      id:password       umberto32
	RPA.Browser.Selenium.Click Element    xpath://input[@id='Login']
    sleep    5s
    RPA.Browser.Selenium.Wait Until Element Is Visible      //one-app-nav-bar-item-root[@data-id="Account"]
    RPA.Browser.Selenium.Click Element    //one-app-nav-bar-item-root[@data-id="Account"]
	sleep    3s
    RPA.Browser.Selenium.Click Element    //*[@id="brandBand_1"]/div/div/div/div/div[1]/div[1]/div[2]/ul/li[1]/a/div
	sleep    3s
	RPA.Browser.Selenium.Wait Until Element Is Visible      ${search_NameFieldAccount}
	Sleep    1s
	RPA.Browser.Selenium.Input Text       ${search_NameFieldAccount}       ${RANDOM_NAME}
	Sleep    1s
	RPA.Browser.Selenium.Click Element    //button[@name='SaveEdit']
	sleep    8s
	RPA.Browser.Selenium.Click Element    //span[@class="uiImage"]
	Sleep    3s
	RPA.Browser.Selenium.Wait Until Element Is Visible      //a[@class="profile-link-label logout uiOutputURL"]
	RPA.Browser.Selenium.Click Element    //a[@class="profile-link-label logout uiOutputURL"]
	RPA.Browser.Selenium.Close Browser





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
            Log List    ${field}[picklistValues]        END
    END

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
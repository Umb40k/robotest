*** Keywords ***

Call all python libraries and resources
    import library  SeleniumLibrary  timeout=20
    import library  OperatingSystem
    import resource  C:/Users/upiscopo/AppData/Local/Programs/Python310/Lib/site-packages/cumulusci/robotframework/Salesforce.robot
    import library  OperatingSystem
    import Library             Collections
    import Library             RPA.Robocorp.Vault
    import Library             RPA.Salesforce
    import Library             String
    import Library             RPA.Tables
    import Library    RPA.Browser.Selenium
    import Library    RPA.Word.Application

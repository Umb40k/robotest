*** Settings ***
Library           Process

*** Test Cases ***
Example of running a python script
    [Tags]    Test
    ${result}=    Run Process     python     hello.py
    Log    all output: ${result.stdout} 
    Should be equal as strings  ${result.stdout}  Hello

*** Settings ***
Resource  resource.robot
Resource  sign_in_and_login_resource.robot
Suite Setup  Open And Configure Browser And Initialize Database
Suite Teardown  Close Browser

*** Test Cases ***
Register User Succesfully And Logout
    Register As  testi  Testaaja1lmar!
    Should Be Logged In
    Logout
    Login Page Should Be Open

Loign Succesfully And Logout
    Login As  testi  Testaaja1lmar!
    Should Be Logged In
    Logout
    Login Page Should Be Open

Login Unsuccesfully With Correct Username And Incorrect Password
    Login As  testi  !Testaaja1lmar
    Wont Allow Logging In And Login Page Contains Error Message

Login Unsuccesfully With Incorrect Username And Correct Password
    Login As  MasterTester  Testaaja1lmar!
    Wont Allow Logging In And Login Page Contains Error Message

Register Unsuccesfully With Too Short Password
    Register As  TesterMaster  T3st!
    Wont Allow Registering And Register Page Contains Error Message

Register Unsuccesfully With Password That Has No Capital Letters
    Register As  TesterMaster  testaaja1lmar!
    Wont Allow Registering And Register Page Contains Error Message

Register Unsuccesfully With Password That Has No Numbers
    Register As  TesterMaster  Testaajailmar!
    Wont Allow Registering And Register Page Contains Error Message

Register Unsuccesfully With Password That Has No Special Characters
    Register As  TesterMaster  Testaaja1lmari
    Wont Allow Registering And Register Page Contains Error Message

*** Keywords ***
Register As
    [Arguments]  ${username}  ${password}
    Go To Signin Page
    Set User Credentials  ${username}  ${password}
    Submit Signin Credentials

Login As
    [Arguments]  ${username}  ${password}
    Go To Login Page
    Set User Credentials  ${username}  ${password}
    Submit Login Credentials

Wont Allow Registering And Register Page Contains Error Message
    Register Page Should Be Open
    Page Should Contain  Username taken or invalid password

Wont Allow Logging In And Login Page Contains Error Message
    Login Page Should Be Open
    Page Should Contain  Invalid credentials.
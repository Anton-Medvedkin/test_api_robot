
*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://qa-scooter.praktikum-services.ru/api/v1/

*** Keywords ***

Delete Courier
    ${json_data}=    Create Dictionary    login=Vas1234    password=1234
    ${response}=     POST  ${BASE_URL}courier/login    data=${json_data}
    DELETE  ${BASE_URL}courier/${response.json()['id']}

*** Test Cases ***
Test The Courier Can Log In
    ${json_data}=    Create Dictionary    login=Vas12345    password=1234    firstName=vasia
    POST   ${BASE_URL}courier    data=${json_data}
    ${json_data} =  Create Dictionary  login=Vas12345  password=1234
    ${response} =  Run Keyword And Return Status  POST  ${BASE_URL}courier/login  data=${json_data}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  200
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'id': ${login_courier}}
    Delete Courier

Test Without Data - Login Without Login
    ${json_data} =  Create Dictionary  password=1234
    ${response} =  Run Keyword And Return Status  POST  ${BASE_URL}courier/login  data=${json_data}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  400
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для входа'}

Test Without Data - Login Without Password
    ${json_data} =  Create Dictionary  login=Vas1
    ${response} =  Run Keyword And Return Status  POST  ${BASE_URL}courier/login  data=${json_data}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  400
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для входа'}

Test Entering Non-Existent Data - Invalid Logs
    ${json_data} =  Create Dictionary  login=Inanko  password=1234
    ${response} =  Run Keyword And Return Status  POST  ${BASE_URL}courier/login  data=${json_data}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  404
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Учетная запись не найдена'}

Test Entering Non-Existent Data - Invalid Password
    ${json_data} =  Create Dictionary  login=Vas1  password=123456788
    ${response} =  Run Keyword And Return Status  POST  ${BASE_URL}courier/login  data=${json_data}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  404
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Учетная запись не найдена'}


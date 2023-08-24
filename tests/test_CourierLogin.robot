
*** Settings ***
Library           RequestsLibrary
Resource          ../resources/keywords.robot
Resource          ../resources/base_url.robot

*** Test Cases ***
Test The Courier Can Log In
    ${json_data}=    Create Dictionary    login=${BASE_LOGIN}    password=1234    firstName=vasia
    POST   ${BASE_URL}courier    data=${json_data}
    ${json_data} =  Create Dictionary  login=${BASE_LOGIN}  password=1234
    ${response} =  POST  ${BASE_URL}courier/login  data=${json_data}  expected_status=200
    Status Should Be  200  ${response}
    Delete Courier

Test Without Data - Login Without Login
    ${json_data} =  Create Dictionary  password=1234
    ${response} =  POST  ${BASE_URL}courier/login  data=${json_data}  expected_status=400
    Status Should Be  400  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для входа'}

Test Without Data - Login Without Password
    ${json_data} =  Create Dictionary  login=Vas1
    ${response} =  POST  ${BASE_URL}courier/login  data=${json_data}  expected_status=400
    Status Should Be  400  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для входа'}

Test Entering Non-Existent Data - Invalid Logs
    ${json_data} =  Create Dictionary  login=Inanko  password=1234
    ${response} =  POST  ${BASE_URL}courier/login  data=${json_data}  expected_status=404
    Status Should Be  404  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Учетная запись не найдена'}

Test Entering Non-Existent Data - Invalid Password
    ${json_data} =  Create Dictionary  login=Vas1  password=123456788
    ${response} =  POST  ${BASE_URL}courier/login  data=${json_data}  expected_status=404
    Status Should Be  404  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Учетная запись не найдена'}



*** Settings ***
Library           RequestsLibrary
Resource          ../resources/keywords.robot
Resource          ../resources/base_url.robot

*** Test Cases ***
Test Can Create a Courier
    ${response} =  Create Courier
    Status Should Be  201  ${response}
    Should Be Equal As Strings  ${response.json()}  {'ok': True}
    Delete Courier

Test Inability To Create - Two Identical Couriers
    Create Courier
    ${json_data} =  Create Dictionary  login=${BASE_LOGIN}  password=1234  firstName=vasia
    ${response} =  POST  ${BASE_URL}courier  data=${json_data}  expected_status=409
    Status Should Be  409  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 409, 'message': 'Этот логин уже используется. Попробуйте другой.'}
    Delete Courier

Test Without Date - Create Without Login
    ${json_data} =  Create Dictionary  password=1234  firstName=saske
    ${response} =  POST  ${BASE_URL}courier  data=${json_data}  expected_status=400
    Status Should Be  400  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для создания учетной записи'}


Test Without Date - Create Without Password
    ${json_data} =  Create Dictionary  login=yura  firstName=saske
    ${response} =  POST  ${BASE_URL}courier  data=${json_data}  expected_status=400
    Status Should Be  400  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для создания учетной записи'}








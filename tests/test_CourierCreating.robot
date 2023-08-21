
*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://qa-scooter.praktikum-services.ru/api/v1/

*** Keywords ***
Create Courier
    ${json_data}=    Create Dictionary    login=AntonMe    password=1234    firstName=vasia
    ${response}=     POST  ${BASE_URL}courier    data=${json_data}
    [Return]  ${response}

Delete Courier
    ${json_data}=    Create Dictionary    login=AntonMe    password=1234
    ${response}=     POST  ${BASE_URL}courier/login    data=${json_data}
    DELETE  ${BASE_URL}courier/${response.json()['id']}


*** Test Cases ***
Test Can Create a Courier
    ${create_courier} =  Create Courier
    ${status_code}=  Convert To String  ${create_courier.status_code}
    Should Be Equal  ${status_code}  201
    Should Be Equal As Strings  ${create_courier.json()}  {'ok': True}
    Delete Courier

Test Inability To Create - Two Identical Couriers
    Create Courier
    ${json_data} =  Create Dictionary  login=AntonMe  password=1234  firstName=vasia
    ${response} =  Run Keyword And Return Status  POST  ${BASE_URL}courier  data=${json_data}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  409
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 409, 'message': 'Этот логин уже используется. Попробуйте другой.'}
    Delete Courier

Test Without Date - Create Without Login
    ${json_data} =  Create Dictionary  password=1234  firstName=saske
    ${response} =  Run Keyword And Return Status  POST  ${BASE_URL}courier  data=${json_data}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  400
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для создания учетной записи'}


Test Without Date - Create Without Password
    ${json_data} =  Create Dictionary  login=yura  firstName=saske
    ${response} =  Run Keyword And Return Status  POST  ${BASE_URL}courier  data=${json_data}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  400
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для создания учетной записи'}



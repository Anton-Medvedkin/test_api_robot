
*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://qa-scooter.praktikum-services.ru/api/v1/

*** Keywords ***
Create Courier
    ${json_data}=    Create Dictionary    login=AntonMedv    password=1234    firstName=vasia
    ${response}=     POST  ${BASE_URL}courier    data=${json_data}
    [Return]  ${response}


*** Test Cases ***
Test Successful Deletion
    Create Courier
    ${json_data}=    Create Dictionary    login=AntonMedv    password=1234
    ${response}=     POST  ${BASE_URL}courier/login    data=${json_data}
    ${response_delete}=     DELETE  ${BASE_URL}courier/${response.json()['id']}
    ${status_code}=  Convert To String  ${response_delete.status_code}
    Should Be Equal  ${status_code}  200
    Should Be Equal As Strings  ${response_delete.json()}  {'ok': True}

Test Deletion With Invalid ID
    ${id} =  Set Variable  12345678
    ${response} =   DELETE  ${BASE_URL}courier/${id}
    Log To Console  ${response.status_code}
    Should Be Equal As Strings  ${response.status_code}  404
    Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Курьера с таким id нет.'}

Test Deletion Without ID
    ${response} =  Run Keyword And Return Status  DELETE  ${BASE_URL}courier/
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  400
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для удаления курьера'}

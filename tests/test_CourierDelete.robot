
*** Settings ***
Library           RequestsLibrary
Resource          ../resources/keywords.robot
Resource          ../resources/base_url.robot

*** Test Cases ***
Test Successful Deletion
    Create Courier
    ${json_data}=    Create Dictionary    login=${BASE_LOGIN}    password=1234
    ${response}=     POST  ${BASE_URL}courier/login    data=${json_data}
    ${response_delete}=     DELETE  ${BASE_URL}courier/${response.json()['id']}  expected_status=200
    Status Should Be  200  ${response_delete}
    Should Be Equal As Strings  ${response_delete.json()}  {'ok': True}

Test Deletion With Invalid ID
    ${id} =  Set Variable  12345678
    ${response} =   DELETE  ${BASE_URL}courier/${id}  expected_status=404
    Status Should Be  404  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Курьера с таким id нет.'}

Test Deletion Without ID
    ${response} =  DELETE  ${BASE_URL}courier/   expected_status=400
    Status Should Be  400  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для удаления курьера'}

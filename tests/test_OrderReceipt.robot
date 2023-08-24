
*** Settings ***
Library           RequestsLibrary
Resource          ../resources/keywords.robot
Resource          ../resources/base_url.robot


*** Test Cases ***
Test Successful Receipt of Order
    ${create_order} =  Create Order
    ${url}=    Set Variable    ${BASE_URL}orders/track
    ${params}=    Create Dictionary    t=${create_order}
    ${response}=    GET    ${url}    params=${params}  expected_status=200
    Status Should Be  200  ${response}
    Should Contain    ${response.json()}    order

Test Without an Order Number
    ${response} =  GET  ${BASE_URL}orders/track    expected_status=400
    Status Should Be  400  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для поиска'}

Test Non-Existent Order Number
    ${url}=    Set Variable    ${BASE_URL}orders/track
    ${params}=    Create Dictionary    t=123456789
    ${response}=    GET    ${url}    params=${params}  expected_status=404
    Status Should Be  404  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Заказ не найден'}


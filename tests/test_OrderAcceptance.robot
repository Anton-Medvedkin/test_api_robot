
*** Settings ***
Library           RequestsLibrary
Resource          ../resources/keywords.robot
Resource          ../resources/base_url.robot

*** Test Cases ***
Test Successful Order Acceptance
    ${login_courier} =   Login Courier
    ${create_order_id} =   Create Order ID
    ${url}=    Set Variable    ${BASE_URL}orders/accept/${create_order_id}
    ${params}=    Create Dictionary    courierId=${login_courier}
    ${response}=    PUT    ${url}    params=${params}  expected_status=200
    Status Should Be  200  ${response}
    Should Be Equal As Strings  ${response.json()}  {'ok': True}
    Delete Courier

Test With Non-Existent Parameters - Accepting an Order with Non-Existent Courier ID
    ${create_order_id} =  Create Order ID
    ${url}=    Set Variable    ${BASE_URL}orders/accept/${create_order_id}
    ${params}=    Create Dictionary    courierId=200020
    ${response}=    PUT    ${url}    params=${params}  expected_status=404
    Status Should Be  404  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Курьера с таким id не существует'}

Test With Non-Existent Parameters - Accepting an Order with Non-Existent Order ID
    ${login_courier} =  Login Courier
    ${url}=    Set Variable    ${BASE_URL}orders/accept/454684
    ${params}=    Create Dictionary    courierId=${login_courier}
    ${response}=    PUT    ${url}    params=${params}  expected_status=404
    Status Should Be  404  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Заказа с таким id не существует'}
    Delete Courier

Test Without Parameters - Order Acceptance Without Courier ID
    ${create_order_id} =  Create Order ID
    ${response} =  PUT  ${BASE_URL}orders/accept/${create_order_id}    expected_status=400
    Status Should Be  400  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для поиска'}

Test Without Parameters - Order Acceptance Without Order ID
    ${login_courier} =  Login Courier
    ${url}=    Set Variable    ${BASE_URL}orders/accept/
    ${params}=    Create Dictionary    courierId=${login_courier}
    ${response}=  Run Keyword And Ignore Error  PUT    ${url}    params=${params}    expected_status=400
    Delete Courier
    Status Should Be  400  ${response}
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для поиска'}


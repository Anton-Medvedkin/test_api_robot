
*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://qa-scooter.praktikum-services.ru/api/v1/


*** Keywords ***
Login Courier
    ${json_data}=    Create Dictionary    login=Antonella12345    password=1234    firstName=vasia
    POST   ${BASE_URL}courier    data=${json_data}
    ${json_data}=    Create Dictionary    login=Antonella12345    password=1234
    ${response}=     POST   ${BASE_URL}courier/login    data=${json_data}
    ${data}=         ${response.json()}
    ${id}=           ${data['id']}
    [Return]        ${id}


Create Order ID
    ${json_data}=    Create Dictionary    firstName=Antonella12345    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=[BLACK]
    ${response}=     POST  ${BASE_URL}orders    json=${json_data}
    ${track}=        ${response.json()['track']}
    ${response}=     POST     ${BASE_URL}orders/track?t=${track}
    ${order_id}=     ${response.json()['order']['id']}
    [Return]        ${order_id}

Delete Courier
    ${json_data}=    Create Dictionary    login=Antonella12345    password=1234
    ${response}=     POST  ${BASE_URL}courier/login    data=${json_data}
    DELETE  ${BASE_URL}courier/${response.json()['id']}

*** Test Cases ***
Test Successful Order Acceptance
    ${login_courier} =   Login Courier
    ${create_order_id} =   Create Order ID
    ${response} =  Run Keyword And Return Status  PUT  ${BASE_URL}orders/accept/${create_order_id}?courierId=${login_courier}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  200
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'ok': True}
    Delete Courier

Test With Non-Existent Parameters - Accepting an Order with Non-Existent Courier ID
    ${create_order_id} =  Create Order ID
    ${response} =  Run Keyword And Return Status  PUT  ${BASE_URL}orders/accept/${create_order_id}?courierId=2000200200
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  404
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Курьера с таким id не существует'}

Test With Non-Existent Parameters - Accepting an Order with Non-Existent Order ID
    ${login_courier} =  Login Courier
    ${response} =  Run Keyword And Return Status  PUT  ${BASE_URL}orders/accept/454684?courierId=${login_courier}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  404
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Заказа с таким id не существует'}
    Delete Courier

Test Without Parameters - Order Acceptance Without Courier ID
    ${create_order_id} =  Create Order ID
    ${response} =  Run Keyword And Return Status  PUT  ${BASE_URL}orders/accept/${create_order_id}
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.status_code}  400
    Run Keyword And Ignore Error  Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для поиска'}

Test Without Parameters - Order Acceptance Without Order ID
    ${login_courier} =  Login Courier
    ${response} =  PUT  ${BASE_URL}orders/accept/?courierId=${login_courier}
    Should Be Equal  ${response.status_code}  400
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для поиска'}
    Delete Courier

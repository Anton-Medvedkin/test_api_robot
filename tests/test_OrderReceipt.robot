
*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://qa-scooter.praktikum-services.ru/api/v1/

*** Keywords ***
Create Order
    ${json_data}=    Create Dictionary    firstName=Anton    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=[BLACK]
    ${response}=     POST  ${BASE_URL}orders    json=${json_data}
    ${track}=        ${response.json()['track']}
    [Return]        ${track}

*** Test Cases ***
Test Successful Receipt of Order
    ${create_order} =  Create Order
    ${response} =  GET  ${BASE_URL}orders/track?t=${create_order}
    Should Be Equal  ${response.status_code}  200
    Should Contain  order  ${response.json()}

Test Without an Order Number
    ${response} =  GET  ${BASE_URL}orders/track
    Should Be Equal  ${response.status_code}  400
    Should Be Equal As Strings  ${response.json()}  {'code': 400, 'message': 'Недостаточно данных для поиска'}

Test Non-Existent Order Number
    ${response} =  GET  ${BASE_URL}orders/track?t=123456789
    Should Be Equal  ${response.status_code}  404
    Should Be Equal As Strings  ${response.json()}  {'code': 404, 'message': 'Заказ не найден'}


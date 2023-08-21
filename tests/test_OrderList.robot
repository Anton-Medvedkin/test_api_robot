
*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://qa-scooter.praktikum-services.ru/api/v1/

*** Test Cases ***
Test List Order
    ${response} =  GET  ${BASE_URL}orders
    ${order_data} =  Set Variable  ${response.json()}
    Should Be Equal  ${response.status_code}  200
    Should Contain  orders  ${order_data}
    Should Be List  ${order_data["orders"]}


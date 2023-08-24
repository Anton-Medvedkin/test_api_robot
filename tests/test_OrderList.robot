
*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          ../resources/base_url.robot


*** Test Cases ***
Test List Order
    ${response} =  GET  ${BASE_URL}/orders  expected_status=200
    ${order_data} =  Set Variable  ${response.json()}
    Status Should Be  200  ${response}
    List Should Contain Value  ${order_data}  orders
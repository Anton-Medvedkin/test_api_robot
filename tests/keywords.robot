
*** Settings ***
Library  RequestsLibrary

*** Variables ***
${BASE_URL}       http://qa-scooter.praktikum-services.ru/api/v1/

*** Keywords ***
Create Courier
    ${json_data}=    Create Dictionary    login=AntonMed    password=1234    firstName=vasia
    ${response}=     POST  ${BASE_URL}courier    data=${json_data}
    [Return]  ${response}

Delete Courier
    ${json_data}=    Create Dictionary    login=AntonMed    password=1234
    ${response}=     POST  ${BASE_URL}courier/login    data=${json_data}
    DELETE  ${BASE_URL}courier/${response.json()['id']}

#Login Courier
#    ${json_data}=    Create Dictionary    login=Vasiliy    password=1234    firstName=vasia
#    POST   ${BASE_URL}courier    data=${json_data}
#    ${json_data}=    Create Dictionary    login=Vasiliy    password=1234
#    ${response}=     POST   ${BASE_URL}courier/login    data=${json_data}
#    ${data}=         ${response.json()}
#    ${id}=           ${data['id']}
#    [Return]        ${id}
#    DELETE  ${BASE_URL}courier/${id}

#Delete Courier
#    ${json_data}    Create Dictionary    login=Vasiliy    password=1234    firstName=vasia
#    Post Request   ${BASE_URL}courier    data=${json_data}
#    ${json_data}    Create Dictionary    login=Vasiliy    password=1234
#    ${response}     Post Request   ${BASE_URL}courier/login    data=${json_data}
#    ${data}         ${response.json()}
#    ${id}           ${data['id']}
#    ${response}     Delete Request  ${BASE_URL}courier/${id}
#    [Return]        ${response}
#
#Create Order
#    ${json_data}    Create Dictionary    firstName=Anton    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=[BLACK]
#    ${response}     Post Request  ${BASE_URL}orders    json=${json_data}
#    ${track}        ${response.json()['track']}
#    [Return]        ${track}
#
#Create Order ID
#    ${json_data}    Create Dictionary    firstName=Antonio    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=[BLACK]
#    ${response}     Post Request  ${BASE_URL}orders    json=${json_data}
#    ${track}        ${response.json()['track']}
#    ${response}     Get Request     ${BASE_URL}orders/track?t=${track}
#    ${order_id}     ${response.json()['order']['id']}
#    [Return]        ${order_id}

*** Test Cases ***
Test Can Create a Courier
    ${create_courier} =  Create Courier
    ${status_code}=  Convert To String  ${create_courier.status_code}
    Should Be Equal  ${status_code}  201
    Should Be Equal As Strings  ${create_courier.json()}  {'ok': True}
    Delete Courier







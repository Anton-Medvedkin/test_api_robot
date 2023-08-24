
*** Settings ***
Library           RequestsLibrary
Resource          base_url.robot


*** Keywords ***

Create Courier
    ${json_data}=    Create Dictionary    login=${BASE_LOGIN}    password=1234    firstName=vasia
    ${response}=     POST  ${BASE_URL}courier    data=${json_data}
    [Return]  ${response}

Login Courier
    ${json_data}=    Create Dictionary    login=${BASE_LOGIN}    password=1234    firstName=vasia
    POST   ${BASE_URL}courier    data=${json_data}
    ${json_data}=    Create Dictionary    login=${BASE_LOGIN}    password=1234
    ${response}=     POST   ${BASE_URL}courier/login    data=${json_data}
    ${data}=    Set Variable  ${response.json()}
    ${id}=    Set Variable    ${data['id']}
    [Return]        ${id}

Create Order
    ${color_list}=    Create List    BLACK
    ${json_data}=    Create Dictionary    firstName=Anton    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=${color_list}
    ${response}=     POST  ${BASE_URL}orders    json=${json_data}
    ${track}=    Set Variable    ${response.json()['track']}
    [Return]        ${track}


Create Order ID
    ${color_list}=    Create List    BLACK
    ${json_data}=    Create Dictionary    firstName=Anton    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=${color_list}
    ${response}=     POST  ${BASE_URL}orders    json=${json_data}
    ${url}=    Set Variable    ${BASE_URL}orders/track
    ${params}=    Create Dictionary    t=${response.json()['track']}
    ${response_id}=    GET    ${url}    params=${params}
    [Return]        ${response_id.json()['order']['id']}


Delete Courier
    ${json_data}=    Create Dictionary    login=${BASE_LOGIN}    password=1234
    ${response}=     POST  ${BASE_URL}courier/login    data=${json_data}
    DELETE  ${BASE_URL}courier/${response.json()['id']}


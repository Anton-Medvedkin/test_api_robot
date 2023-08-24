
*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          ../resources/base_url.robot


*** Test Cases ***
Test With Color BLACK
    ${color_list}=    Create List    BLACK
    ${json_data}=    Create Dictionary    firstName=Anton    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=${color_list}
    ${response} =  POST  ${BASE_URL}orders  json=${json_data}    expected_status=201
    Status Should Be  201  ${response}
    ${response_data} =  Set Variable  ${response.json()}
    Dictionary Should Contain Key  ${response_data}  track
    Should Be True  isinstance(${response_data["track"]}, int)

Test With Color GRAY
    ${color_list}=    Create List    GRAY
    ${json_data}=    Create Dictionary    firstName=Anton    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=${color_list}
    ${response} =  POST  ${BASE_URL}orders  json=${json_data}    expected_status=201
    Status Should Be  201  ${response}
    ${response_data} =  Set Variable  ${response.json()}
    Dictionary Should Contain Key  ${response_data}  track
    Should Be True  isinstance(${response_data["track"]}, int)

Test With Color GRAY BLACK
    ${color_list}=    Create List    GRAY  BLACK
    ${json_data}=    Create Dictionary    firstName=Anton    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha    color=${color_list}
    ${response} =  POST  ${BASE_URL}orders  json=${json_data}    expected_status=201
    Status Should Be  201  ${response}
    ${response_data} =  Set Variable  ${response.json()}
    Dictionary Should Contain Key  ${response_data}  track
    Should Be True  isinstance(${response_data["track"]}, int)

Test Without Color
    ${json_data}=    Create Dictionary    firstName=Anton    lastName=Uchiha    address=Konoha, 142 apt.    metroStation=4    phone=+7 800 355 35 35    rentTime=5    deliveryDate=2020-06-06    comment=Saske, come back to Konoha
    ${response} =  POST  ${BASE_URL}orders  json=${json_data}    expected_status=201
    Status Should Be  201  ${response}
    ${response_data} =  Set Variable  ${response.json()}
    Dictionary Should Contain Key  ${response_data}  track
    Should Be True  isinstance(${response_data["track"]}, int)



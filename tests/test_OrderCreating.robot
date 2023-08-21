
*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://qa-scooter.praktikum-services.ru/api/v1/

*** Test Cases ***
Test With Color - No Color
    [Template]  Test With Color
    ${color}  None

Test With Color - BLACK
    [Template]  Test With Color
    ${color}  BLACK

Test With Color - GRAY
    [Template]  Test With Color
    ${color}  GRAY

Test With Color - BLACK_GRAY
    [Template]  Test With Color
    ${color}  BLACK_GRAY

*** Test Cases ***
Test With Color
    [Arguments]  ${color}
    ${json_data} =  Create Dictionary
    ...  firstName=Naruto
    ...  lastName=Uchiha
    ...  address=Konoha, 142 apt.
    ...  metroStation=4
    ...  phone=+7 800 355 35 35
    ...  rentTime=5
    ...  deliveryDate=2020-06-06
    ...  comment=Saske, come back to Konoha

    Run Keyword If  '${color}' != 'None'
    ...  Set To Dictionary  ${json_data}  color=[${color}]

    ${response} =  POST  ${BASE_URL}orders  json=${json_data}
    Should Be Equal  ${response.status_code}  201

    ${response_data} =  Set Variable  ${response.json()}
    Should Contain  track  ${response_data}
    Should Be Integer  ${response_data["track"]}


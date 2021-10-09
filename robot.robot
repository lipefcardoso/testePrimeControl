
*** Settings ***
Library           Selenium2Library
Library           API_CLASH
Suite Setup       Open Browser    ${url_whatismyip}    ${browser} 
Suite Teardown    Close All Browsers

*** Variables ***
${libraries}    C:\Users\Felipe\Desktop\Teste Prime Control\CustomLibraries
${url_clash_royale}  https://developer.clashroyale.com
${url_whatismyip}    https://www.whatismyip.com/
${browser}    Chrome
${element_ipv4}    xpath=//*[@id="ipv4"]
${element_login_link}    xpath=//*[@id='content']/div/div[2]/div/header/div/div/div[3]/div/a[2]
${element_email}    id=email
${element_password}    id=password
${input_email}  lipe_fcardoso@hotmail.com
${input_password}   testePrimeControl
${element_login_button}    xpath=//*[@id="content"]/div/div[2]/div/div/div/div/div/div/form/div[4]/button
${element_account_name}    xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/button
${element_my_account}    xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/ul/li[1]/a
${element_create_new_key}    xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/p/a/span[2]
${element_key_name}    xpath=//*[@id="name"]
${element_description}    xpath=//*[@id="description"]
${element_ip_address}    xpath=//*[@id="range-0"]
${element_create_key}    xpath=//*[@id="content"]/div/div[2]/div/div/section/div/div/div[2]/form/div[5]/button/span[1]
${input_key_name}    testePrime
${input_description}    Teste de RPA para a empresa Prime Control
${input_ip_address}    179.111.38.190
${key_created_successfully}    xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/ul/div/span[3]
${element_created_api}    xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/ul/li/a
${element_api_key}    xpath=//*[@id="content"]/div/div[2]/div/div/section/div/div/div[2]/form/div[1]/div/samp
${path_csv}    C:\\Users\\Felipe\\Desktop\\Teste Prime Control\\Finalizado\\Members.csv

*** Test Cases ***

Access whatismyip.com
    Log    Accessing whatismyip.com
    Maximize Browser Window
    Wait Until Element Is Visible    ${element_ipv4}
    FOR    ${counter}    IN RANGE    10    
        ${input_ip_adress} =    Get Text    ${element_ipv4}
        Exit For Loop If    "${input_ip_adress}" != "Not Yet Detected"
    END
    Log    "IP Address collected: ${input_ip_adress}""

Access Clash Royale Login Page
    Log    Accessing whatismyip.com
    Go To    ${url_clash_royale}
    Wait Until Element Is Visible    ${element_login_link}
    Click Element    ${element_login_link}
    Wait Until Element Is Visible    ${element_email}

Login
    Log    Accessing whatismyip.com
    Input Text    ${element_email}    ${input_email}
    Input Password    ${element_password}    ${input_password}
    Log    Filled email and password
    Click Button    ${element_login_button}
    Wait Until Element Is Visible    ${element_account_name}
    Log    Success at Login

Access My Account
    Log    Accessing menu "My Account"
    Click Element    ${element_account_name} 
    Wait Until Element Is Visible    ${element_my_account}
    Click Element    ${element_my_account}
    Wait Until Element Is Visible    ${element_create_new_key}
    Log    Success at accessing "My Account"

Create New Key
    Log    Creating new api key
    Click Element    ${element_create_new_key}
    Wait Until Element Is Visible    ${element_create_key}
    Input Text    ${element_key_name}    ${input_key_name}
    Input Text    ${element_description}    ${input_description}
    Input Text    ${element_ip_address}    ${input_ip_address}
    Log    Filled key name, description ip address
    Click Element    ${element_create_key}
    Wait Until Element Is Visible    ${key_created_successfully}
    ${result_key_created} =    Get Text    ${key_created_successfully}   
    IF    "${result_key_created}" != "Key created successfully."
        Fail    "Key nao foi criada com sucesso (mensagem de sucesso inexistente)."
    Log    Clan api id: ${result_key_created} collected successfully
    END


Write To CSV
    Log    Collecting api key
    Wait Until Element Is Visible    ${element_created_api}
    Click Element    ${element_created_api}
    Wait Until Element Is Visible    ${element_api_key}
    ${api_key} =     Get Text    ${element_api_key}
    Log    Collecting api key ${api_key}
    Log    ${api_key}
    ${api_clan} =    Create Dictionary    url=https://api.clashroyale.com/v1/clans?name=Resistance    api_key=${api_key}
    Log    Collecting clan info ${api_clan} 
    ${obj_clan} =    Get Clan Information    ${api_clan}
    ${clan_tag} =    Get Clan Tag    ${obj_clan}
    Log    Collecting clan tag     ${clan_tag}
    ${api_clan_member} =    Create Dictionary    url=https://api.clashroyale.com/v1/clans/${clan_tag}/members    api_key=${api_key}
    ${obj_clan_member} =    Get Clan Member Information    ${api_clan_member}
    Write To Csv    ${path_csv}    ${obj_clan_member}
    Log    CSV written successfully
    




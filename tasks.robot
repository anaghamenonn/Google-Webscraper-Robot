*** Settings ***
Library         RPA.Browser.Selenium
Library         RPA.Excel.Files
Library         Collections
Library         String
Library         BuiltIn
Library         random
Library         OperatingSystem
Suite Setup     Setup chromedriver

*** Variables ***
${MIND_DELAY}       5
${MAX_DELAY}        10
${EXCEL_FILE}       Path to the excel file
${SHEET_NAME}       Sheet1
${GOOGLE_URL}       https://www.google.com
${SEARCH_BOX}       name=q
${COOKIE_CONSENT}   //div[text()='I agree']
${SEARCH_RESULTS}   //div[@id='search']//div[@class='g']//a
${DEBUG}            True

*** Tasks ***
Minimal Task
    Open Google With Signed In Account
    Handle Cookie Consent
    Open Excel File
    ${rows}=    Read Excel Data
    ${num_rows}=    Get Length    ${rows}
    FOR    ${index}    IN RANGE    0    ${num_rows}
        ${brand}=    Get From Dictionary    ${rows}[${index}]    A
        Log    Searching for: ${brand}
        ${link}=    Search Google And Return Link    ${brand}
        Log    Retrieved link: ${link}
        Run Keyword If    "${link}" != "No link found"    Update Excel With Link    ${index+1}    ${link}
        Sleep Random Time
    END
    Save And Close Excel File
    Close Browser
    Log    Task completed successfully.

*** Keywords ***

Open Google With Signed In Account
    [Documentation]    Open Google with a signed-in account from Chrome profile
    [Tags]    Open with Signed-in Account
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${browser}=    Open Browser    ${GOOGLE_URL}    Chrome    options=${chrome_options}
    Wait Until Page Contains Element    ${SEARCH_BOX}    timeout=20s
    Log    Browser opened successfully.
    [Return]    ${browser}

Handle Cookie Consent
    ${cookie_buttons}=    Get WebElements    ${COOKIE_CONSENT}
    ${cookie_button_count}=    Get Length    ${cookie_buttons}
    Run Keyword If    ${cookie_button_count} > 0    Click Element    ${COOKIE_CONSENT}

Open Excel File
    Open Workbook    ${EXCEL_FILE}

Read Excel Data
    ${rows}=    Read Worksheet    ${SHEET_NAME}
    [Return]    ${rows}

Search Google And Return Link
    [Arguments]    ${brand}
    Input Text    ${SEARCH_BOX}    ${brand}
    Press Keys    ${SEARCH_BOX}    ENTER
    Capture Page Screenshot    ${brand}_search.png
    Wait Until Element Is Visible    ${SEARCH_RESULTS}    timeout=30s
    ${mylinks}=    Get WebElements    ${SEARCH_RESULTS}
    ${num_links}=    Get Length    ${mylinks}
    Run Keyword If    ${DEBUG}    Log    Number of search results found: ${num_links}
    ${link}=    Run Keyword If    ${num_links} > 0    Get Element Attribute    ${mylinks}[0]    href    ELSE    Set Variable    No link found
    Log    Found link: ${link}
    [Return]    ${link}
    Go To Google Homepage

Go To Google Homepage
    Go To    ${GOOGLE_URL}
    Wait Until Page Contains Element    ${SEARCH_BOX}    timeout=20s

Update Excel With Link
    [Arguments]    ${row_index}    ${link}
    Log    Updating row ${row_index} with link ${link}
    Set Cell Value    ${row_index}    B    ${link}

Sleep Random Time
    ${delay}=    Evaluate    random.randint(${MIND_DELAY}, ${MAX_DELAY})
    Log    Sleeping for ${delay} seconds
    Sleep    ${delay}s

Save And Close Excel File
    Save Workbook
    Close Workbook

Close Browser
    Close All Browsers

*** Settings ***
Library    Selenium2Library

Suite Teardown    Close All Browsers


*** Test Cases ***
Title should be Static
    ${chrome options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome options}   add_argument    headless
    Call Method    ${chrome options}   add_argument    disable-gpu
    ${options}=     Call Method     ${chrome_options}    to_capabilities

    Create Webdriver    driver_name=Chrome    desired_capabilities=${options}
    
    #~~~~~~~~~~~~~~ HEADLESS ~~~~~~~~~~~~~~~~~~~~#
    ${chrome options} =     Evaluate        sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    Run Keyword If      '${ENV}' == 'HEADLESS'      Call Method         ${chrome options}   add_argument    headless
    Run Keyword If      '${ENV}' == 'HEADLESS'      Call Method         ${chrome options}   add_argument    disable-gpu

    ${options}=          Call Method                ${chrome_options}   to_capabilities

    Run Keyword If      '${ENV}' == 'HEADLESS'      Create Webdriver    driver_name=Chrome    desired_capabilities=${options}
    Run Keyword If      '${ENV}' == 'HEADLESS'      Go to               http://localhost:8080/



    #~~~~~~~~~~~~~~ VISUAL CHROME ~~~~~~~~~~~~~~~~~~~#
    Run Keyword If      '${ENV}' != 'HEADLESS'      open browser        http://localhost:8080/          chrome
    Run Keyword If      '${ENV}' != 'HEADLESS'      Maximize Browser Window

    Go to     http://localhost:8080/
    Title Should Be     Static

    Maximize Browser Window
    Capture Page Screenshot
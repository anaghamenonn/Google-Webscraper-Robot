# Google Search Automation with Robot Framework

This project is a Robot Framework automation script designed to search for a list of brands on Google and update an Excel file with the first search result link for each brand. The automation uses Selenium for browser interactions and RPA.Excel.Files for Excel file operations.

## Prerequisites

1. **Python**: Ensure Python is installed on your machine.
2. **Robot Framework**: Install Robot Framework by running:
   pip install robotframework
3. **SeleniumLibrary**: Install the SeleniumLibrary for Robot Framework:
   pip install robotframework-seleniumlibrary
4. **RPA Framework**: Install the RPA Framework for Excel file handling:
   pip install rpaframework
5. **ChromeDriver**: Make sure ChromeDriver is installed and matches your Chrome browser version. Add ChromeDriver to your system PATH.

## Usage
1. **Setup chromedriver**:
   Ensure chromedriver is available in your system PATH.
   Set up the path to your Chrome profile if needed for signed-in sessions.
2. **Update Variables**: 
   Update the variables in the script.
3. **Run the script**:
   Execute the script using the following command: 
   robot <script_name>.robot. 
   Replace <script_name> with the name of your Robot Framework file.

## License
   This project is licensed under the MIT License.
   This README file provides an overview of the project, prerequisites, detailed steps to set up and run the script, and information about the structure and usage of the script. It should help users understand and effectively utilize the provided Robot Framework automation code.

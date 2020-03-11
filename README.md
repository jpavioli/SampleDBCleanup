# SampleDBCleanup
Used to identify specific schemaIDs to cleanup in an mP data cleanup

## Creating Cleanup Script
1) Get all events currently in the JIT tables for the specific workspace through Admin UI then add them to the requestBody.js file 
2) Add script criteria by modifying the "checker" function in index.js 
3) Run the script by opening index.html with the bash command: $ open index.html 
4) The resulting output is a web page with the various Event Class and Event Class Detial IDs displayed. 

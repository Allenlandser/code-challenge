# code-challenge

-  Design

Basic use MVVM design pattern, the overall struct show as follows
Data models conforms to protocol for the purpose future extension and easy to mock in Unit Tests and UITests

http://github.com/Allenlandser/code-challenge/raw/master/DOC/WorkFlow.jpg

- Enviroment

xCode 9 and Swift 4
Integrate with cocoapods, make sure you have the cocoapods to run the code
Open FlickrSearcher.xcworkspace and hit command + R to run in debug mode

- Future work

Add UI tests and Unit Tests
Add operationQueue in APIClient to make sure the API call returns in correct order if user scrolls too fast
Use HTML parser to get the size of the image so that the photot size could be dynamic

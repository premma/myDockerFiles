# Description 

This docker is able to run your protractor based tests while running on a chrome, which output is targeted to virtual display. The chrome runs in ```--no-sandbox``` mode, so it does not try to create new PIDs and starts fine. All other dockers I found had the same problem: after 60 seconds it raised error: chrome cannot be reached,

# Usage
To run this docker as a binary in the directory where is your project and protractor configuration file, just run:
```shell
docker run -it --rm --net=host -p 127.0.0.1:<local port>:<local port> -v /dev/shm:/dev/shm -v $(pwd):/protractor premma/protractor-headless <protractor configuration file>
```
 
this will search for ```<protractor configuration file>``` and run the tests. If the file is ommited, it will search for default configuration file ```protractor.config.js``` and if it is not found, then ```protractor --help``` is displayed.

In configuration file you should not specify the address where the web-driver is listening, because it is already dealt inside the docker container.

The option ```-p 127.0.0.1:<port>:<port>``` gives the process inside docker container the rights to access 127.0.0.1:<port> on host machine, that means you can test locally running application on port ```<port>```

the ```-v /dev/shm:/dev/shm``` option is here for memory issues. By default the docker is allowed to use 64MB of shared memory, so this is a hack to mount the hosts shared memory and so it can use more that 64 MB.This is handy for large web pages, that would consume too much memory and fail to load properly in built-in chrome.

*Many thanks* goes to @webnicer, whose docker ```webnicer/protractor-headless``` I used to create this one. The changes I've made are:

1) chrome is installed using an apt-get, not downloaded from google website.
2) my protractor.sh file inside docker is slightly altered and now looks like this:
```shell
#!/bin/bash

CHROME_DEVEL_SANDBOX="" xvfb-run --server-args='-screen 0 1280x1024x24' protractor $@

``` 

  setting ```CHROME_DEVEL_SANDBOX``` to empty value ensure chrome not to start in sandbox mode,so the docker will run one instance of chrome only. That solves the problem with unreachable chrome browser.

I hope you enjoy this docker to run your protractor tests with chrome on machines, where there are no X servers at all.. Feel free to leave me comments. This is my first public docker, so I appreciate any advice you want to share.

# Screenshot reporter addon
If you want to use screenshot reported for protractor, you should implement following snippet of code into your protractor config file
```javascript
var HtmlScreenshotReporter = require('/usr/local/lib/node_modules/protractor-jasmine2-screenshot-reporter');

var reporter = new HtmlScreenshotReporter({
  dest: 'target/screenshots',
  filename: 'my-report.html'
});

exports.config = {
   // ...

   // Setup the report before any tests start
   beforeLaunch: function() {
      return new Promise(function(resolve){
        reporter.beforeLaunch(resolve);
      });
   },

   // Assign the test reporter to each running instance
   onPrepare: function() {
      jasmine.getEnv().addReporter(reporter);
   },

   // Close the report after all tests finish
   afterLaunch: function(exitCode) {
      return new Promise(function(resolve){
        reporter.afterLaunch(resolve.bind(this, exitCode));
      });
   }
}
```
and then start the protractor docker with following options:
```shell
docker run -it --rm --net=host -p 127.0.0.1:<local port>:<local port> -v /dev/shm:/dev/shm -v $(pwd):/protractor premma/protractor-headless <protractor configuration file>
```
The result report will be named my-report.html and will be placed in directory target/screenshots of current directory.

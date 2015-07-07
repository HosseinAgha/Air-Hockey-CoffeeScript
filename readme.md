# Air Hockey

### How to build the project
To build the project you should first download and install [Node.js](https://nodejs.org/download/).
when nodejs installed, you shall do the steps below:  
You can skip parts 1 & 2 if you don't want to install coffee and watchify globally.

1. install CoffeeScript globally by using node package manager:   
   enter this script in your terminal or command prompt: `npm -g install coffee-script` 
2. install watchify. this package creates a single JavaScript file from your coffee script files in realtime that is main.dist.js in my program:  
   `npm install -g watchify`  
3. go to main project directory and install the project dependencies and packages:  
   `npm install`
4. I defined a command in package.json file so you can run watchify properly and fast run it to start watching file:  
   `npm run watch` 
5. now if you make any changes to the coffee script files watchify updates the main.dist.js file on save  
6. open the page.html from pages folder and enjoy the game!!

### Notice  
I changed the ball and paddles speed so they get faster on each paddle collision but I think it is still bugy.


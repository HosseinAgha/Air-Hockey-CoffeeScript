# Air Hockey

### How to build the project
To build the project you should first download and install [Node.js](https://nodejs.org/download/).
when nodejs installed, you shall do the steps below:  
You can skip parts 1 to 3 if you don't want to install these packages globally, they will be installed locally inside your node project.

1. install [CoffeeScript](http://coffeescript.org/) globally by using node package manager:   
   enter this script in your terminal or command prompt: `npm -g install coffee-script`
2. install [watchify](https://www.npmjs.com/package/watchify) this package creates a single JavaScript file from your coffee script files in realtime. it uses coffeeify to compile coffee files:  
   `$ npm install -g watchify`
3. install [coffeeify](https://www.npmjs.com/package/coffeeify).  
   `$ npm install -g coffeeify`
4. go to main project directory and install the project dependencies and packages:  
   `$ npm install` or `$ npm i`
5. I defined a command in package.json file so you can run watchify with proper options, it starts compiling your changes to a main.dist.js file in dist folder:  
   `$ npm run watch` 
5. now if you make any changes to the CoffeeScript files watchify updates the main.dist.js file on save  
6. open the page.html from pages folder and enjoy the game!!



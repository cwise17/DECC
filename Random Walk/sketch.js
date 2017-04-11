/*
Connor Wise
Random Walkers!

This program generates a group of given random walkers and has them move according to a random 
direction and a normally distributed velocity as given by randomGuassian. The program utilizes
objects in order to have such a large number of walkers running at once.

*/
var walks = []; //list to hold all random walkers
var numwalks = 100; //number of walkers to generate 
var winwid = 400; //size of sq window

function setup() {
  createCanvas(winwid, winwid); //creates the window for walk
  for (i = 0; i < numwalks; i++){ //loops thru based on number of walkers I want
    walks.push(new Walks(winwid / 2, winwid / 2)); //creates a walker at center of screen
  }
  background(255); //whitebackground 
}

function draw() {
    walks.forEach(function(walks){ //runs the walks function for all walkers
        walks.step(); //loops them to change
        walks.display(); //puts them on the screen
    });
}

function Walks (x, y) {
    this.x = x; //object this.x = x
    this.y = y; //object this.y = y
}

Walks.prototype.display = function() {
    point(this.x, this.y); //point is placed at point this.x, this.y
};


Walks.prototype.step = function() {
    var direction = Direction(); //direction is result of Direction function
    var velocity = Velocity(); //velcity is result of Velocity function
    this.x += direction[0] * velocity; //x cord = x cord + direction(x) * velocity
    this.y += direction[1] * velocity; //y cord = y cord + direction(y) * velocity
};
function Direction () { //function to retrive direction 
    var n = floor(random(9)); //random number between 0 & 9, rounded
    switch (n){ //based on n, resutrns one of the cases
        case 0:
            return [-1, -1];
        case 1:
            return [-1, 0];
        case 2:
            return [-1, 1];
        case 3:
            return [0, -1];
        case 4:
            return [0, 0];
        case 5:
            return [0, 1];
        case 6:
            return [1, -1];
        case 7:
            return [1, 0];
        case 8:
            return [1, 1];
    }
}
function Velocity () { //function to find step size
    return randomGaussian(2, 0); //stepsize(velocity) = normally distributed random values 
}
var x, y, dir, x2, y2, dir2;
var x3, y3, dir3;
var randomR, randomG, randomB, randomC;
var numSteps;
//code in here happens once, initialize variables, create the window/ canvas
function setup() {
  
  createCanvas (400, 400);
  
  //start the particles in the middle
  x = 200;
  y = 200;
  
  x2 = 200;
  y2 = 200;
  
  x3 = 200;
  y3 = 200;
  
  numSteps = 0;
}

//1. set initial position (x, y)
//2. draw the particle
//3. pick a random direction between 0 and 3
//4. move one unit in direction
//5. if dir == 0 then move up (y = y + 1)
//6. if dir == 1 then move right (x = x + 1)
//7. if dir == 2 then move down (y = y - 1)
//8. if dir == 3 then move left (x = x -1)
//9. go back to step 2

//code inside here loops over and over
function draw() {
  //draw particle
  dir = floor(random(0, 4));
  if (x<20) {
    dir = floor(random(0, 3));
  }
  println(x);
  randomR = random(0, 255);
  randomG = random(0, 255);
  randomB = random(0, 255);
  noFill();
  stroke(randomR, randomG, randomB);
  strokeWeight(2);
  rect(x, y, 5, 5);
  stroke(255, 0, 0);
  strokeWeight(1/8);
  line(x, y, 200, 200);
  
  numSteps = numSteps + 1;
  //println(numSteps);
  
  //draw particle 2
  dir2 = floor(random(0, 4));
  randomC = random(0, 255);
  noFill();
  strokeWeight(2)
  stroke(randomC, randomC, randomC);
  ellipse(x2, y2, 5, 5);
  stroke(0, 255, 0);
  strokeWeight(1/8);
  line(x2, y2, 200, 200);
  
  //first particle movement
  if (dir === 0) { //move up
    y = y+5;
  }
  
  if (dir == 1) { //move right
    x = x+5;
  }
  
  if (dir == 2) { //move down
    y = y-5;
  }
  
  if (dir == 3) { //move left
    x = x-5;
  }
  
  //second particle movement  
  if (dir2 === 0) { //move up
    y2 = y2+5;
  }
  
  if (dir2 == 1) { //move right
    x2 = x2+5;
  }
  
  if (dir2 == 2) { //move down
    y2 = y2-5;
  }
  
  if (dir2 == 3) { //move left
    x2 = x2-5;
  }
}
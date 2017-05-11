// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

//Creates variables for the images for each program.
PImage worldProgram;
PImage pianoProgram;

//This creates a variable that determines the state of the program. It determines which program the screen is showing. It is also initiating the state as 0, which is the menu screen.
int state = 0;


void setup() {
  size(1920, 1080);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  //Loads image of world map program.
  worldProgram = loadImage("world.png");
}

void draw() {
  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();

  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);
  
  mouseX = int(v2.x);
  mouseY = int(v2.y);

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
    
      if (state == 0) {
    drawMenu();
    checkLocation();
  }
  
  else if( state == 1){
    drawMap();
  }
  
  else if(state == 2){
    drawPiano();
  }
  
  else if(state == 3){
    drawBalls();
  }
  
  
  else if (state == 5){
    //noLoop();
    setup();
    drawMenu();
  }
  textSize(40);
  text("EXIT", 30, 50);
  checkLocation();
}



void drawMenu() {
  background(255, 255, 255);
  //Draws image of world map program.
  image(worldProgram, 0, 0); 
  //green
  fill(0, 255, 0);
  rect(960, 0, 960, 540);
  //blue
  fill(0, 0, 255);
  rect(0, 540, 960, 540);
  //white
  fill(255, 255, 255);
  rect(960, 540, 960, 540);
  
  checkLocation();
}

void checkLocation (){
    if (state == 0){
      //top left
      if (mouseX < 820 && mouseX > 100 && mouseY < 540){
          state = 1;
          setupMap();
      }
      //bottom right
      if(mouseX > 1080 && mouseY > 540){
        state = 2;
      }
    //bottom left
      if(mouseX < 860 && mouseY > 540){
        state = 3;
      }
    //top right
      if(mouseX > 1080 && mouseY < 540){
        state = 4;
      }
    }
    else{
      if (mouseX< 100 && mouseY < 540){
      state = 5;
      textSize(40);
      text("EXIT", 50, 30); 
      }
    }
    
}


// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}
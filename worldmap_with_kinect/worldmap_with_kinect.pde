// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

/*Dylan Levene
May 9th, 2017
This program is part of the interactive video wall. It draws a map where the pixels have been changes to match the background. This map is draw on top of the background and you use you body in front of the motion tracking kinect to draw using a recursion to undercover a world map.
*/

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;

//This initiates the variable that will be used to draw the world map picture.
PImage world;
//This initiates that variables.
int x, y, r, r2; 
int rSize = 5; 


void setup() {
  size(1920, 1080);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  background(255, 255, 255);
  //This initiates the image variable as the image in the sketch folder.
  world = loadImage("worldmap.png");
  //Sets the dimmensions of the image. 
  int dim = width*height;
  //Sets the rate of loops per minute for the program.
  frameRate(20);
  
  //The pixels of the background are loaded so that they can be manipulated by the individual pixel.
  loadPixels();
  for (int i = 0; i <dim ; i++){
    //println(hex(world.pixels[i]));
      //Changes the colors of each pixel in the background.
      if (pixels[i] != 0) {
         float r = random(0, 255);
         float g = random(0, 255);
         float b = random(0, 255);
         pixels[i] = color(r, g, b);
       }
   }
    updatePixels();

  //The pixels of the image are loaded so they can also be manipulated.
  world.loadPixels();
  for (int i = 0; i <dim ; i++){
      //println(hex(world.pixels[i]));
      //Changes the color of each pixel in the image.
      if (world.pixels[i] != 0) {
        float r = random(0, 255);
        float g = random(0, 255);
        float b = random(0, 255);
        world.pixels[i] = color(r, g, b);
      }
  }
  world.updatePixels();

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
  //ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);
  
  //This sets the variables that move with the kinect to the mouse coordinates which move the ellipse so draw on the map.
  mouseX = int(v2.x);
  mouseY = int(v2.y);

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
  
  //Draws image with new pixel colors. 
  image(world, 0, 0);
  println(frameRate);
  strokeWeight(1);
  //point(mouseX, mouseY);
  //float r = random(0, 255);
  //float g = random(0, 255);
  //float b = random(0, 255);
  //This draws the recursion that is used as the "paint brush."
  stroke(255, 255, 255);
  noFill();
  drawCircle(mouseX * 3, mouseY * 2, 100, 100);
  


  }
//This function draws the recursion that is used as the paint brush seen in the draw function.
void drawCircle(int x, int y, int r, int r2) {
  ellipse(x, y, r, r2);
  if (r > rSize) { 
    drawCircle(x-r/2, y, r/2, r2/2);
    drawCircle(x+r/2, y, r/2, r2/2);
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
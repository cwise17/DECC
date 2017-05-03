// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;

PImage world;
int x, y, r, r2; 
int rSize = 5; 

void setup() {
  size(1920, 1080);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  background(255, 255, 255);
  world = loadImage("worldmap.png");
  int dim = width*height;
  frameRate(20);
  
  
  loadPixels();
  for (int i = 0; i <dim ; i++){
    //println(hex(world.pixels[i]));
      if (pixels[i] != 0) {
         float r = random(0, 255);
         float g = random(0, 255);
         float b = random(0, 255);
         pixels[i] = color(r, g, b);
       }
   }
    updatePixels();


  world.loadPixels();
  for (int i = 0; i <dim ; i++){
      //println(hex(world.pixels[i]));
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
  
  mouseX = int(v2.x);
  mouseY = int(v2.y);

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
    
  image(world, 0, 0);
  println(frameRate);
  strokeWeight(1);
  //point(mouseX, mouseY);
  //float r = random(0, 255);
  //float g = random(0, 255);
  //float b = random(0, 255);
  stroke(255, 255, 255);
  noFill();
  drawCircle(mouseX * 3, mouseY * 2, 100, 100);
  


  }
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
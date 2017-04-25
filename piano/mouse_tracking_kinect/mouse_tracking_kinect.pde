// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.sound.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;
SoundFile soundfile;


void setup() {
  size(1920,1080);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  soundfile = new SoundFile(this, "vibraphon.aiff");  
  soundfile.loop();  
}

void draw() {
  //background(255);

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
  //ellipse(v2.x, v2.y, 20, 20);
  
  mouseX = int(v2.x);
  mouseY = int(v2.y);

  // Display some info
  int t = tracker.getThreshold();
  //fill(0);
  //text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
  //  "UP increase threshold, DOWN decrease threshold", 10, 500);
    
  soundfile.rate(map(mouseX * 3, 0, width, 0.25, 4.0)); 
  
  // Map mouseY from 0.2 to 1.0 for amplitude  
  soundfile.amp(map(mouseY, 0, width, 0.2, 1.0)); 
 
  // Map mouseY from -1.0 to 1.0 for left to right 
  soundfile.pan(map(mouseY, 0, width, -1.0, 1.0));  
  
  fill(0, 0, 0);
  ellipse(mouseX, mouseY, 10, 10);
  println(mouseX + " : " + mouseY);
 
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
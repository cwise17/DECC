// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another classm
KinectTracker tracker;
Kinect kinect;


//Variables for center of ellipse, speed of ellipse, and size of circle. 
int size1; 
int n = 50;
int [] x = new int[n];
int [] y = new int[n];
int [] vx = new int[n];
int [] vy = new int[n];
float d;
int radius;
int mx;
int my;

void setup() {
  size(1920, 1080);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  for (int i = 0; i < x.length; i++) {
  
  float f = random(50,1870); 
  int r = int(f);
  
  x[i] = r;

  f = random(50,1870);
  r = int(f);
  
  y[i] = r;
  
 /* f = random(1,3);
  r = int(f); 
 */
 
  vx[i] = 5;
  vy[i] = 5;
 
  }
  size1 = 100;
  radius = 50;
}

void draw() {
  //int mx = mouseX;
  //int my = mouseY;
  ellipse(mx, my, size1, size1);
  background(10,10,70);
 
  //This array allows there to be an integer i for each ellipse starting at 0, when i is being increased by 1 so that the functions below apply to all ellipses in the above list.
  for (int i = 0; i < x.length; i++) {
    
    //This says that all of the x and y values have a velocity and will move. 
    x[i] = x[i] + vx[i]; 
    y[i] = y[i] + vy[i];
    
    //This says that when all of the y values are greater than or equal to the bottom of the screen, the ellipses will change direction - or velocity becomes negative. 
    if (y[i] >= 1080-50) {
      vy[i] = -vy[i];
      y[i] = 548;
    }
    
   //This changes the direction of the y again, but when it hits the top of the screen.
    if (y[i] <= 50) {
      vy[i] = -vy[i];
      y[i] = 52;
    }
   
    //This changes the direction of the x, but when it hits the right side of the screen.
    if (x[i] >= 1920-50) {
      vx[i] = -vx[i];
      x[i] = 548;
    }
    
    //This changes the direction of the x, but when it hits the left side of the screen.
    if (x[i] <= 50) {
      vx[i] = -vx[i];
      x[i] = 52;
    }
    //MouseX and mouseY positions (final)
    int mx = mouseX;
    int my = mouseY;
    //Previous mouseX and mouseY positions (initial)
    int pmx = pmouseX;
    int pmy = pmouseY;
    //MouseX and mouseY velocity vector (chance in distance (final - initial) over 1 (time))
    int vmx = mx-pmx;
    int vmy = my-pmy; 
    
    ellipse(mx, my, size1, size1);
    ellipse(x[i],y[i],size1,size1);
    d = dist(mx,my,x[i],y[i]);
    
    if (d <= radius + radius) {
      fill(random(255),random(255),random(255),random(255));
      //Changes directions 
      vx[i] = -vx[i];
      vy[i] = -vy[i]; 
     
      
      //Adds velocity
      x[i] = x[i] + vmx;
      y[i] = y[i] + vmy;
      mx = my - vmx;
      my = my - vmy;

    }

  }
  // Run the tracking analysis
  tracker.track();
  // Show the image
  //tracker.display();

  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  //ellipse(v1.x, v1.y, 20, 20);
  


  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(mx, my, size1, size1);
  
  mx = int(v2.x) ;
  my = int(v2.y) ;

  // Display some info
  int t = tracker.getThreshold();
  //fill(0);
  //text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
  //  "UP increase threshold, DOWN decrease threshold", 10, 500);
    


}
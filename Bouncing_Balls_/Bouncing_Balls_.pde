//Variables for center of ellipse, speed of ellipse, and size of circle. 
int size1; 
int n = 5;
int [] x = new int[n];
int [] y = new int[n];
int [] vx = new int[n];
int [] vy = new int[n];
float d;
int radius;


void setup () {
  size(600,600);
 
 
  for (int i = 0; i < x.length; i++) {
  
  float f = random(50,550); 
  int r = int(f);
  
  x[i] = r;

  f = random(50,550);
  r = int(f);
  
  y[i] = r;
  
 /* f = random(1,3);
  r = int(f); 
 */
 
  vx[i] = 3;
  vy[i] = 3;
 
  }
  
  size1 = 100;
  radius = 50; 
}

void draw () {
  background(10,10,70);
  int mx = mouseX;
  int my = mouseY;
  ellipse(mx, my, size1, size1);
  
  //This array allows there to be an integer i for each ellipse starting at 0, when i is being increased by 1 so that the functions below apply to all ellipses in the above list.
  for (int i = 0; i < x.length; i++) {
    
    //This says that all of the x and y values have a velocity and will move. 
    x[i] = x[i] + vx[i]; 
    y[i] = y[i] + vy[i];
    
    //This says that when all of the y values are greater than or equal to the bottom of the screen, the ellipses will change direction - or velocity becomes negative. 
    if (y[i] >= 600-50) {
      vy[i] = -vy[i];
    }
    
   //This changes the direction of the y again, but when it hits the top of the screen.
    if (y[i] <= 50) {
      vy[i] = -vy[i];
    }
   
    //This changes the direction of the x, but when it hits the right side of the screen.
    if (x[i] >= 600-50) {
      vx[i] = -vx[i];
    }
    
    //This changes the direction of the x, but when it hits the left side of the screen.
    if (x[i] <= 50) {
      vx[i] = -vx[i];
    }
      
   
    ellipse(x[i],y[i],size1,size1);
    d = dist(mx,my,x[i],y[i]);
    
    if (d <= radius + radius) {
      fill(random(255),random(255),random(255),random(255));
      vx[i] = -vx[i];
      vy[i] = -vy[i]; 
      x[i] = x[i] + vx[i];
      y[i] = y[i] + vy[i];
    }

}
}
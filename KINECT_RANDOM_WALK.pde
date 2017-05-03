int numwalks = 20; //number of walkers to generate 
Walk [] walks; //list to hold all random walkers

void setup() {
  size(1920, 1080); //Dictates the size of the window
  walks= new Walk [numwalks];
  for (int i = 0; i < numwalks; i++){ //loops thru based on number of walkers I want
    walks[i]=new Walk(960,540); //creates a walker at center of screen
  }
  background(255); //whitebackground 
}

void draw() {
    for (Walk walk : walks){ //runs the walks function for all walkers
        walk.step(); //loops them to change
        walk.display(); //puts them on the screen
    }
  }

class Walk 
{
  int mx;
  int my;
  
  Walk(int x, int y){
    mx = x;
    my = y;
    mouseX = mx; //object this.x = x
    mouseY = my; //object this.y = y
  }

  void display (){
    fill(random(22, 102), random(109, 169), random(179, 259));//Limits the range of color for the ellipses
    ellipse(mx, my, 20, 20); //Point is placed at point this.x, this.y
    //println("DISPLAY:  ", mouseX, mouseY);
  }


  void step() {
    int[] direction = Direction(); //direction is result of Direction function
    float velocity = Velocity(); //velcity is result of Velocity function
    if (pmouseX != mouseX || pmouseY!=mouseY){
      mx=mouseX;
      my=mouseY;
    }
     println("STEP:  ", mx, my);
     println(direction[0],direction[1], velocity);
      
    mx += direction[0] * velocity; //x cord = x cord + direction(x) * velocity
    my += direction[1] * velocity; //y cord = y cord + direction(y) * velocity
    
  

  }
  
  int [] Direction () { //function to retrive direction 
    int n = int (random(9)); //random number between 0 & 9, rounded
    int[] dir = {0,0};
    switch (n){ //based on n, returns one of the cases
        case 0:
          dir[0] = -1;
          dir[1] = -1;
          break;
       case 1:
           dir[0] = -1;
           dir[1] = 0;
           break;
        case 2:
          dir[0] = -1;
          dir[1] = 1;
            break;
        case 3:
          dir[0] = 0;
          dir[1] = -1;
          break;
        case 4:
          dir[0] = 0;
          dir[1] = 0;
          break;
        case 5:
          dir[0] = 0;
          dir[1] = 1;
          break;
        case 6:
          dir[0] = 1;
          dir[1] = -1;
          break;
        case 7:
          dir[0] = 1;
          dir[1] = 0;
          break;
        case 8:
          dir[0] = 1;
          dir[1] = 1;
          break;
    }
    return dir;
  }
  float Velocity () { //function to find step size
    float r=abs(randomGaussian()*3);
    //println(r);
    return r;  
  }
}
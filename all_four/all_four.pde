/*Dylan Levene 
May 9th, 2017
This program puts all four programs together. Just scroll over the program you want to use with the mouse to make it appear. Then click exit to go back to the menu. 
*/

//Creates variable for all the images on the menu.
PImage worldProgram;
PImage pianoProgram;
PImage ballsProgram;
//PImage rwalkProgram;

//This creates a variable 
int state = 0;


void setup(){ 
  size(1920, 1080); 
  //Loads image of world map program.
  worldProgram = loadImage("world.png");
  //pianoProgram = loadImage("piano.png");
  ballsProgram = loadImage("balls.png");
  //rwalkProgram = loadImage("rwalk.png");
  
}

void draw(){ 
  
  //This series of if statements works with the checkLocation function. It uses the information of what state the program is in to determine which program it should run. It does this by running the function called which correlates to the draw function in each respective code.
  if (state == 0) {
    drawMenu();
    //checkLocation();
  }
  
  else if( state == 1){
    drawMap();
  }
  
 /* else if(state == 2){
    drawPiano();
  }
  */
  
  else if(state == 3){
    drawBalls();
  }
 /*
  else if(state == 4){
    drawRwalk();
  }
  */
  //Brings it back to the menu, statement that allows you to "exit" a program.
  else if (state == 5){
    //noLoop();
    state = 0; 
    setup();
    drawMenu();
  }
  textSize(40);
  text("EXIT", 30, 50);
  checkLocation();
} 

//Draws the program for the menu.
void drawMenu() {
  background(255, 255, 255);
  //Draws image of world map program.
  image(worldProgram, 0, 0); 
  //Draws image of piano program.
  image(pianoProgram, 960, 0);
  //Draws image of the bouncing balls program.
  image(ballsProgram, 0, 540);
  //Draws image of the random walk program.
  //image(rwalkProgram, 960, 540);
  
  checkLocation();
}

//Uses the coordinates of the mouse to determine what state the mouse is. This information is used in the if statements in the draw function.
void checkLocation (){
    if (state == 0) {
      //Top left corner, mouse program.
      if (mouseX < 820 && mouseX > 100 && mouseY < 480){
          state = 1;
          setupMap();
      }
      //Bottom right, bouncing balls program.
      else if(mouseX > 1080 && mouseY > 600){
        state = 4;
      }
      //Bottom left, random walk program.
      else if(mouseX < 860 && mouseY > 600){
        state = 3;
      }
    //Top right, piano program.
      else if(mouseX > 1080 && mouseY < 480){
        state = 2;
      }
    }
    else {
    if (mouseX < 100 && mouseY < 540){
    state = 5;
    }
    }
    
} 
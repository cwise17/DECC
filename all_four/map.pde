PImage world;
int xD, yD, r, r2; 
int rSize = 5; 

void setupMap(){
  size(1920, 1080);
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

void drawMap(){
  image(world, 0, 0);
  println(frameRate);
  strokeWeight(1);
  //point(mouseX, mouseY);
  //float r = random(0, 255);
  //float g = random(0, 255);
  //float b = random(0, 255);
  stroke(255, 255, 255);
  noFill();
  drawCircle(mouseX, mouseY, 100, 100);
  
  
}

void drawCircle(int xD, int yD, int r, int r2) {
  ellipse(xD, yD, r, r2);
  if (r > rSize) { 
    drawCircle(xD-r/2, yD, r/2, r2/2);
    drawCircle(xD+r/2, yD, r/2, r2/2);
  }
}
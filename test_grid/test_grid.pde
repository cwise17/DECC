void setup(){
  size(600, 600);
  background(255, 255, 255); 
}

void draw(){
  background(255, 255, 255);
  
  if(mouseX<200){
   
  fill(255, 0, 0);
  rect(0, 0, 200, 600); 
  } else if(mouseX<400){
  fill(0, 255, 0);
  rect(200, 0, 200, 600); 
  } else {
  fill(0, 0, 255);
  rect(400, 0, 200, 600); 
  }
  println(mouseX + " : " + mouseY);
}
 
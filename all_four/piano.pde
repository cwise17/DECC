
import processing.sound.*;

SoundFile soundfile;


void setupPiano() {
  size(1920,1080);

  soundfile = new SoundFile(this, "vibraphon.aiff");  
  soundfile.loop();  
}

void drawPiano() {
  background(255);

  soundfile.rate(map(mouseX, 0, width, 0.25, 4.0)); 
  
  // Map mouseY from 0.2 to 1.0 for amplitude  
  soundfile.amp(map(mouseY, 0, width, 0.2, 1.0)); 
 
  // Map mouseY from -1.0 to 1.0 for left to right 
  soundfile.pan(map(mouseY, 0, width, -1.0, 1.0));  
  
  fill(0, 0, 0);
  ellipse(mouseX, mouseY, 10, 10);
  println(mouseX + " : " + mouseY);
 
  }
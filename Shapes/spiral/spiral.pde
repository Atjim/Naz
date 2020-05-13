// file: spiral.pde
// IMPORTS
import netP5.*;
import oscP5.*;

//----------------------
// VARIABLE DECLARATIONS
//----------------------
float radius = 50; //the radius starts from 50
// Declare colour values using RGB values for corresponding colours
color purple = color(200, 200, 200);
color blue = color(0, 128, 255);
OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address

// Setup Method
void setup() {
  size(600, 600);  // Size init
  background(0);  // Background init
  smooth();
}

// Method Draw
void draw() {
  // Local variables used to facilitate the drawing of the shape
  float x = radius * cos(radius);
  float y = radius * sin(radius);

  // Draws the ellipse(spiral) using the float x,y 
  // Positions said shape at the bottom of the active display window
  noStroke();

  // Makes use of lerpColor function
  // lerpColor function lets the user define two specific colours;
  // said colours cycle between each other explicitly
  // the latter fades to the former and vice-versa
  fill(lerpColor(purple, blue, (millis()%5000)/5000.0));
  ellipse(x+width/2, y+height, 5, 5); 
  OscMessage msg = new OscMessage("/spiral");
  osc.send(msg, supercollider);

  radius += 0.5;  // radius increments by 0.5
}

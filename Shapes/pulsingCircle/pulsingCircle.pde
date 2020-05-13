// file: pulsingCircle.pde

// IMPORTS
import netP5.*;
import oscP5.*;

//----------------------
// VARIABLE DECLARATIONS
//----------------------
int radius = 10;
float speed = 6;
float x = 0;
boolean circleShrink = false;

OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address


// Setup Method
// Circle Size Init
void setup() {
  size(600, 600);
}

// Draw Method
void draw() {
  background(0); // background init
  speed = speed + 0.03; 
  float beat = noise(speed); // pulsing effect implementation

  //Re-maps a number from one range to another
  beat = map(beat, 0, 1, 5, 50);

  //it starts from zero..ends to 400 for the display window. Also there 8 circles
  int [] s = {0, 50, 150, 200, 250, 300, 350, 300}; //each circles size

  // Size Conditions
  if (circleShrink) radius--;  // Redure if shrinking;
  else radius++; // otherwise enlarge and vice-versa

  if (radius == 0 || radius == 80) circleShrink = !circleShrink;   // when ball becomes 0 it grows bigger and when its 50 it shrinks (change it depending on how long u want for the circles to return)
  OscMessage msg = new OscMessage("/pulsingCircle");
  osc.send(msg, supercollider);
  noFill();
  // Colour Definition | Sets the colour using HEX value
  stroke(#FF8000);
  // Alternate colour option | stroke(#FAF147);
  // Alternate colour option | stroke(#4B7A7E);

  // Set the stroke width
  strokeWeight(2);

  // Iteration for object instantiation
  for ( int i = 0; i < s.length; i++) {

    // Creates the circle and centres it in the active window
    ellipse(width/2, height/2, beat + s[i]*radius, beat + s[i]*radius );
  }
}

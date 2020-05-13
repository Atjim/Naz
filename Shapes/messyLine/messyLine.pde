// file: messyLine.pde

// IMPORTS
import netP5.*;
import oscP5.*;

// Contsant Declaration
static int num = 60;
// Variable Declaration
float speed;
OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address

// Setup Method
void setup () {
  size(600, 600); // _ize init
}

// Draw Method
void draw() {
  background(0);
  stroke(0, 128, 255); // Sets the colour of the stroke using RGB value of the desired colour
  strokeWeight(1);   // Sets the stroke width | init
  noFill();
  smooth();

  // Centres object movement position wise in active dispaly window
  translate(width/2, height/2);

  // Iterative function for object instantiation with the facilitation of lines
  for (int i=0; i < num; i++) {
    OscMessage msg = new OscMessage("/messyLine");
    osc.send(msg, supercollider);
    line(x(speed - i), y(speed + i), x(speed + i), y(speed - i));
  }
  speed += 0.5; // speed increment by a factor of 0.5; sets how fast the object moves about
}

// 100 is equal to the distance of the shape from the centre and the x-axis
float x(float s) {
  return sin(s / 10) * 100;
}
// 200 is equal to the distance of the shape from the centre and the y-axis
float y(float s) {
  return cos(s / 20) * 200;
}

// file: coil.pde

// IMPORTS
import netP5.*;
import oscP5.*;


//----------------------
// VARIABLE DECLARATIONS
//----------------------
float duration = 0.1; //fast enough to keep up with the rythm we want
static int lines=3; // circle number/we dont want too many for them to look like they are kinda being absorbed(falling) back
float speed;

OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address

// Setup Method
void setup () {
  size(600, 600); // Size init
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 47120);
}

// Draw Method
void draw() {

  background(#C9C6C3); // background init; sets bg colour to desired colour using HEX value of said colour
  stroke(0);
  strokeWeight(2); // stroke width init
  noFill();

  translate(width/2, height/2);
  rotate(duration*speed); // rotational pattern; moves along the rhythm

  // Iterative function for the addition of circles
  for (int i=0; i < lines; i++) { // add circles
    OscMessage msg = new OscMessage("/coil");
    osc.send(msg, supercollider);
    circle(A(speed + i), A(speed + i), A(speed + i)); // adds circles based on the speed (named the shape A)
  }
  speed += 0.3;  // how fast the object(s) will move; can be changed based on rhythm
}


float A(float speed) {
  return sin(speed / 5) * 50 + sin(speed / 5) * 80;  // Returns to original position and back again; multiplied by 80 to fill active display window(size manipulation)
}

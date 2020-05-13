//this starts forming a pattern and then slowly changes into another pattern so it can be used for more that one rhythm

// IMPORTS
import netP5.*;
import oscP5.*;

float speed=0.0003; //not too fast or slow (based on the colums and rows)
STARMOVEMENT starMovement;
OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address

void setup() {
  size(600, 600);
  starMovement = new STARMOVEMENT();
}

void draw() {
  background(0);
  starMovement.display();
  starMovement.init();
  OscMessage msg = new OscMessage("/movingStars");
  osc.send(msg, supercollider);
  
}

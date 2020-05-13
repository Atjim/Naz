// file: fireworks.pde

// IMPORTS
ParticleSystem ps;
import netP5.*;
import oscP5.*;

//---------------------
// VARIABLE DECLARATION
//---------------------
OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address
// Setup Method
void setup() {
  size(600, 600); // Size init

  ps = new ParticleSystem(random(width), random(height), -3); // Position & Size init; spawns on different position every time

}

// Draw Method
void draw() {
  background(0); // Background init
  OscMessage msg = new OscMessage("/fireworks");
  osc.send(msg, supercollider);

  // CALLS
  ps.display();
  ps.update();
}

// Update Method
void update() {
  ps.shatter();
}

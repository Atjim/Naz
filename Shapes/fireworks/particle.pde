// file: particle.pde

// Class Declaration
class Particle {
  //----------------------
  // VARIABLE DECLARATIONS
  //----------------------
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float r;

  Particle(float x, float y, float r_) { // uses same value as shatter tab
    acceleration = new PVector(0, 0.001);  // shatter speed and movement
    velocity = PVector.random2D();
    velocity.mult(5); // breaking apart speed init
    position = new PVector(x, y);
    r = r_;
  }
  // Run Method
  void run() {
    update();
    display();
  }
  // Update Method; appends position
  void update() { 
    velocity.add(acceleration);
    position.add(velocity);
  }
  // draw the shapes
  void display() {      
    { 
      noStroke();
      fill(random(255), random(255), random(255), random(255));
      rectMode(CENTER);
      rect(position.x, position.y, r, r);
    }
  }
}

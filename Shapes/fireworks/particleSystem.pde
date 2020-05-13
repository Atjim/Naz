// file: fireworks.pde

// Class Declaration
class ParticleSystem {

  //----------------------
  // VARIABLE DECLARATIONS
  //----------------------
  ArrayList<Particle> particles;
  int rows = 20;
  int cols = 20;
  boolean intact = true; // Flag variable

  ParticleSystem(float x, float y, float r) {
    particles = new ArrayList<Particle>();

    for (int i = 0; i < rows*cols; i++) {
      addParticle(x + (i%cols)*r, y + (i/rows)*r, r); // adds & moves particle object based on row & column position & size of initial shape
    }
  }

  // Add Particle Method
  void addParticle(float x, float y, float r) {
    particles.add(new Particle(x, y, r));
  }

  // Display Method
  void display() {
    for (Particle p : particles) {
      p.display(); // display method call
    }
  }

  // Shatter Method
  void shatter() {
  }

  // Update Method
  void update() {
    for (Particle p : particles) {
      p.update(); // update method call
    }
  }
}

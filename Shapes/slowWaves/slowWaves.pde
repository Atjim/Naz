// file: slowWaves.pde

// IMPORTS
import netP5.*;
import oscP5.*;

//----------------------
// VARIABLE DECLARATIONS
//----------------------
int xspacing = 1;   // Space between rects (smaller to be smoother)
int w;              // wave width
int maxwaves = 2;   // number of waves 

float theta = 0.0;
float[] amplitude = new float[maxwaves];   // wave height
float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;                           // Using an array to store height values for the wave (not entirely necessary)
OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address

// Setup Method
void setup() {
  size(600, 600);


  w = width + 20;

  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(15, 30);   // thin waves
    float period = random(300, 200);  // How many pixels before the wave repeats
    dx[i] = (HALF_PI / period) * xspacing;
  }

  yvalues = new float[w/xspacing];
}

// Draw Method
void draw() {
  calcWave();
  renderWave();
  OscMessage msg = new OscMessage("/slowWaves");
  osc.send(msg, supercollider);
}

// Wave Calculate Method
void calcWave() {
  theta += 0.3; // pretty much the movement speed; used in that context


  // Iterative Function; Sets all height values to zero
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 0;
  }

  // Iterative Function; Sets wave height values
  for (int j = 0; j < maxwaves; j++) {
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
      else yvalues[i] += cos(x)*amplitude[j];
      x+=dx[j];
    }
  }
}

// Wave Rendering Method
void renderWave() {
  background(255);                                     // bg init; sets bg colour to desired value
  fill(#1737FF);                                       // fill init; sets fill colour to desired value
  ellipseMode(CENTER);                                 // use tiny circles by centeril ellipse; so its inconspicuous that the shapes are in fact circles
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing, height-600+yvalues[x], 50, 2); // smooth, consecutive waves
  }

  for (int a = 0; a < yvalues.length; a++) {
    ellipse(a*xspacing, height/4+yvalues[a], 50, 2);
  }

  for (int a = 0; a < yvalues.length; a++) {
    ellipse(a*xspacing, height/2+yvalues[a], 50, 2);
  }

  for (int a = 0; a < yvalues.length; a++) {
    ellipse(a*xspacing, height/1.3+yvalues[a], 50, 2);
  }

  for (int a = 0; a < yvalues.length; a++) {
    ellipse(a*xspacing, height+yvalues[a], 50, 2);
  }
}

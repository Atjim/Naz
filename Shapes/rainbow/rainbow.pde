// file: rainbow.pde

// IMPORTS
import netP5.*;
import oscP5.*;

//----------------------
// VARIABLE DECLARATIONS
//----------------------
int xspacing = 1;  // Space between rects (smaller to be smoother)
int w;             // wave width
int maxwaves = 60; // number of waves; increasing this number causes the waves to go closer and form a rainbow
float theta = 0.0;
float[] amplitude = new float[maxwaves];   // wave height
float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;                           // Array to store height values for the wave

OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address

// Setup Method
void setup() {
  size(600, 600);
  w = width + 20;
  
  // Iterative Function
  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(15, 30);   // amplitude init; randomised; not too big of a wave
    float period = random(300, 200); // How many pixels before the wave repetition
    dx[i] = (HALF_PI / period) * xspacing;
  }

  yvalues = new float[w/xspacing];
}

// Draw Method
void draw() {
  background(0);
  calcWave();
  renderWave();
  OscMessage msg = new OscMessage("/rainbow");
  osc.send(msg, supercollider);
}

// Wave Calculation Method
void calcWave() {
  theta += 0.04;  // alters the movement speed of the rainbow


  // Iterative Function; Set all height values to zero
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 0;
  }

  // Iterative Function; Wave height values
  for (int j = 0; j < maxwaves; j++) {
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
      else yvalues[i] += cos(x)*amplitude[j];
      x+=dx[j];
    }
  }
}

// Wave Render Method
void renderWave() {
  background(0); // bg init
  noStroke();
  fill(#FF080C); // fill colour init; sets the colour to the desired colour using HEX value of said colour
  ellipseMode(CENTER);  // centres the ellipse to form a circle
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing, height-600+yvalues[x], 50, 16); // rainbow effect
  }
  fill(#FF9D08);
  for (int a = 0; a < yvalues.length; a++) {
    ellipse(a*xspacing, height/4+yvalues[a], 50, 16);
  }
  fill(#FEFF08);
  for (int a = 0; a < yvalues.length; a++) {
    ellipse(a*xspacing, height/2+yvalues[a], 50, 16);
  }
  fill(#0AFF08);
  for (int a = 0; a < yvalues.length; a++) {
    ellipse(a*xspacing, height/1.3+yvalues[a], 50, 16);
  }
  fill(#080DFF);
  for (int a = 0; a < yvalues.length; a++) {
    ellipse(a*xspacing, height+yvalues[a], 50, 16);
  }
}

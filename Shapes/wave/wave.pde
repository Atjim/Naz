// file: wave.pde
// The following code can be used to achieve various  results

// IMPORTS
import netP5.*;
import oscP5.*;

//----------------------
// VARIABLE DECLARATIONS
//----------------------
int xspacing = 5;   // Space between rects (smaller to be smoother)
int w;              // wave width
int maxwaves = 3;   // number of waves 

float theta = 0.0;
float[] amplitude = new float[maxwaves];   // wave height
float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;    // Using an array to store height values for the wave (not entirely necessary)
OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address

void setup() {
  size(600, 600); // size init
  w = width + 20;

  // Iterative Function
  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(50, 50);   // not too big of a wave
    float period = random(300, 200);  // How many pixels before the wave repeats
    dx[i] = (TWO_PI / period) * xspacing;
  }

  yvalues = new float[w/xspacing];
}

// Draw Method
void draw() {
  background(0);

  // CALLS
  calcWave();
  renderWave();
  OscMessage msg = new OscMessage("/wave");
  osc.send(msg, supercollider);
}


void calcWave() {
  theta += 0.05; // pretty much the speed; used in that context

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

void renderWave() {
  strokeWeight(2); // sets stroke width
  stroke(0); 
  fill(#ED1111); // fill init; sets value to the desired colour
  rectMode(CENTER);  // deired object is a rectange
  for (int x = 0; x < yvalues.length; x++) {
    rect(x*xspacing, height/2+yvalues[x], 50, 16); // positioning; desired spot is for the wave to be in the middle(wide but not too tall)
  }
}

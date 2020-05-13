// file: wavyLine.pde

// IMPORTS
import netP5.*;
import oscP5.*;

// Contstant Declaration
static int num = 30;

//----------------------
// VARIABLE DECLARATIONS
//----------------------
// Declare colour values using RGB values for corresponding colours
color orange = color(255, 128, 0);
color blue = color(0, 128, 255);
float speed;
OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address



// Setup Method
// Size Init
void setup () {
  size(600, 600);
}

// Draw Method
void draw() {
  background(0); // background init

  // Makes use of lerpColor function
  // lerpColor function lets the user define two specific colours;
  // said colours cycle between each other explicitly
  // the latter fades to the former and vice-versa
  stroke(lerpColor(orange, blue, (((millis()/5000)%2==0)?millis()%5000:5000-millis()%5000)/5000.0)); // that way the colour started from the start instead of fading away back 

  // set the stroke width
  strokeWeight(5);
  noFill();

  // Centres object movement position wise in active display window
  translate(width/2, height/2);

  // Iterative function for object instantiation with the facilitation of lines
  for (int i=0; i < num; i++) {
    OscMessage msg = new OscMessage("/wavyLine");
    osc.send(msg, supercollider);
    line(x(speed + i), y(speed + i), x(speed + i), y(speed - i));
  }

  // Movement speed declaration | How fast the object will move about
  speed += 0.3;
}

float x(float s) {
  // 300 is equal to the lenght of the shape from the center of x 
  // 20 is equal to the distance between each wave
  return sin(s /10) * 300 + cos(s/15) * 20;
}

float y(float s) {
  // 30 is equal to the length of the ship from the centre and the y-axis
  // 10 is the equal to the distance between the wave and the ys-axis
  return cos(s / 5) * 30 + sin(s) * 10;
}

// file: rectExchange

// IMPORTS
import netP5.*;
import oscP5.*;

//----------------------
// VARIABLE DECLARATIONS
//----------------------
int value;
OscP5 osc; // osc variable; acts like postal service
NetAddress supercollider; // localhost stream variable; recipient's address

// Setup Method
void setup() {
  size(600, 600); // size init
  value = 10; // frame rate value
  
  frameRate(value);
  rectMode(CENTER);
  background(255); // bg init
}


void draw() {
  background(255); // bg init

  int num = 5; // num init; sets how close/big objects they will be
  int margin = 10; // margin init
  float gutter = 100; // gutter init; distance between each object(cell) 
  float cellsize = ( width - margin - gutter * (num - 1) ) / (num - 1); // let them be named cells 

  int rectNumber = 0; 
  
  // Iterative Function
  for (int i=0; i<num; i++) {
    for (int j=0; j<num; j++) {
      OscMessage msg = new OscMessage("/rectExchange");
      osc.send(msg, supercollider);
      rectNumber = (i * num) + j; 

      float tx = margin + cellsize * i + gutter *i;
      float ty = margin + cellsize * j + gutter * j;

      movingRect(tx, ty, cellsize, rectNumber);
    }
  }
} 

void movingRect(float x, float y, float size, int rectNum) {

  float finalAngle;
  finalAngle = frameCount+ rectNum;

  // Rotating angle for each tempX and tempY postion is affected by frameRate and angle;  
  float tempX = x + (size*2 ) * sin(TWO_PI / value * finalAngle);
  float tempY = y + (size/2) * cos(TWO_PI / value * finalAngle);

  strokeWeight(8); // sets stroke width
  fill(255); // sets fill value
  rect(tempX, tempY, size, size);
}

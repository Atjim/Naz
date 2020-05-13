class Star {

  float x, y;
  float w;
 
  int state;
  
  Star(float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;
    state = int(random(2));
  }


  void display() {
  rotate(frameCount * speed); //adding rotating movement
  noFill();
  strokeWeight(4);
  stroke(random(255), random(255), random(255), random(255)); //random colours on the stroke so the stars are distinctive
  fill(255);
  pushMatrix();
    translate(x,y); //let it start from the upper corner
    beginShape(); //shape a star
    vertex(0, -50);
    vertex(14, -20);
    vertex(47, -15);
    vertex(23, 7);
    vertex(29, 40);
    vertex(0, 25);
    vertex(-29, 40);
    vertex(-23, 7);
    vertex(-47, -15);
    vertex(-14, -20);
    endShape();
    popMatrix();
  }
}

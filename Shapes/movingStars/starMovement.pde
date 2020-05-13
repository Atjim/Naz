class STARMOVEMENT {

  float w = 10;

  int columns, rows;
  
  Star[][] board;


 STARMOVEMENT() {
    columns = 100; //a lot of colums so it doesnt end short
    rows = 5; //not so many rows so it wont get messy
    board = new Star[columns][rows];
    init();
  }

  void init() {
   // adding the stars in the rows and colums
   float h = sin(radians(10))*w;
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
       if (j % 2 == 0) board[i][j] = new Star(i*w*3, j*h,w);
       else board[i][j] = new Star(i*w*3+w+h/2, j*h, w);
      }
    }
  }



 // drawing the stars
  void display() {
    for ( int i = 0; i < columns;i++) {
      for ( int j = 0; j < rows;j++) {
       board[i][j].display();
      }
    }
  }
}

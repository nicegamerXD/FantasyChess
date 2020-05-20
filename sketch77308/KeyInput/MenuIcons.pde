// Give colors for each visual board on menu screen
final color ForrestTheme1 = color ( 238, 130, 238 ); 
final color ForrestTheme2 = color ( 34, 139, 34 );

final color TownTheme1 = color ( 65, 105, 225 ); 
final color TownTheme2 = color ( 255, 165, 0 );

final color CastleTheme1 = color ( 0, 0, 139 ); 
final color CastleTheme2 = color ( 255, 115, 0 );

// -----------------------------------------------------
// -----------------------------------------------------

void Chess1(int offsetX, int offsetY) {
  // show chess
  final int cols = 8;
  final int rows = 8;

  final int sizeRect = 7;
  // Start loop 
  for (int i = 0; i < cols; i++) { 
    // Start loop
    for (int j = 0; j < rows; j++) {

      // Scaling up to draw rectangle at (x,y)
      int x = i*sizeRect; 
      int y = j*sizeRect; 

      noStroke(); // stroke = 0
      fill(ForrestTheme1); // Forrest
      if (x % 2 == 0) {
        if ( y % 2 == 0 ) {
          // Keep forrest
        } 
        else {
          fill(ForrestTheme2);
        }
      }
      else {
        if ( y % 2 == 0 ) {
          fill(ForrestTheme2);
        }
      }
      // For every column and row, a rectangle is drawn at an (x,y) location
      rect(x+offsetX+10, y+offsetY, sizeRect, sizeRect);
    }
  }
}


void Chess2(int offsetX, int offsetY) {
  // show chess
  final int cols = 8;
  final int rows = 8;
  //
  final int sizeRect = 7;
  // Start loop 
  for (int i = 0; i < cols; i++) { 
    // Start loop
    for (int j = 0; j < rows; j++) { 

      // Scaling up to draw rectangle at (x,y)
      int x = i*sizeRect; 
      int y = j*sizeRect; 

      noStroke(); // stroke = 0
      fill(TownTheme1); // Forrest
      if (x % 2 == 0) {
        if ( y % 2 == 0 ) {
          // Keep forrest
        } 
        else {
          fill(TownTheme2);
        }
      }
      else {
        if ( y % 2 == 0 ) {
          fill(TownTheme2);
        }
      }
      // For every column and row, a rectangle is drawn at an (x,y) location
      rect(x+offsetX, y+offsetY, sizeRect, sizeRect);
    }
  }
} 


void Chess3(int offsetX, int offsetY) {
  // show chess
  final int cols = 8;
  final int rows = 8;
  //
  final int sizeRect = 7;
  // Start loop 
  for (int i = 0; i < cols; i++) { 
    // Start loop
    for (int j = 0; j < rows; j++) { 

      // Scaling up to draw rectangle at (x,y)
      int x = i*sizeRect; 
      int y = j*sizeRect; 

      noStroke(); // stroke = 0
      fill(CastleTheme1); // Forrest
      if (x % 2 == 0) {
        if ( y % 2 == 0 ) {
          // Keep forrest
        } 
        else {
          fill(CastleTheme2);
        }
      }
      else {
        if ( y % 2 == 0 ) {
          fill(CastleTheme2);
        }
      }
      // For every column and row, a rectangle is drawn at an (x,y) location
      rect(x+offsetX, y+offsetY, sizeRect, sizeRect);
    }
  }
}

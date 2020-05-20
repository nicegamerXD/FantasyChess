
// for the Menu: class for the Rectangles (buttons)

class Rectangle {

  int x, y, w, h;   // Position and size 
  String textRect="";  // Shown in the button (if in use)
  String textStatusBar=""; // Shown in the status bar (if mouse over)
  int associatedGameIcon = -1; // Which icon / graphical symbol to show 

  // Constructor
  Rectangle( int _x, int _y, 
  int _w, int _h, 
  String _text, 
  String _textStatusBar, 
  int _associatedGameIcon ) {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    textRect=_text;
    textStatusBar=_textStatusBar;
    associatedGameIcon = _associatedGameIcon;
  } // Constructor

  public void outputRect() {
    drawRectText(); 
    drawRect();
    showIconForGame();
  } // outputMethod (With rect output) 

  void showIconForGame() {
    switch (associatedGameIcon) {
    case -1:
      // Be neutral and do nothing basically :/
      break;
    case 0: 
      Chess1(x+30, y+34);
      break;
    case 1: 
      Chess2(x+40, y+40);
      break; 
    case 2: 
      Chess3(x+40, y+40);
      break;
    } // switch
  } // func 

  void drawRect() {
    noFillOrLightColorDependingOnMouseOver();
    stroke(255);
    rect(x, y, w, h);
    // status bar 
    if (overRect()) {
      fill(255);
      textSize(17);      
      textAlign(LEFT);      
      text(textStatusBar, 15, height-15);
    }
  }

  void drawRectText() {
    if (!textRect.equals("")) {
      fill(255);
      textSize(17);      
      textAlign(CENTER);  
      text(textRect, x, y+(h/2)-9, w, h);
    }
  } // method  

  boolean overRect() {
    if (mouseX>x && mouseX<x+w && 
      mouseY>y && mouseY<y+h) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }  
  
  void noFillOrLightColorDependingOnMouseOver() {
    // Shows backgroundcolor when hovering mouse over rects in main menu
    if (overRect()) 
      fill(2, 255, 255, 42);
    else   
      noFill();
  }
}

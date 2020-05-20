final String strConstTitel = "Fantasy Chess";


// states for the program (see tab States)
final int stateWelcomeScreen  = 0; // Menue at the beginning 
final int statePlay           = 1; // playing the game that has beeen chosen
final int statePlay2          = 2;// playing the game that has beeen chosen
final int statePlay3          = 3; // playing the game that has beeen chosen
final int stateLearnMore      = 4; // show help / learn more
final int stateAfterGame      = 5; // after game, before returning to Welcome Screen
// current state 
int state = stateWelcomeScreen;
//
// Games: 
final int chooseGame1 = 0;
final int chooseGame2 = 1;
final int chooseGame3 = 2;
// their names 
final String [] chooseGameName = 
  { 
  "Theme 1: The Forrest", 
  "Theme 2: The Town", 
  "Theme 3: The Castle", 
  "Learn more"
};
final String [] statusText = 
  {
  "Forrest Area", 
  "Town Area", 
  "Castle Area", 
  "Lær at spille spillet."
};
//
// current game
int currentGame = chooseGame1;
//
// the initial Main Menu
int textXPos;
int textXPosB;
int learnPos; 
int[] textYPos = { 
  220, 
  380, 
  540, 
  690
};
// rectangles as buttons for main menu 
Rectangle rectButtonBoard1; 
Rectangle rectButtonBoard2; 
Rectangle rectButtonBoard3;
Rectangle rectLearnmore; 

// ========================================================================================================


public void settings() {
  size (900, 800 );
}

void setup () {

  // Value class Rectangle
  textXPos = width/2-400;
  textXPosB = width/2-250;
  learnPos = textXPosB+400;

  // Object class Rectangle
  rectButtonBoard1 = new Rectangle(textXPosB, textYPos[0], 500, 145, chooseGameName[0], statusText[0], 0);
  rectButtonBoard2 = new Rectangle(textXPosB, textYPos[1], 500, 145, chooseGameName[1], statusText[1], 1);
  rectButtonBoard3 = new Rectangle(textXPosB, textYPos[2], 500, 145, chooseGameName[2], statusText[2], 2);  
  rectLearnmore    = new Rectangle(learnPos, textYPos[3], 100, 25, chooseGameName[3], statusText[3], -1);

  noStroke();
  textSize(width/8);
  textAlign(CENTER);
  
  Flag = loadImage("FlagOfHyrule.jpg");
  BG = loadImage("ChessBG.png");
  Flag.resize(width, height);
  BG.resize(width, height);
  forrest = loadImage("forrest.jpg");
  town = loadImage("town.jpg");
  castle = loadImage("castle.jpg");

  wKing = loadImage("wCrown.png");
  bKing = loadImage("bCrown.png");
  wRoyalKnight = loadImage("wRoyalKnight.png");
  bRoyalKnight = loadImage("bRoyalKnight.png");
  wSword = loadImage("wSword.png");
  bSword = loadImage("bSword.png");
  wCavalry = loadImage("wCavalry.png");
  bCavalry = loadImage("bCavalry.png");
  wKnight = loadImage("wKnight.png");
  bKnight = loadImage("bKnight.png");
  wBowMen = loadImage("wBow.png");
  bBowMen = loadImage("bBow.png");
  wKing.resize(width/8, height/8);
  bKing.resize(width/8, height/8);
  wRoyalKnight.resize(width/8, height/8);
  bRoyalKnight.resize(width/8, height/8);
  wSword.resize(width/8, height/8);
  bSword.resize(width/8, height/8);
  wCavalry.resize(width/8, height/8);  
  bCavalry.resize(width/8, height/8); 
  wKnight.resize(width/8, height/8);
  bKnight.resize(width/8, height/8);
  wBowMen.resize(width/8, height/8);  
  bBowMen.resize(width/8, height/8);

  startPosition();
}

void draw () {
  background(BG);
  // see tab States for handling the states
  noStroke();
  textSize(width/8);
  textAlign(CENTER);

  switch (state) {
  case stateWelcomeScreen:
    handleStateShowWelcomeScreen();
    break;
  case statePlay:
    showBoard();

    tint(100, 50);
    image(forrest, 0, 0);

    tint(255, 255);

    if (gameOver) {
      fill(0, 255, 0);
      if (check) text("CHECKMATE", 0, height/2, width, height);
      else text("STALEMATE", 0, height/2, width, height);
    }
    handleStatePlay();
    break;

  case statePlay2:
    showBoard2();

    tint(100, 50);
    image(town, 0, 0);
    tint(255, 255);

    if (gameOver) {
      fill(0, 255, 0);
      if (check) text("CHECKMATE", 0, height/2, width, height);
      else text("STALEMATE", 0, height/2, width, height);
    }
    handleStatePlay();
    break;

  case statePlay3:
    showBoard3();

    tint(100, 100);
    image(castle, 0, 0);
    castle.resize(width, height);
    tint(255, 255);

    if (gameOver) {
      fill(0, 255, 0);
      if (check) text("CHECKMATE", 0, height/2, width, height);
      else text("STALEMATE", 0, height/2, width, height);
    }
    handleStatePlay();
    break;

  case stateLearnMore:
    handleStateLearnMore();
    break;
  case stateAfterGame:
    handleStateAfterGame();
    break;
  default:
    // error 
    println("Unknown State (Error 33 in main tab): " 
      + state
      + ".");
    exit();
    break;
  } // switch
} // func 
//

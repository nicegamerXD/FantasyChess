void mousePressed() {
  // Define gamOver with startPosition reset
  if (gameOver) startPosition();
  
  //Define pormote function for the swords to either:
  //  RoyalKnight
  //  Cavalry
  //  BowMen
  //  Knight
  if (promote) {
    int x = round(mouseX/ (width/4)-0.5);
    if (!turn == WHITE) {
      if (x == 0) board[down1][right1] = wRoyalKnight;
      if (x == 1) board[down1][right1] = wCavalry;
      if (x == 2) board[down1][right1] = wBowMen;
      if (x == 3) board[down1][right1] = wKnight;
    } else {
      if (x == 0) board[down1][right1] = bRoyalKnight;
      if (x == 1) board[down1][right1] = bCavalry;
      if (x == 2) board[down1][right1] = bBowMen;
      if (x == 3) board[down1][right1] = bKnight;
    }
    promote = false;
    check = false;
    if (Check(turn, board)) {//King under attack
      check = true;
    }
    if (CheckMate(turn)) {//King locked and defeated
      gameOver = true;
    }
  } else if (click) {
    down1 = round(mouseY / (height/8)-0.5);
    right1 = round(mouseX / (width/8)-0.5);
    if (validMove(down, right, down1, right1, turn, board) && !incheck(down, right, down1, right1, turn)) {
      check = false;// Remove visual "check"
      board = movePiece(down, right, down1, right1, true, board);// Movement allowed
      click = false;
    } else {// Change piece allowed
      down = down1;
      right = right1;
      click = true;
    }
  } else {
    down = round(mouseY / (height/8)-0.5);
    right = round(mouseX / (width/8)-0.5);
    click = true;
  }

  switch (state) {
  case stateWelcomeScreen:
    mousePressedStateWelcomeScreen();
    break;
  case statePlay:
    mousePressedStatePlay();
    break;

  case statePlay2:
    mousePressedStatePlay();
    break;

  case statePlay3:
    mousePressedStatePlay();
    break;

  case stateLearnMore:
    state = stateWelcomeScreen;
    break;
  case stateAfterGame:
    state = stateWelcomeScreen;
    break;  
  default:
    println("Unknown State (Error 18 in tab InputMouse): " 
      + state+ ".");
    exit();
    break;
  } // Switch states
}


// ----------------------------------------------------------------------------

void mousePressedStateWelcomeScreen() {
  // Mouse pressed in state Welcome Screen / Main Screen.
  // Define the 3 main buttons and the "Learn more" button
  if (rectButtonBoard1.overRect()) {
    currentGame = chooseGame1;    
    state = statePlay;
  } else if (rectButtonBoard2.overRect()) {
    currentGame = chooseGame2;    
    state = statePlay2;
  } else if (rectButtonBoard3.overRect()) {
    currentGame = chooseGame3;    
    state = statePlay3;
  } else if (rectLearnmore.overRect()) {
    printLearnMore();
    state = stateLearnMore;
  } else {
    // Pause
  }
} //Stop

void mousePressedStatePlay() {
  // Gamelogic for the mouse under StatePlay, StatePlay2 and StatePlay3
  // CurrentGame defined
  switch (currentGame) {
  case chooseGame1:
    state = statePlay;
    break;
  case chooseGame2:
    state = statePlay2;
    break;
  case chooseGame3:
    state = statePlay3;
    break;
  default:
    println ("Error 66 in tab InputMouse for currentGame with "
      + currentGame);
    exit();
    break;
  } // switch
}
//

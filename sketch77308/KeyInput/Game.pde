int down, right, down1, right1;//curr move, (down, right)starting pos   (down1,right1)ending pos
int p0, p1, p01, p11;// Prev move, for the Chess move ("En Passant")
boolean click;// First click select piece, second click moves piece
boolean WHITE = true;
boolean BLACK = false;
boolean turn;//player turn
boolean gameOver;
boolean wKingMoved, bKingMoved, wRookMoved1, bRookMoved1, wRookMoved2, bRookMoved2;// Needed for castling
boolean check;// If in check
boolean promote; //If fodfolk condition met
PImage forrest, town, castle, BG, Flag, wKing, bKing, wRoyalKnight, bRoyalKnight, wSword, bSword, wCavalry, bCavalry, wKnight, bKnight, wBowMen, bBowMen;
PImage[][] board;

// -----------------------------------------------------
// -----------------------------------------------------
// -----------------------------------------------------

void MainProgram() {
  // Game chosen = handleGame1-3.

  switch (currentGame) {
  case chooseGame1:
    handleGame1();
    break;
  case chooseGame2:
    handleGame2();
    break;
  case chooseGame3:
    handleGame3();
    break;
  default:
    // error 
    println ("Error 17 in tab Play (unknown currentGame) with "
      + currentGame 
      + ".");
    exit();
    break;
  } // Function run
} //  Stop

// ------------------------------------------------------
// ------------------------------------------------------

//Given current states and conditions after game is over
void handleGame1() {
  if (gameOver == true) {
    state = stateAfterGame;
  }
}

void handleGame2() {
  if (gameOver == true) {
    state = stateAfterGame;
  }
}

void handleGame3() {
  if (gameOver == true) {
    state = stateAfterGame;
  }
}

// ------------------------------------------------------
// ------------------------------------------------------
// ------------------------------------------------------

// Chess game logic from here to the buttom.
void startPosition() {
  //Show startposition and use as function.

  board = new PImage[8][8];

  board[0][5] = bCavalry;
  board[0][0] = bKnight;
  board[0][6] = bBowMen;
  board[0][3] = bRoyalKnight;
  board[0][4] = bKing;
  board[0][1] = bBowMen;
  board[0][7] = bKnight;
  board[0][2] = bCavalry;
  board[1][0] = bSword;
  board[1][1] = bSword;
  board[1][2] = bSword; 
  board[1][3] = bSword;
  board[1][4] = bSword;
  board[1][5] = bSword;
  board[1][6] = bSword;
  board[1][7] = bSword;

  board[7][5] = wCavalry;
  board[7][0] = wKnight;
  board[7][6] = wBowMen;
  board[7][4] = wRoyalKnight;
  board[7][3] = wKing;
  board[7][1] = wBowMen;
  board[7][7] = wKnight;
  board[7][2] = wCavalry;
  board[6][0] = wSword;
  board[6][1] = wSword;
  board[6][2] = wSword;
  board[6][3] = wSword;
  board[6][4] = wSword;
  board[6][5] = wSword;
  board[6][6] = wSword;
  board[6][7] = wSword;

  // Global variables
  down=right=down1=right1=-1;
  p0=p1=p01=p11=-1;
  click = false;
  turn = WHITE;
  gameOver = false;
  wKingMoved = false;
  bKingMoved = false;
  wRookMoved1 = false;
  bRookMoved1 = false;
  wRookMoved2 = false;
  bRookMoved2 = false;
  check = false;
  promote = false;
}

// Check function to check the King
boolean Check(boolean side, PImage[][] Board) {
  int i, j = 0;
  boolean b = false;

  for (i = 0; i<8; i++) {
    for (j = 0; j<8; j++) {
      if (side == WHITE) {
        if (Board[i][j] == wKing) { 
          b = true;
          break;
        }
      } else {
        if (Board[i][j] == bKing) { 
          b = true;
          break;
        }
      }
    }
    if (b == true) {
      break;
    }
  }
  for (int k = 0; k<8; k++) {
    for (int l = 0; l<8; l++) {
      if (side == WHITE) {
        if (notBlack(l, k, Board))
          continue;
      } else if (notWhite(l, k, Board)) {
        continue;
      }
      if (validMove(l, k, i, j, !side, Board)) return true;
    }
  }
  return false;
}


boolean incheck(int down, int right, int down1, int right1, boolean side) {
  PImage[][] updateBoard = new PImage[8][8];
  for (int i = 0; i<8; i++)
    for (int j = 0; j<8; j++) 
      updateBoard[i][j] = board[i][j];
  updateBoard = movePiece(down, right, down1, right1, false, updateBoard);

  if (Check(side, updateBoard)) {
    return true;
  }
  return false;
}

boolean CheckMate(boolean side) {//no valid moves
  for (int k = 0; k<8; k++) {
    for (int l = 0; l<8; l++) {
      if (side == WHITE) {
        if (notWhite(l, k, board))
          continue;
      } else if (notBlack(l, k, board)) {
        continue;
      }
      for (int i = 0; i<8; i++) {
        for (int j = 0; j<8; j++) {
          if (validMove(l, k, i, j, side, board) && !incheck(l, k, i, j, side)) return false;
        }
      }
    }
  }
  return true;
}

boolean possible(int down, int right, int down1, int right1, int d, int r, boolean side, PImage[][] Board) {
  for (int i = right + r, j  = down + d; i < 8 && j < 8 && i >= 0 && j >= 0; i+= r, j+= d) {
    if (side == WHITE) {
      if (white(j, i, Board)) break;//once diagon reaches white
      if (black(j, i, Board)) {//once diagon reaches black
        if (i == right1 && j == down1)return true;//kill first black
        break;
      }
    } else {
      if (black(j, i, Board)) break;//once direction reaches black
      if (white(j, i, Board)) {//once direction reaches white
        if (i == right1 && j == down1)return true;//kill first white
        break;
      }
    }
    if (i == right1 && j == down1)return true;
  }
  return false;
}


boolean black (int down1, int right1, PImage[][] Board) {
  return (Board[down1][right1] == bRoyalKnight || Board[down1][right1] == bKnight || Board[down1][right1] == bSword || 
    Board[down1][right1] == bCavalry || Board[down1][right1] == bBowMen || Board[down1][right1] == bKing);
}

boolean white (int down1, int right1, PImage[][] Board) {
  return (Board[down1][right1] == wRoyalKnight || Board[down1][right1] == wKnight || Board[down1][right1] == wSword || 
    Board[down1][right1] == wCavalry || Board[down1][right1] == wBowMen || Board[down1][right1] == wKing);
}

boolean notBlack (int down1, int right1, PImage[][] Board) {
  return (white(down1, right1, Board) || Board[down1][right1] ==null);
}

boolean notWhite (int down1, int right1, PImage[][] Board) {
  return (black(down1, right1, Board) || Board[down1][right1] ==null);
}

// -----------------------------------------------------
// -----------------------------------------------------
// -----------------------------------------------------

// Entire code of available moves from each piece on the white and black side.
boolean validMove(int down, int right, int up, int left, boolean side, PImage[][] Board) {
  if (side == WHITE) {//white
    if (Board[down][right] == wSword && !promote) {
      if (left == right && up == down-1 && Board[down-1][right] == null) { // move forward 1
        return true;
      } else if (left == right && up == down-2) {// move forward 2
        if (down == 6 && Board[down-1][right] == null && Board[down-2][right] == null) {
          return true;
        }
      }
      if (right != 7) {//take enemy
        if (black(down-1, right+1, Board)) {
          if (up == down-1 && left == right +1) return true;
        }
        if (down == 3 && Board[p01][p11] == bSword && p01 == p0 + 2 && p1 == right + 1) {// If out of bounds. Check NullpointerException.
          if (up == down-1 && left == right +1) return true;
        }
      }
      if (right != 0) {//take enemy
        if (black(down-1, right-1, Board)) {
          if (up == down-1 && left == right -1) return true;
        }
        if (down == 3 && Board[p01][p11] == bSword && p01 == p0 + 2 && p1 == right - 1) {// If out of bounds. Check NullpointerException.
          if (up == down-1 && left == right - 1) return true;
        }
      }
    } else if (Board[down][right] == wKing) {
      if (abs(right - left) <= 1 && abs(down - up) <= 1) {// Move forward
        if (notWhite(up, left, Board)) {
          return true;
        }
      }
      if (!wKingMoved && !check) {//castle
        if (Board[7][3] == null && Board[7][2] == null && Board[7][1] == null &&
          up == 7 && left == 2 && wRookMoved1 == false) {
          if (!incheck(down, right, 7, 3, turn)) {
            return true;
          }
        }
        if (Board[7][5] == null && Board[7][6] == null &&
          up == 7 && left == 6 && wRookMoved2 == false) {
          if (!incheck(down, right, 7, 5, turn)) {
            return true;
          }
        }
      }
    } else if (Board[down][right] == wKnight) {
      if ((abs(up - down) == 2 && abs(left - right) == 2) ||
        (abs(up - down) == 1 && abs(left - right) == 2)) {
        if (notWhite(up, left, Board)) return true;
      }
    } else if (Board[down][right] == wBowMen) {      
      if (possible(down, right, up, left, 1, 1, WHITE, Board)) return true;// Bottom right
      if (possible(down, right, up, left, 1, -1, WHITE, Board)) return true;// Top right
      if (possible(down, right, up, left, -1, 1, WHITE, Board)) return true;// Bottom left
      if (possible(down, right, up, left, -1, -1, WHITE, Board)) return true;// Top left
    } else if (Board[down][right] == wCavalry) {
      if (possible(down, right, up, left, 0, 1, WHITE, Board)) return true;// Right
      if (possible(down, right, up, left, 0, -1, WHITE, Board)) return true;// Left
      if (possible(down, right, up, left, 1, 0, WHITE, Board)) return true;// Down
      if (possible(down, right, up, left, -1, 0, WHITE, Board)) return true;// Up
    } else if (Board[down][right] == wRoyalKnight) {
      if (possible(down, right, up, left, 1, 1, WHITE, Board)) return true;// Bottom right
      if (possible(down, right, up, left, -1, 1, WHITE, Board)) return true;// Top right
      if (possible(down, right, up, left, 1, -1, WHITE, Board)) return true;// Bottom left
      if (possible(down, right, up, left, -1, -1, WHITE, Board)) return true;// Top left
      if (possible(down, right, up, left, 0, 1, WHITE, Board)) return true;// Right
      if (possible(down, right, up, left, 0, -1, WHITE, Board)) return true;// Left
      if (possible(down, right, up, left, 1, 0, WHITE, Board)) return true;// Down
      if (possible(down, right, up, left, -1, 0, WHITE, Board)) return true;// Up
    }
  } else {
    if (Board[down][right] == bSword && !promote) {
      if (left == right && up == down+1 && Board[down+1][right] == null) { // Move forward 1
        return true;
      } else if (left == right && up == down+2) {// move forward 2
        if (down == 1 && Board[down+1][right] == null && Board[down+2][right] == null) {
          return true;
        }
      }
      if (right != 7) {//take
        if (white(up, left, Board)) {
          if (up == down+1 && left == right + 1) return true;
        }
        if (down == 4 && Board[p01][p11] == wSword && p01 == p0 - 2 && p1 == right + 1) {// Pawn takes passerby (Move called "En Passant")
          if (up == down+1 && left == right + 1) return true;
        }
      }
      if (right != 0) {//take
        if (white(up, left, Board)) {
          if (up == down+1 && left == right - 1) return true;
        }
        if (down == 4 && Board[p01][p11] == wSword && p01 == p0 - 2 && p1 == right - 1) {// Pawn takes passerby (Move called "En Passant")
          if (up == down+1 && left == right - 1) return true;
        }
      }
    } else if (Board[down][right] == bKing) {
      if (abs(right - left) <= 1 && abs(down - up) <= 1) {
        if (notBlack(up, left, Board)) {
          return true;
        }
      }
      if (!bKingMoved && !check) {
        if (Board[0][3] == null && Board[0][2] == null && Board[0][1] == null &&
          Board[0][0] == bCavalry && up == 0 && left == 2) {
          if (!incheck(down, right, 0, 3, turn)) {
            return true;
          }
        }
        if (Board[0][5] == null && Board[0][6] == null &&
          Board[0][7] == bCavalry && up == 0 && left == 6) {
          if (!incheck(down, right, 0, 5, turn)) {
            return true;
          }
        }
      }
    } else if (Board[down][right] == bKnight) {
      if ((abs(up - down) == 2 && abs(left - right) == 2) ||
        (abs(up - down) == 1 && abs(left - right) == 2)) {
        if (notBlack(up, left, Board)) return true;
      }
    } else if (Board[down][right] == bBowMen) {     
      if (possible(down, right, up, left, 1, 1, BLACK, Board)) return true;// Bottom right
      if (possible(down, right, up, left, 1, -1, BLACK, Board)) return true;// Top right
      if (possible(down, right, up, left, -1, 1, BLACK, Board)) return true;// Bottom left
      if (possible(down, right, up, left, -1, -1, BLACK, Board)) return true;// Top left
    } else if (Board[down][right] == bCavalry) {
      if (possible(down, right, up, left, 0, 1, BLACK, Board)) return true;// Right
      if (possible(down, right, up, left, 0, -1, BLACK, Board)) return true;// Left
      if (possible(down, right, up, left, 1, 0, BLACK, Board)) return true;// Down
      if (possible(down, right, up, left, -1, 0, BLACK, Board)) return true;// Up
    } else if (Board[down][right] == bRoyalKnight) {
      if (possible(down, right, up, left, 1, 1, BLACK, Board)) return true;// Bottom right
      if (possible(down, right, up, left, -1, 1, BLACK, Board)) return true;// Top right
      if (possible(down, right, up, left, 1, -1, BLACK, Board)) return true;// Bottom left
      if (possible(down, right, up, left, -1, -1, BLACK, Board)) return true;// Top left
      if (possible(down, right, up, left, 0, 1, BLACK, Board)) return true;// Right
      if (possible(down, right, up, left, 0, -1, BLACK, Board)) return true;// Left
      if (possible(down, right, up, left, 1, 0, BLACK, Board)) return true;// Down
      if (possible(down, right, up, left, -1, 0, BLACK, Board)) return true;// Up
    }
  }
  return false;
}
PImage[][] movePiece(int i0, int j0, int i1, int j1, boolean update, PImage[][] Board) {
  if (update) {
    p0 = i0; 
    p1 = j1; 
    p01 = i1; 
    p11 = j1;// previous move
  }
  if (Board[i0][j0] == wSword) {
    if (i1 == 0) {
      if (update) promote = true;
    } else if (i1 == 2 && abs(j1 - j0) == 1 && Board[i1][j1] == null) {// pawn takes passerby (Move called "En Passant")
      Board[i1 + 1][j1] = null;
    }
  } else if (Board[i0][j0] == bSword) {//promote black pawn
    if (i1 == 7) {
      if (update) promote = true;
    } else if (i1 == 5 && abs(j1 - j0) == 1 && Board[i1][j1] == null) {// pawn takes passerby. (Move called "En passant")
      Board[i1 - 1][j1] = null;
    }
  } else if (Board[i0][j0] == wKing) {
    if (wKingMoved == false && j1 == 2) {//cavalry
      Board[7][0] = null;
      Board[7][3] = wCavalry;
    }
    if (wKingMoved == false && j1 == 6) {//cavalry
      Board[7][7] = null;
      Board[7][5] = wCavalry;
    }
    if (update)wKingMoved = true;
  } else if (Board[i0][j0] == bKing) {
    if (bKingMoved == false && j1 == 2) {
      Board[0][0] = null;
      Board[0][3] = bCavalry;
    }
    if (bKingMoved == false && j1 == 6) {
      Board[0][7] = null;
      Board[0][5] = bCavalry;
    }
    if (update)bKingMoved = true;
  } else if (Board[i0][j0] == wCavalry) {
    if (update) {
      if (!wRookMoved1 && j0 == 0) wRookMoved1 = true;
      if (!wRookMoved2 && j0 == 7) wRookMoved2 = true;
    }
  } else if (Board[i0][j0] == bCavalry) {
    if (update) {
      if (!bRookMoved1 && j0 == 0) bRookMoved1 = true;
      if (!bRookMoved2 && j0 == 7) bRookMoved2 = true;
    }
  }
  Board[i1][j1] = Board[i0][j0];// Move piece
  Board[i0][j0] = null;// Remove original piece

  if (update) {
    if (Check(!turn, Board)) {// King under attack
      check = true;
    }
    if (CheckMate(!turn)) {// No allowed moves
      gameOver = true;
    }
    turn = !turn;
  }
  return Board;
}

// These are the 3 different, yet same boards that are used to place the pieces on.
void showBoard() {
  for (int i = 0; i<8; i++)
    for (int j = 0; j<8; j++) { 
      if ((i+j)%2 == 0) fill(238, 130, 208);
      else fill(34, 139, 34);
      rect(i*width/8, j*height/8, width/8, height/8);// Chessboard
      if (board[j][i] != null) image(board[j][i], i*width/8, j*height/8);// Pieces
      if (click) {
        // Shows yellow highlighted for allowed movement
        if (validMove(down, right, j, i, turn, board) && !incheck(down, right, j, i, turn)) {
          fill(#FFFF00, 130);
          rect(i*width/8, j*height/8, width/8, height/8);
        }
        // Shows blue highlight for targeted piece
        if (j == down && i == right && board[j][i] != null) {
          fill(#2E64FE, 130);
          rect(i*width/8, j*height/8, width/8, height/8);
        }
      }
    }

  // Simply shows "Check" when conditions are fulfilled
  if (check && !gameOver && !promote) {
    fill(255, 0, 255);
    text("CHECK", 0, height/2, width, height);
  }
  if (promote && !gameOver) {
    stroke(2);
    fill(200, 100);
    rect(0, 0, 2*width/8, height);
    rect(2*width/8, 0, 2*width/8, height);
    rect(4*width/8, 0, 1*width/8, height);
    rect(6*width/8, 0, 2*width/8, height);
    if (!turn) {
      image(wRoyalKnight, 0.5*width/8, 3.5*height/8);
      image(wCavalry, 2.5*width/8, 3.5*height/8);
      image(wBowMen, 4.5*width/8, 3.5*height/8);
      image(wKnight, 6.5*width/8, 3.5*height/8);
    } else {
      image(bRoyalKnight, 0.5*width/8, 3.5*height/8);
      image(bCavalry, 2.5*width/8, 3.5*height/8);
      image(wBowMen, 4.5*width/8, 3.5*height/8);
      image(bKnight, 6.5*width/8, 3.5*height/8);
    }
    noStroke();
  }
}

void showBoard2() {
  for (int i = 0; i<8; i++)
    for (int j = 0; j<8; j++) { 
      if ((i+j)%2 == 0) fill(65, 105, 225);
      else fill(255, 165, 0);
      rect(i*width/8, j*height/8, width/8, height/8);// Chessboard
      if (board[j][i] != null) image(board[j][i], i*width/8, j*height/8);// Pieces
      if (click) {
        // Viser gyldige ryk med gul
        if (validMove(down, right, j, i, turn, board) && !incheck(down, right, j, i, turn)) {
          fill(#FFFF00, 130);
          rect(i*width/8, j*height/8, width/8, height/8);
        }
        // Shows yellow highlighted for allowed movement
        if (j == down && i == right && board[j][i] != null) {
          fill(#2E64FE, 130);
          rect(i*width/8, j*height/8, width/8, height/8);
        }
      }
    }

  // Simply shows "Check" when conditions are fulfilled
  if (check && !gameOver && !promote) {
    fill(255, 255, 0);
    text("CHECK", 0, height/2, width, height);
  }
  if (promote && !gameOver) {
    stroke(2);
    fill(200, 100);
    rect(0, 0, 2*width/8, height);
    rect(2*width/8, 0, 2*width/8, height);
    rect(4*width/8, 0, 1*width/8, height);
    rect(6*width/8, 0, 2*width/8, height);
    if (!turn) {
      image(wRoyalKnight, 0.5*width/8, 3.5*height/8);
      image(wCavalry, 2.5*width/8, 3.5*height/8);
      image(wBowMen, 4.5*width/8, 3.5*height/8);
      image(wKnight, 6.5*width/8, 3.5*height/8);
    } else {
      image(bRoyalKnight, 0.5*width/8, 3.5*height/8);
      image(bCavalry, 2.5*width/8, 3.5*height/8);
      image(wBowMen, 4.5*width/8, 3.5*height/8);
      image(bKnight, 6.5*width/8, 3.5*height/8);
    }
    noStroke();
  }
}

void showBoard3() {
  for (int i = 0; i<8; i++)
    for (int j = 0; j<8; j++) { 
      if ((i+j)%2 == 0) fill(0, 0, 139);
      else fill(255, 115, 0 );
      rect(i*width/8, j*height/8, width/8, height/8);// Chessboard
      if (board[j][i] != null) image(board[j][i], i*width/8, j*height/8);// Pieces
      if (click) {
        // Shows yellow highlighted for allowed movement
        if (validMove(down, right, j, i, turn, board) && !incheck(down, right, j, i, turn)) {
          fill(#FFFF00, 130);
          rect(i*width/8, j*height/8, width/8, height/8);
        }
        // Shows blue highlight for targeted piece
        if (j == down && i == right && board[j][i] != null) {
          fill(#2E64FE, 130);
          rect(i*width/8, j*height/8, width/8, height/8);
        }
      }
    }

  // Simply shows "Check" when conditions are fulfilled
  if (check && !gameOver && !promote) {
    fill(0, 255, 255);
    text("CHECK", 0, height/2, width, height);
  }
  if (promote && !gameOver) {
    stroke(2);
    fill(200, 100);
    rect(0, 0, 2*width/8, height);
    rect(2*width/8, 0, 2*width/8, height);
    rect(4*width/8, 0, 1*width/8, height);
    rect(6*width/8, 0, 2*width/8, height);
    if (!turn) {
      image(wRoyalKnight, 0.5*width/8, 3.5*height/8);
      image(wCavalry, 2.5*width/8, 3.5*height/8);
      image(wBowMen, 4.5*width/8, 3.5*height/8);
      image(wKnight, 6.5*width/8, 3.5*height/8);
    } else {
      image(bRoyalKnight, 0.5*width/8, 3.5*height/8);
      image(bCavalry, 2.5*width/8, 3.5*height/8);
      image(wBowMen, 4.5*width/8, 3.5*height/8);
      image(bKnight, 6.5*width/8, 3.5*height/8);
    }
    noStroke();
  }
}

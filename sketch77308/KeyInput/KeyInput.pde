void keyPressed() {
  
  // Depending on the state choose keyPressed
  // routine from specifik chosen state
  switch (state) {
  case stateWelcomeScreen:
    keyPressedstateWelcomeScreen();
    break;
  case statePlay:
    keyPressedstateWelcomeScreen();
    // Pause
    break;

  case statePlay2:
    keyPressedstateWelcomeScreen();
    // Pause
    break;

  case statePlay3:
    keyPressedstateWelcomeScreen();
    // Pause
    break;
  case stateLearnMore:
    // Pause
    break;
  case stateAfterGame:
    keyPressedstateWelcomeScreen();
    // Pause
    break;  
  default:
    println("Unknown State (Error 23 in tab InputKey): " + state+ ".");
    exit();
    break;
  } // switch

  if (key == 'r' || key == 'R') {
    startPosition();
  }
} // func 
//
void keyPressedstateWelcomeScreen() {
  if (keyPressed) {
    if (key == 'h' || key == 'H') {
      state = stateWelcomeScreen;
    }
  }
  // Pause
}
// Stop

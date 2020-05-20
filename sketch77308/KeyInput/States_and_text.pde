
// Program states

void handleStateShowWelcomeScreen() {

  // Shows the main menu with main game buttons 

  // Headline settings
  fill(255);  
  textSize(32);
  textAlign(CENTER);
  text (strConstTitel, width/2, 40);
  
  // Text under headline
  textSize(19);
  textAlign(LEFT);
  text ("Velkommen til fantasy chess vælg en af de 3 skakbræt nedenunder.. ", textXPos, 80);
  text ("Dette spil har 3 forskellige steder inkluderet i dets spilleform.", textXPos, 80+30);
  text ("Læs nedenunder for at se mulighederne.", textXPos, 80+30+30);
  text ("For at du kan spille spillet, vælg én af temaerne nedenunder.", textXPos, 80+30+30+30);    
  text ("Klik på *Learn More* under de 3 skak områder for mere info ", textXPos, 80+30+30+30+30);


  // 1st game option
  rectButtonBoard1.outputRect(); 
  // 2nd game option 
  rectButtonBoard2.outputRect(); 
  // 3rd game option 
  rectButtonBoard3.outputRect(); 
  // learn more option
  rectLearnmore.outputRect();
  
}

void handleStatePlay() {
  
  MainProgram();
}

void handleStateLearnMore() {
  
  textLearnMoreOnScreen();
}

void handleStateAfterGame() {
  // After a game:
  // Wait for mousePressed 
  // to go to the Welcome Screen again. 
  background(Flag);
  // Headline 
  fill(255);  
  textSize(32);
  textAlign(CENTER);
  text (strConstTitel, width/2, 40);
  
  // StateAfterGame text 
  textSize(19);
  textAlign(LEFT);
  text ("Game '" + 
    chooseGameName[currentGame] + 
    "' is finished. ", textXPosB, 80);  
  textSize(19);
  text("CHECKMATE OR DRAW!", 
    textXPosB, 230);
  text("- Either Press Mouse 1 or H to go to main screen.", width/4, height/2);
}

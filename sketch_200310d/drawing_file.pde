void draw_people(){
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 0; j < houses[0].length; j++ ) {
      houses[i][j].draw_person();
    }
  }
}

void update_txt() {
  fill(255);
  textSize(12);
  text("Number of days     "+ date, 650, 270);
  if(work_state != null)
    text("State is     "+ work_state, 650, 300);
  else 
     text("The simulation is not started", 650, 300);
}

void writetext() {
  textSize(20);
  //textAlign(CENTER, CENTER);
  text("Office", 200, 245);
  text("Houses 1-150", 50, 45);
  text("Houses 150-300", 50, 545);
}

void drawinstruction() {
  fill(51,153,255);
  circle(45,250,10);
  fill(255);
  textSize(11);
  text("Healthy", 55, 255);
  
  fill(253,253,91);
  circle(45,275,10);
  fill(255);
  textSize(11);
  text("Infected, no symptoms", 55, 275);
  text(", not contagious", 55, 285);
  
  fill(255,153,51);
  circle(45,300,10);
  fill(255);
  textSize(11);
  text("Infected, no symptoms", 55, 300);
  text(", already contagious", 55, 310);
  
  fill(255,0,0);
  circle(45,325,10);
  fill(255);
  textSize(11);
  text("Infected, show symptoms", 55, 325);
  text(",contagious, stays home", 55, 335);
  
  fill(255);
  textSize(11);
  text("This is a simulation reflecting how COVID-19 can spreading over a community of 900 people, based on the number of ppl working in office everyday.", 55, 745);

  text("All of the simulations start with only 1 random person getting infected in the community. It emphasize importance of self quarantine and reduce contact.", 55, 760);

  text("The infection model used in this simualtion is not precise, as we don't fully understand COVID-19 yet. (R0=2, incubation period 4-14 days, carrier is ", 55, 775);

  text("contagious 2 days before showing symptoms). The project is just for demo use, not for calcuations.", 55, 790);

}

void office() {
  int officeCols = 20;
  int officeRows = 15;
  strokeWeight(2);
  fill(255);
  //seperate office into grids

  for(int i = 0; i < officeCols; i++ ) {
    for(int j = 0; j < officeRows; j++ ) {
      float xc = 200+ i*18;
      float yc = 250+ j*18;
      rect(xc, yc, 18, 18);
    }
  }
}

void houses() {
  int houseCols = 50;
  int houseRows = 6;
  fill(255);
  for(int i = 0; i < (houseCols); i++ ) {
    for(int j = 0; j < houseRows/2; j++ ) {
      if(i%2 == 0)
        fill(229, 255, 204);
      else
        fill(255);
      stroke(153);
      strokeWeight(0.1);
      rect(50+i*18, 50 + j*60, 18, 54);
      rect(50+i*18, 550 + j*60, 18, 54);
      for (int k = 0; k < 3; k++ ) {
        strokeWeight(0.1);
        rect(50+i*18, 50 + j*60 +k*18, 18, 18);
        rect(50+i*18, 550 + j*60+k*18, 18, 18);
      }
    }
  }
}

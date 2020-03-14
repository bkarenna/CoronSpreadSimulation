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
  circle(100,300,10);
  
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

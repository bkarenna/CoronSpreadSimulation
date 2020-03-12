/* 
 The society is made up of small groups, a household with people who works or studies. 
 
 The simulation take place in a comany with 300 workers, 
 where each woker has a family of 3 prople,
 during diseased period, everyone still goes to work asual.
 see how simply one infected case going to work would infect the rest of 900 population.
 (Taking into consideration that as soon as one shart to show symptom, they are isolating themselves at home.)
 
 Later compare the effective of disease if everyone work from home.
 
 This model has elimated the other gathering like party and transportation.
 */
import java.util.ArrayList;
import java.util.List;
import controlP5.*;
ControlP5 cp5;
Knob myKnob;
int m;
int hour;
int date;
int time =3;
int start_time;
String work_state;

//Houses [] houses = new Houses[300]; 

People [][] houses; 

void setup()
{
  houses = new People[50][18]; 
  cp5 = new ControlP5(this);
  size (1000, 800); //canvas range
  background(0);
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 0; j < houses[0].length; j++ ) {
      houses[i][j] = new People(i, j);
    }
  }
  int nr = 0;
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 1; j < houses[0].length; j+=3 ) {
      houses[i][j].move_to_the_office(nr%20, nr/20);
      nr++;
    }
  }
  // Hi there
  //  for (int i = 0; i < houses.length; i++ ) {
  //    for (int j = 1; j < houses[0].length; j+=3 ) {
  //      houses[i][j].return_home();
  //  }
  //}
  houses[4][7].infection_logic();
  office();//set up office
  houses();//set up houses
  writetext();
  controlp5();
  frameRate(120);
  start_time = millis();
}

void draw() {

  datecount();
  update_txt();
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 0; j < houses[0].length; j++ ) {
      houses[i][j].draw_person();
    }
  }
}


void office() {
  int officeCols = 20;
  int officeRows = 15;
  int [][] office = new int[officeCols][officeRows];
  strokeWeight(0);
  fill(255);
  //seperate office into grids

  for (int i = 0; i < officeCols; i ++ ) {
    for (int j = 0; j < officeRows; j ++ ) {
      float xc = 200+ i*18;
      float yc = 250+ j*18;
      rect(xc, yc, 18, 18);
    }
  }
}

void houses() {
  int houseCols = 50;
  int houseRows = 6;
  int [][] house = new int[houseCols][houseRows];

  fill(255);
  for (int i = 0; i < (houseCols); i ++ ) {
    for (int j = 0; j < houseRows/2; j ++ ) {
      if (i%2 == 0)
        fill(229, 255, 204);
      else
        fill(255);
      strokeWeight(2);
      rect(50+i*18, 50 + j*60, 18, 54);
      rect(50+i*18, 550 + j*60, 18, 54);
      for (int k = 0; k < 3; k ++ ) {
        strokeWeight(0);
        rect(50+i*18, 50 + j*60 +k*18, 18, 18);
        rect(50+i*18, 550 + j*60+k*18, 18, 18);
      }
    }
  }
}



void writetext() {
  textSize(20);
  //textAlign(CENTER, CENTER);
  text("Office", 200, 245);
  text("Houses 1-150", 50, 45);
  text("Houses 150-300", 50, 545);
}
void update_txt() {
  fill(255);
  textSize(12);
  text("Number of days     "+ date, 650, 270);
  text("State is     "+ work_state, 650, 300);
}

int datecount() {
  fill(0);
  rect(650, 250, 200, 100);

  float days_passed = ((millis() - start_time) / 1000);
  println((millis() - start_time));
  int hours_passed = int(days_passed*24);
  if ( hours_passed%24 >= 8 && hours_passed%24 < 16 )
  {
    work_state = "working hours"; 
    int nr = 0;
    for (int i = 0; i < houses.length; i++ ) {
      for (int j = 1; j < houses[0].length; j+=3 ) {
        houses[i][j].move_to_the_office(nr%20, nr/20);
        nr++;
      }
    }
  } 
  else {
    work_state = "not woking"; 
    int nr = 0;
    for (int i = 0; i < houses.length; i++ ) {
      for (int j = 1; j < houses[0].length; j+=3 ) {
        houses[i][j].move_to_the_office(nr%20, nr/20);
        nr++;
      }
    }

    //  if (m%12 ==0)
    //  {
    //    date = m/12;
    //  }
    //  //stop count when all people are infected
      
   }
   return int(days_passed);
}

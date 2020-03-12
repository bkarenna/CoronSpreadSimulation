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


void update_txt() {
  fill(255);
  textSize(12);
  text("Number of days     "+ date, 650, 270);
  text("State is     "+ work_state, 650, 300);
}

int datecount() {
  office();//set up office
  houses();//set up houses
  fill(0);
  noStroke();
  rect(650, 250, 200, 70);  
  stroke(153);
  float miliseconds_passed = (float(millis()) - float(start_time));
  float days_passed = miliseconds_passed / float(1000);
  date = int(days_passed);
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
  } else {
    work_state = "not woking"; 
    int nr = 0;
    for (int i = 0; i < houses.length; i++ ) {
      for (int j = 1; j < houses[0].length; j+=3 ) {
        houses[i][j].return_home();
        nr++;
      }
    }

    //  //stop count when all people are infected
  }
  return int(days_passed);
}

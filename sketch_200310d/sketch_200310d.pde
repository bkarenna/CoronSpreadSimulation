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
int time = 3;
int start_time;
int observation_period;
String work_state;
boolean sotpSimulation;
boolean bugfix;
People [][] houses; 

void setup()
{
  bugfix = false;
  sotpSimulation = false;
  houses = new People[50][18]; 
  cp5 = new ControlP5(this);
  size (1000, 800); //canvas range
  background(0);
  observation_period = 0;
  office();//set up office
  houses();//set up houses
  writetext();
  controlp5();
  frameRate(120);
  populate_houses();
  start_time = millis();
  bugfix = true;
}

void draw() {
  office();//set up office
  houses();//set up houses
  fill(0);
  noStroke();
  rect(650, 250, 200, 70);  
  stroke(153);
  float days = daycount();
  if(!sotpSimulation){
    move_people(days);
  }
  
  update_txt();
  draw_people();
}

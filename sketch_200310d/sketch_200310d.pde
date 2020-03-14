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
int workers_daily;
String work_state;
String action_flag;
boolean isWorker;
boolean stopSimulation;
boolean bugfix;
People [][] houses;
People [][] office_space;


void setup()
{
  bugfix = false;
  stopSimulation = false;
  isWorker = false;
  houses = new People[50][18]; 
  office_space = new People[20][15];
  populate_houses_and_office();
  shuffle_people(100000);
  cp5 = new ControlP5(this);
  size (1000, 800); //canvas range
  background(0);
  observation_period = 0;
  workers_daily = 285;
  office();//set up office
  houses();//set up houses
  writetext();
  controlp5();
  frameRate(120);
  action_flag = "not woking";
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
  if(!stopSimulation){
    move_people(days);
  }
  update_txt();
  draw_people();
}

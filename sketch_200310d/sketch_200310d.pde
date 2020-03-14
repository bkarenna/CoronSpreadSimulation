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
int deseaseTrigger;
int time = 3;
int start_time;
int observation_period;
int workers_daily;
int office_len;
float simulationSpeed;
String work_state;
String action_flag;
boolean stopSimulation;
boolean bugfix;
People [][] houses;
People [][] office_space;
People [] theOnesThatGoToWork;

void setup()
{
  workers_daily = 285;
  observation_period = 0;
  bugfix = false;
  stopSimulation = false;
  theOnesThatGoToWork = new People[300];
  houses = new People[50][18]; 
  office_len = 20;
  office_space = new People[office_len][15];
  populate_houses();
  cp5 = new ControlP5(this);
  size (1000, 800); //canvas range
  background(0);
  office();//draws up office
  houses();//draws up houses
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

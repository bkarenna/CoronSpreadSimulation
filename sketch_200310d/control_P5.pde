//boolean start = false;

void controlp5() {
  /*
  1. slider (0-301) number of people working from home
   2. slider (0-10)  infection rate
   3. button (start) for simulation 
   4. button (stop) for paulse simulation 
   */
  noStroke();

  cp5.addSlider("Number_of_workers")
    .setPosition(650, 330)
    .setWidth(200)
    .setHeight(20)
    .setRange(0, 300)
    .setValue(300)
    .setNumberOfTickMarks(301)
    .setSliderMode(Slider.FLEXIBLE)
    ;   
  cp5.addToggle("toggle")
     .setPosition(850, 400)
     .setSize(126,20)
     .setValue(true)
     .setCaptionLabel("Worker                   Homeseatrer")
     .setMode(ControlP5.SWITCH)
     ;
  cp5.addButton("Start_simulation")
    .setValue(0)
    .setPosition(650, 400)
    .setCaptionLabel("Start simulation")
    .setSize(150, 20)
    ;
  cp5.addButton("Stop_simulation")
    .setValue(0)
    .setPosition(650, 470)
    .setCaptionLabel("Stop simulation")
    .setSize(150, 20)
    ;
}

public void Start_simulation() {
  if(bugfix){
    stopSimulation = false;
    deseaseTrigger = 1;
    cure_all();
    start_time = millis();
    workers_daily = int(cp5.getController("Number_of_workers").getValue());
    observation_period = 10000;
    populate_office();
    infect_random(parseBoolean(int(cp5.getController("toggle").getValue())));
  }
}

public void Stop_simulation() {
  if(bugfix){
    stopSimulation = true;    
  }
}


//public void button() {
//  if(bugfix){
    
//  }
//}
 

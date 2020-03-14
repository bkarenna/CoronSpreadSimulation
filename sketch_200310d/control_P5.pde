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
  cp5.addSlider("Observation_days")
    .setPosition(650, 370)
    .setWidth(200)
    .setHeight(20)
    .setRange(1, 100)
    .setValue(30)
    .setNumberOfTickMarks(100)
    .setSliderMode(Slider.FLEXIBLE)
    ;   
  cp5.addToggle("toggle")
     .setPosition(850, 460)
     .setSize(126,20)
     .setValue(true)
     .setCaptionLabel("Worker                   Homeseatrer")
     .setMode(ControlP5.SWITCH)
     ;
  cp5.addButton("Start_simulation")
    .setValue(0)
    .setPosition(650, 410)
    .setCaptionLabel("Start simulation")
    .setSize(150, 20)
    ;
  cp5.addButton("Stop_simulation")
    .setValue(0)
    .setPosition(650, 460)
    .setCaptionLabel("Stop simulation")
    .setSize(150, 20)
    ;
}

public void Start_simulation() {
  if(bugfix){
    populate_houses_and_office();
    stopSimulation = false;
    infect_random(isWorker);
    workers_daily = int(cp5.getController("Number_of_workers").getValue());
    observation_period = int(cp5.getController("Observation_days").getValue());
    start_time = millis();
  }
}

public void Stop_simulation() {
  if(bugfix){
    stopSimulation = true;    
  }
}

void toggle(boolean worker) {
  if(bugfix){
    isWorker = worker;
  }   
}
//public void button() {
//  if(bugfix){
    
//  }
//}
 
/*public void controlEvent(ControlEvent theEvent) {
  String name = theEvent.getController().getName();
  if (name.equals("Start simulation")){
    start = true;
    dateCounte();
  }
  if (name.equals("Stop simulation")){
    start = false;
  }
  if (name.equals("A random person got infected")){
    
  }
}*/

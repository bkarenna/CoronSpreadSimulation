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
  cp5.addButton("Start_simulation")
    .setValue(0)
    .setPosition(650, 370)
    .setSize(150, 20)
    ;
  cp5.addButton("Stop_simulation")
    .setValue(0)
    .setPosition(650, 410)
    .setSize(150, 20)
    ;
  cp5.addButton("A_random_person_got_infected")
    .setValue(0)
    .setPosition(650, 450)
    .setSize(150, 20)
    ;
}

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

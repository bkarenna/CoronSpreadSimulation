void populate_houses(){
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
}

void move_people(float days_passed){
  if(days_passed <= observation_period){
    date = int(days_passed)+1;
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
  }
}

void cure_all(){
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 0; j < houses[0].length; j++ ) {
      houses[i][j].cure();
      
    }
  }
}

float daycount() {
  float miliseconds_passed = (float(millis()) - float(start_time));
  float days_passed = miliseconds_passed / float(1000);
  return days_passed;
}

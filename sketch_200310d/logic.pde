void populate_houses() {
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 0; j < houses[0].length; j++ ) {
      houses[i][j] = new People(i, j);
    }
  }
}

void populate_office() {
  int nr = 0;
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 1; j < houses[0].length; j+=3 ) {
      office_space[nr%office_len][nr/office_len] = houses[i][j];
      office_space[nr%office_len][nr/office_len].isWorking = true;
      nr++;
    }
  }
  shuffle_people_in_the_office(100000);
}

void cure_all() {
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

void shuffle_people_in_the_office(int times) {
  People tmp;
  for (int i = 0; i < times; i++ ) {
    int first = int(random(0, 300));
    int second = int(random(0, 300));
    while (first==second)
      second = int(random(0, 300));
    tmp = office_space[first%office_len][first/office_len];
    office_space[first%office_len][first/office_len] = office_space[second%office_len][second/office_len];
    office_space[second%office_len][second/office_len] = tmp;
  }
  //assign new office possitions top people
  for (int i = 0; i < office_space.length; i++ ) {
        for (int j = 0; j < office_space[0].length; j++ ) {
          office_space[i][j].xpos = i;
          office_space[i][j].ypos = j;
        }
  }
}

void move_people(float days_passed) {
  if (days_passed <= observation_period) {
    date = int(days_passed)+1;
    int hours_passed = int(days_passed*24);
    if ( hours_passed%24 >= 8 && hours_passed%24 < 16 )
    {
      work_state = "working hours";
    } else {
      work_state = "not woking";
    }
    if ( action_flag.compareTo(work_state) != 0  && work_state.compareTo("working hours") == 0 ) {
      working_day_starts();
      action_flag = work_state;
    } 
    else if ( action_flag.compareTo(work_state) != 0  && work_state.compareTo("not woking")== 0 ){        
      working_day_ends();
      action_flag = work_state;     
    }
  }
}

void working_day_starts(){
  int count_total = 0;
  int count_working = 0;
  People tmp;
  shuffle_people_in_the_office(10000);
  //initialize array with nulls
  for (int i = 0; i < theOnesThatGoToWork.length; i++ ) 
    theOnesThatGoToWork[i]=null;
  while( count_total < theOnesThatGoToWork.length ){
    if(office_space[count_total%office_len][count_total/office_len].isWorking){
      theOnesThatGoToWork[count_working] = office_space[count_total%office_len][count_total/office_len];
      count_working++;
    }
    count_total++;
  }
  if( count_working < workers_daily )
    workers_daily = count_working;
  for (int i = 0; i < count_working*300; i++ ) {
    int first = int(random(0, count_working));
    int second = int(random(0, count_working));
    while (first==second)
      second = int(random(0, count_working));
    tmp = theOnesThatGoToWork[first];
    theOnesThatGoToWork[first] = theOnesThatGoToWork[second];
    theOnesThatGoToWork[second] = tmp;
  }
 for (int i = 0; i < workers_daily; i++ )
   theOnesThatGoToWork[i].move_to_the_office();
}

void working_day_ends(){
  for (int i = 0; i < workers_daily; i++ )
    theOnesThatGoToWork[i].return_home();
}

void infect_random(boolean worker) {
  int counter = 0;
  int unlucky_first;
  if (worker) {
    unlucky_first = int(random(0, 300));
    office_space[unlucky_first%20][unlucky_first/20].sickness_advances();
  } else {
    unlucky_first = int(random(0, 600));
    for (int i = 0; i < houses.length; i++ ) {
      for (int j = 0; j < houses[0].length; j+=3 ) {
        if (unlucky_first == counter) {
          houses[i][j].sickness_advances();
          counter++;
        } 
        else
          counter++;
      }
    }
     for (int i = 0; i < houses.length; i++ ) {
      for (int j = 2; j < houses[0].length; j+=3 ) {
        if (unlucky_first == counter) {
          houses[i][j].sickness_advances();
          counter++;
        } 
        else
          counter++;
      }
    }
  }
}

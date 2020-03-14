void populate_houses_and_office() {
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 0; j < houses[0].length; j++ ) {
      houses[i][j] = new People(i, j);
    }
  }
  int nr = 0;
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 1; j < houses[0].length; j+=3 ) {
      office_space[nr%20][nr/20] = houses[i][j];
      office_space[nr%20][nr/20].isWorking = true;
      nr++;
    }
  }
  shuffle_people(100000);
  for (int i = 0; i < office_space.length; i++ ) {
    for (int j = 0; j < office_space[0].length; j++ ) {
       office_space[i][j].move_to_the_office(i,j);
    }
  }
  infect_random(true);
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
    if ( action_flag.compareTo(work_state) != 0  && work_state.compareTo("working hours") != 0 ) {
      shuffle_people(10000);
      for (int i = 0; i < office_space.length; i++ ) {
        for (int j = 0; j < office_space[0].length; j++ ) {
          office_space[i][j].move_to_the_office(i,j);
        }
      }
      action_flag = work_state;
    } else if ( action_flag.compareTo(work_state) != 0  && work_state.compareTo("not woking")!= 0 ){        
       for (int i = 0; i < office_space.length; i++ ) {
        for (int j = 0; j < office_space[0].length; j++ ) {
          office_space[i][j].return_home();
        }
      }
    }
  }
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

void shuffle_people(int times) {
  People tmp;
  for (int i = 0; i < times; i++ ) {
    int first = int(random(0, 300));
    int second = int(random(0, 300));
    while (first==second)
      second = int(random(0, 300));
    tmp = office_space[first%20][first/20];
    office_space[first%20][first/20] = office_space[second%20][second/20];
    office_space[second%20][second/20] = tmp;
  }
}

void infect_random(boolean worker) {
  int counter = 0;
  int unlucky_first;
  if (worker) {
    unlucky_first = int(random(0, 300));
    office_space[unlucky_first%20][unlucky_first/20].infection_logic();
  } else {
    unlucky_first = int(random(0, 600));
    for (int i = 0; i < houses.length; i++ ) {
      for (int j = 0; j < houses[0].length; j+=3 ) {
        if (unlucky_first == counter) {
          houses[i][j].infection_logic();
          break;
        } 
        else
          counter++;
      }
    }
     for (int i = 0; i < houses.length; i++ ) {
      for (int j = 2; j < houses[0].length; j+=3 ) {
        if (unlucky_first == counter) {
          houses[i][j].infection_logic();
          break;
        } 
        else
          counter++;
      }
    }
  }
}

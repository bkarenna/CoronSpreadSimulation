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
  float days_passed = miliseconds_passed / (1000.0/simulationSpeed);
  return days_passed;
}

void shuffle_people_in_the_office(int times) {
    People tmp;
    for (int i = 0; i < times; i++ ) {
      int first = int(random(0, 300));
      int second = int(random(0, 300));
      while(first==second){
        second = int(random(0, 300));
      }
      tmp = office_space[first%office_len][first/office_len];
      office_space[first%office_len][first/office_len] = office_space[second%office_len][second/office_len];
      office_space[second%office_len][second/office_len] = tmp;
    }
    //assign new office possitions top people
    for (int i = 0; i < office_space.length; i++ ) {
          for (int j = 0; j < office_space[0].length; j++ ) {
            office_space[i][j].xpos = i;
            office_space[i][j].ypos = j;
            if(office_space[i][j].ypos > 14)
              println("WARNING");
            
          }
    }
}

void move_people(float days_passed) {
  if (days_passed <= observation_period) {
    if(deseaseTrigger < date){
      desease_day_passed();
      deseaseTrigger++;
    }
    int hours_passed = int(days_passed*24);
    if ( hours_passed%24 >= 8 && hours_passed%24 < 16 )
    {
      work_state = "working hours";
    } else {
      work_state = "not woking";
    }
    if ( action_flag.compareTo(work_state) != 0  && work_state.compareTo("working hours") == 0 ) {
      date++;
      working_day_starts();
      infection_round();
      action_flag = work_state;
    } 
    else if ( action_flag.compareTo(work_state) != 0  && work_state.compareTo("not woking")== 0 ){        
      working_day_ends();
      infection_round();
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
  if(workers_daily>1){
    for (int i = 0; i < count_working*300; i++ ) {
      int first = int(random(0, count_working));
      int second = int(random(0, count_working));
      while (first==second){
        second = int(random(0, count_working));
      }
      tmp = theOnesThatGoToWork[first];
      theOnesThatGoToWork[first] = theOnesThatGoToWork[second];
      theOnesThatGoToWork[second] = tmp;
    }
   for (int i = 0; i < workers_daily; i++ )
     theOnesThatGoToWork[i].move_to_the_office();
  }
}

void working_day_ends(){
  for (int i = 0; i < workers_daily; i++ ){
    //  hack fix
    if(theOnesThatGoToWork[i]!= null)
      theOnesThatGoToWork[i].return_home();
  }
}

void infect_random(boolean worker) {
  int counter = 0;
  int unlucky_first;
  if (worker) {
    unlucky_first = int(random(0, 300));
    office_space[unlucky_first%20][unlucky_first/20].gets_sick();
  } else {
    unlucky_first = int(random(0, 600));
    for (int i = 0; i < houses.length; i++ ) {
      for (int j = 0; j < houses[0].length; j+=3 ) {
        if (unlucky_first == counter) {
          houses[i][j].gets_sick();
          counter++;
        } 
        else
          counter++;
      }
    }
     for (int i = 0; i < houses.length; i++ ) {
      for (int j = 2; j < houses[0].length; j+=3 ) {
        if (unlucky_first == counter) {
          houses[i][j].gets_sick();
          counter++;
        } 
        else
          counter++;
      }
    }
  }
}

void desease_day_passed(){
  for (int i = 0; i < houses.length; i++ ) {
    for (int j = 0; j < houses[0].length; j++ ) {
      houses[i][j].sickness_develops();
    }
  }
}

void infection_round(){
  for(int i = 0; i < houses.length; i++ ) {
    for(int j = 0; j < houses[0].length; j++ ) {
      if(houses[i][j].isContageous()){
        if(houses[i][j].isHome){
          int house_coordinates = int(j/3)*3;
          for(int k = 0; k < 3; k++){
            if(houses[i][house_coordinates+k].isHome && houses[i][house_coordinates+k].isHealthy()&&random(0,100)<25)
              houses[i][house_coordinates+k].gets_sick();
          }
        }
        else{
          int maxX, maxY, minX, minY;
          if(houses[i][j].xpos==19)
            maxX = 19;
          else
            maxX = houses[i][j].xpos+1;          
          if(houses[i][j].ypos==14)
            maxY = 14;
          else
            maxY = houses[i][j].ypos+1;       
          if(houses[i][j].xpos==0)
            minX = 0;
          else
            minX = houses[i][j].xpos-1; 
          if(houses[i][j].ypos==0)
            minY = 0;
          else
            minY = houses[i][j].ypos-1;
          for(int x = minX; x <= maxX; x++){
            for(int y = minY; y <= maxY; y++){
              if(!office_space[x][y].isHome && office_space[x][y].isHealthy()&&random(0,100)<25)
                office_space[x][y].gets_sick();            
            }
          }
        }
      }
    }
  }
}

int officeCols = 20;
int officeRows = 15;
int [][] office = new int[officeCols][officeRows]; 
int houseCols = 50;
int houseRows = 18;
int [][] house = new int[houseCols][houseRows];
color[] color_stages = {color(51,153,255), color(253,253,91), color(255,153,51), color(255,0,0)};
//                             blue , yellow, orange, red

class People { 
  private int stage;
  private int xpos;
  private int ypos;
  private int houseX;
  private int houseY;
  private float xspeed;
  private boolean isHome;
  private boolean isWorking;
  

  People(int houseX, int houseY) {
    this.xpos  = -1;
    this.ypos = -1;
    this.houseX = houseX;
    this.houseY = houseY;
    this.stage = 0;
    this.xspeed = 0;
    this.isHome = true;
    if( houseY%3 == 1 )
      this.isWorking = true;
    else
      this.isWorking = false;
  }
  /*peoples features:
   color yellow : infacted, no symptom, not contageous
   color orange: infavted,  3 days before showing symtom,contageous
   color red: howing symtom, infected 
   color blue: healthy
   
   postion: (yellow,orange,blue) 8-16 in office, 16-8 at home
   (red) 0-24 at home
   speed: move in subject to normal distribution
   
   incubation period d=(int)random(7,15)
   infection start di = d-3
   infection rate R0=3 (one infected person can effect 3 others-
   1 orange could infect 3 blue to yellow)
   */
   
   
  void move(int x, int y){
    if(xpos + x >= officeCols)
      xpos = officeCols-1;
    else if(xpos + x < 0)
      xpos = 0;
    else  
      xpos += x;      
    if(ypos + y >= officeRows)
      ypos = officeRows-1;
    else if(ypos + y < 0)
      ypos = 0;  
    else
      ypos += y;
  }
  
  int[] get_position(){
    int[] coordinates = {xpos, ypos};
    return coordinates;
  }
  
  void move_to_the_office(int x, int y){
    if(!isWorking)
      println("This guys doesn't belong in the office");
    else{
      xpos = x;
      ypos = y;
      isHome = false;
    }
  }
  
   void return_home(){
    xpos = -1;
    ypos = -1;
    isHome = true;
  }

  void draw_person(){
    if(isHome){
      int global_offset = 50;
      int house_offset = 6 * (houseY/3);
      int house_block_offset = 320 * (houseY/9);
      int middle_offset = 9;
      int house_col = 18 * houseX;
      int house_row = 18 * houseY;
      int circle_x = global_offset + house_col + middle_offset;
      int circle_y = global_offset + house_block_offset + house_row + house_offset + middle_offset;
      fill(color_stages[stage]);
      strokeWeight(0);
      circle(circle_x, circle_y, 14);
    }
    else{
      int offset_x = 200;
      int offset_y = 250;
      int middle_offset = 9;
      int office_col = 18 * xpos;
      int office_row = 18 * ypos;
      int circle_x = offset_x + office_col + middle_offset;
      int circle_y = offset_y + office_row + middle_offset;
      fill(color_stages[stage]);
      strokeWeight(0);
      circle(circle_x, circle_y, 14);
    }
  }

  void infection_logic(){
    if(stage<3)
      stage+=1;
  }
  
}
PImage bg;
PImage soil;
PImage life;
PImage groundhogIdle;
PImage soldier;
PImage robot;
PImage cabbage;
PImage groundhogDown,groundhogLeft,groundhogRight;
PImage title, gameover, startNormal, startHo, restartHo, restartNormal;
int soliderX, soliderY;
boolean noLife;
float lifeRightY, lifeLeftY, lifeY;
int cabbageX, cabbageY;
final int GROUNDHOG_W=80, GROUNDHOG_H=80;
final int SOIL_W=80, SOIL_H=80;
final int GAME_START=0, GAME_LOSE=1, GAME_RUN=2;
final int RIGHT_LIFE_ADD=10, RIGHT_LIFE_CUT=80;
final int BUTTON_X=248, BUTTON_Y=360, 
  BUTTON_W=144, BUTTON_H=60;
int titleX, titleY;
int gameState;
//move
int animationFrame;

 
final int GROUNDHOG_IDLE = 0;
final int GROUNDHOG_LEFT = 1;
final int GROUNDHOG_RIGHT = 2;
final int GROUNDHOG_DOWN = 3;
 int groundhogState = GROUNDHOG_IDLE;

float groundhogX = width*4/8;
float groundhogY = height*1/6;


void setup() {
  
  gameState=GAME_START;
  size(640, 480);
  frameRate(60);
  bg=loadImage("img/bg.jpg");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  life=loadImage("img/life.png");
  soil=loadImage("img/soil.png");
  soldier=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png"); 
  title=loadImage("img/title.jpg");
  startNormal=loadImage("img/startNormal.png");
  startHo=loadImage("img/startHo.png");
  gameover=loadImage("img/gameover.jpg");
  restartHo=loadImage("img/restartHo.png");
  restartNormal=loadImage("img/restartNormal.png");



  image(bg, 0, 0); //background

  //grass
  stroke(124, 204, 25);
  strokeWeight(20);
  line(0, 150, 640, 150);
  image(soil, 0, SOIL_W*2);

  //move
  soliderY = floor(random(2, 6));//soldier's fioor

  //cabbage
  cabbageX = floor(random(0, 8));
  cabbageY = floor(random(2, 5));
  //groundhog

  groundhogX=320;
  groundhogY=80;
  //life
  lifeRightY=10;
  lifeLeftY=10;
  lifeY=-80;
  noLife=false;
}

void draw() {

  switch(gameState) {

  case GAME_START:
    image(title, 0, 0);
    image(startNormal, BUTTON_X, BUTTON_Y);

    if (mouseX>BUTTON_X && mouseX<BUTTON_X+BUTTON_W &&
      mouseY>BUTTON_Y && mouseY<BUTTON_Y+BUTTON_H) {
      //mouse action
      if (mousePressed) {
        //click
        gameState=GAME_RUN;
      } else {
        image(startHo, BUTTON_X, BUTTON_Y);
      }
    }
    break;

  case GAME_LOSE:
    image(gameover, 0, 0);
    image(restartNormal, BUTTON_X, BUTTON_Y);

    if (mouseX>BUTTON_X && mouseX<BUTTON_X+BUTTON_W &&
      mouseY>BUTTON_Y && mouseY<BUTTON_Y+BUTTON_H) {
      //mouse action
      if (mousePressed) {
        //click
        gameState=GAME_RUN;
      } else {
        image(restartHo, BUTTON_X, BUTTON_Y);
      }
    }
    break;

  case GAME_RUN:
  
  //move
  if(animationFrame<15){
    animationFrame++;
    switch(groundhogState){
      case GROUNDHOG_LEFT:
        groundhogX -= 80/15.0;
        break;
      case GROUNDHOG_RIGHT:
        groundhogX += 80/15.0;
        break;
      case GROUNDHOG_DOWN:
        groundhogY += 80/15.0;
        break;
    }
   
    if(animationFrame == 15){
      groundhogX = round(groundhogX);
      groundhogY = round(groundhogY);
    }
  }else{
    groundhogState = GROUNDHOG_IDLE;
  }
  
  
 
   
  
  //avoid out of area
    if (groundhogX>560) { 
      groundhogX-= 80/15.0;
    }
    if (groundhogX<0) {
      groundhogX+= 80/15.0;
    }
    if (groundhogY>400) {
      groundhogY-= 80/15.0;
    }

    //background 
    image(bg, 0, 0);


    //grass
    stroke(124, 204, 25);
    strokeWeight(20);
    line(0, 150, 640, 150);
    image(soil, 0, SOIL_W*2);

    //sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(590, 50, 120, 120);

    
    //life
    image(life, 150, lifeY );
    image(life, 10, lifeLeftY );
    image(life, 80, lifeRightY  );

    //cabbage
    image(cabbage, cabbageX*80, cabbageY*80);
    
    
    
   
    //soldier
    soliderX+=3;
    soliderX%=SOIL_W*9;
    image(soldier, soliderX-SOIL_W, 80*soliderY);

    //eat cabbage
    if (groundhogX+GROUNDHOG_W> cabbageX*80 && groundhogX<cabbageX*80+GROUNDHOG_W &&
      groundhogY+GROUNDHOG_H> cabbageY*80 && groundhogY<cabbageY*80+GROUNDHOG_H) {
      {
        if (lifeRightY==10) {//2-3
          lifeY=10;
          cabbageX=-80;
          cabbageY=-80;
        } else {//1-2

          lifeRightY=10;
          cabbageX=-80;
          cabbageY=-80;
        }
      }
    }

//groundhog display
  switch(groundhogState){
    case GROUNDHOG_IDLE:
    image(groundhogIdle,groundhogX,groundhogY);
    break;
    case GROUNDHOG_LEFT:
    println("jj");
     image(groundhogLeft,groundhogX,groundhogY);
     break;
    case GROUNDHOG_RIGHT:
     image(groundhogRight,groundhogX,groundhogY);
     break;
    case GROUNDHOG_DOWN:
    image(groundhogDown,groundhogX,groundhogY);
    break;
    }




    //first meet solider,back and -liferight,3-2
    if (groundhogX+GROUNDHOG_W> soliderX-SOIL_W && groundhogX<soliderX-SOIL_W+80 &&
      groundhogY+GROUNDHOG_H> 80*soliderY && groundhogY< 80*soliderY+SOIL_H &&
      lifeLeftY==10 && lifeRightY==10 && lifeY==10) {
      groundhogX=width*4/8;
      groundhogY=height*1/6;
      lifeLeftY=10 ;
      lifeRightY=10 ; 
      lifeY=-80;
    }
    //2-1
    if (groundhogX+GROUNDHOG_W> soliderX-SOIL_W && groundhogX<soliderX-SOIL_W+80 &&
      groundhogY+GROUNDHOG_H> 80*soliderY && groundhogY< 80*soliderY+SOIL_H &&
      lifeLeftY==10 && lifeRightY==10 && lifeY==-80) {

      groundhogX=320;
      groundhogY=80;
      lifeLeftY=10 ;
      lifeRightY=-80 ; 
      lifeY=-80;
    }

    //1-gameover
    if (groundhogX+GROUNDHOG_W> soliderX-SOIL_W && groundhogX<soliderX-SOIL_W+80 &&
      groundhogY+GROUNDHOG_H> 80*soliderY && groundhogY< 80*soliderY+SOIL_H &&
      lifeLeftY==10 && lifeRightY==-80 && lifeY==-80) {
      groundhogX=320;
      groundhogY=80;
      lifeLeftY=10 ;
      lifeRightY=10 ; 
      lifeY=-80;
      cabbageX = floor(random(0, 8));
      cabbageY = floor(random(2, 5));
      image(cabbage, cabbageX*80, cabbageY*80);

      gameState=GAME_LOSE;
    }
     
 
   
  }
}
void keyPressed(){
  if(groundhogState == GROUNDHOG_IDLE){
    animationFrame = 0;
    switch(keyCode){
      case LEFT:
        groundhogState = GROUNDHOG_LEFT;
        break;
      case RIGHT:
        groundhogState = GROUNDHOG_RIGHT;
        break;
        case DOWN:
        groundhogState = GROUNDHOG_DOWN;
        break;
    }
  }
}

PImage bg;
PImage soil;
PImage life;
PImage groundhog;
PImage soldier;
PImage robot;
PImage cabbage;
PImage groundhogDown,groundhogLeft,groundhogRight;
PImage title, gameover, startNormal, startHo, restartHo, restartNormal;
int soliderX, soliderY;
boolean noLife;
boolean downPressed, rightPressed, leftPressed;
float lifeRightY, lifeLeftY, lifeY;
float groundhogX, groundhogY;
int cabbageX, cabbageY;
final int GROUNDHOG_W=80, GROUNDHOG_H=80;
final int SOIL_W=80, SOIL_H=80;
final int GAME_START=0, GAME_LOSE=1, GAME_RUN=2;
final int RIGHT_LIFE_ADD=10, RIGHT_LIFE_CUT=80;
final int BUTTON_X=248, BUTTON_Y=360, 
  BUTTON_W=144, BUTTON_H=60;
 final int SPEED=80;  
int titleX, titleY;
int gameState;


void setup() {
  frameRate=60;
  gameState=GAME_START;
  //groundpose
  downPressed=false;
  rightPressed=false;
  leftPressed=false;
  
 



  size(640, 480);
  bg=loadImage("img/bg.jpg");
  groundhog=loadImage("img/groundhog.png");
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
  
   
  
  //avoid out of area
    if (groundhogX>560) { 
      groundhogX-=SPEED;
    }
    if (groundhogX<0) {
      groundhogX+=SPEED;
    }
    if (groundhogY>400) {
      groundhogY-=SPEED;
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
    
    //groundhog pose
       if(downPressed){
      image(groundhog,-80,-80);
  image(groundhogDown,groundhogX,groundhogY);
  image(groundhog,-80,-80);
  
 
   }
   
   if(leftPressed){
      image(groundhog,-80,-80);
  image(groundhogLeft,groundhogX,groundhogY);
  image(groundhog,-80,-80);
   }
   
   if(rightPressed){
      image(groundhog,-80,-80);
  image(groundhogRight,groundhogX,groundhogY);
  image(groundhog,-80,-80);
   }
   
   if(downPressed==leftPressed==rightPressed==false){
   image(groundhog,groundhogX,groundhogY);
   }

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
void keyPressed() {
  if (key==CODED) {
    switch(keyCode) {
    case DOWN:
      downPressed=true;
      groundhogY+=SPEED;
     
      break;
    case LEFT:
      leftPressed=true;
      groundhogX-=SPEED;
      break;
    case RIGHT:
      rightPressed=true;
      groundhogX+=SPEED;
      break;
    }
  }
}
void keyReleased() {
  if (key==CODED) {
    switch(keyCode) {
    case DOWN:
      downPressed=false;

      break;
    case LEFT:
      leftPressed=false;

      break;
    case RIGHT:
      rightPressed=false;

      break;
    }
  }
}

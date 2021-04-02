final int GAME_START =0, GAME_RUN =1, GAME_LOSE =2;
int gameState=0;

int x = 80;
int y = 160;
int p = 10; // life X
int q = 10; // life y
int heartNum = 2;
int hogX = 320;
int hogY = 80;
int a = 80; //move

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

PImage bgImg;
PImage soilImg;
PImage groundhogImg;

PImage groundhogDownImg;
PImage groundhogLeftImg;
PImage groundhogRightImg;

PImage lifeImg;
PImage soldierImg;
PImage cabbageImg;
PImage titleImg;
PImage gameoverImg;
PImage startNormalImg;
PImage startHoveredImg;
PImage restartNormalImg;
PImage restartHoveredImg;

int soldierY=x*int(random(3, 6));

int cabbageX=x*int(random(2, 8));
int cabbageY=x*int(random(3, 6));

void setup() {
  gameState = GAME_START;
  frameRate(60);

  size(640, 480, P2D);
  bgImg = loadImage("img/bg.jpg");
  soilImg = loadImage("img/soil.png");
  groundhogImg = loadImage("img/groundhog.png");
  lifeImg = loadImage("img/life.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");

  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");

  titleImg = loadImage("img/title.jpg");
  gameoverImg = loadImage("img/gameover.jpg");
  startNormalImg = loadImage("img/startNormal.png");
  startHoveredImg = loadImage("img/startHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  restartHoveredImg = loadImage("img/restartHovered.png");
}

void draw() {
  // Switch Game State
  switch (gameState) {
    // Game Start
  case GAME_START:
    hogX = 320; 
    hogY = 80;
    println(123);
    image(titleImg, 0, 0);
    image(startNormalImg, 248, 360);
    //mouse action
    if (mouseX<392 && mouseX>248 && mouseY<420 && mouseY>360) {
      image(startHoveredImg, 248, 360);
      if (mousePressed) {
        //click
          hogX = 320; 
          hogY = 80;
        gameState = GAME_RUN;
      }
    }
    break;

    // Game Run
  case GAME_RUN:

    image(bgImg, 0, 0);
    image(soilImg, 0, x*2);

    //grass
    noStroke();
    fill(124, 204, 25);  
    rect(0, x*2-15, x*8, 15);

    //sun
    fill(225, 225, 0);  
    ellipse(x*59/8, x*5/8, x*13/8, x*13/8);
    fill(253, 184, 19);
    ellipse(x*59/8, x*5/8, x*3/2, x*3/2);

    image(groundhogImg, hogX, hogY);
    
        //keyboard pressed
    if (upPressed) {
      hogY -= 80/15 ;
      image(groundhogImg, hogX, hogY);
    }
    if (downPressed) {
      hogY += 80/15;
      //image(groundhogDownImg, hogX, hogY);
    }
    if (leftPressed) {
      hogX -= 80/15;
      //image(groundhogLeftImg, hogX, hogY);
    }
    if (rightPressed) {
      hogX += 80/15;
      //image(groundhogRightImg, hogX, hogY);
    }
     

    // soldier
    y+=4; // y=y+4
    y%= 640;
    image(soldierImg, y, soldierY);

    // cabbage
    image(cabbageImg, cabbageX, cabbageY);

    // groundhog move
    if (hogX <= 0 ) {
      hogX = 0;
    } else if (hogX >= width-80 ) {
      hogX = x*7;
    }

    if (hogY <= x) {
      hogY = x;
    } else if (hogY >= height-80) {
      hogY = x*5;
    }

    // hit detection for cabage
    if (hogX + x > cabbageX && hogX < cabbageX+x ) {
      if (hogY < cabbageY + x && hogY + x > cabbageY) {
        cabbageX = 100*x;
        cabbageY = 100*x;
        heartNum++;
      }
    }

    // hit detection for soldier
    if (hogX + x > y && hogX < y+x ) {
      if (hogY < soldierY + x && hogY + x > soldierY) {
        hogX=320;
        hogY=80;
        heartNum-=1;
        println("111");
      }
    }
    //display the hearts
    for (int i = 0; i < heartNum; i++) {
      image(lifeImg, 10+i*70, 10);
    }
    //lose
   if (heartNum<1){
     gameState=GAME_LOSE;
   }
    break;

    
		// Game Lose
     case GAME_LOSE:
     image(gameoverImg,0,0);
     image(restartNormalImg, 248 , 360);
     //mouse action
     if(mouseX<392 && mouseX>248 && mouseY<420 && mouseY>360){
     image(restartHoveredImg, 248 , 360);
          hogX = 320; 
     hogY = 80;
     cabbageX = x*int(random(2,8)); 
     cabbageY = x*int(random(3,6));
     
     if(mousePressed){
     //click
     gameState = GAME_START;
     }
     }
  }
  
}

void keyPressed() {
  if (key == CODED) { // detect special keys
    switch (keyCode) {
    case UP:
      upPressed= true ;
      break;
    case DOWN:
      downPressed= true;
      image(groundhogDownImg, hogX, hogY);
      break;
    case LEFT:
      leftPressed= true;
      image(groundhogLeftImg, hogX, hogY);
      break;       
    case RIGHT:
      rightPressed= true;
      image(groundhogRightImg, hogX, hogY);
      break;
    }
  }
}

void keyReleased() {
  if (key == CODED) { // detect special keys
    switch (keyCode) {
    case UP:
      upPressed= false ;
      break;
    case DOWN:
      downPressed= false;
      break;
    case LEFT:
      leftPressed= false;
      break;       
    case RIGHT:
      rightPressed= false;
      break;
    }
  }
}

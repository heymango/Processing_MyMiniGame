import ddf.minim.*; 
AudioPlayer player; 
AudioPlayer bark; 
AudioPlayer rainbow; 
AudioPlayer monster; 
AudioPlayer maple;
Minim minim;
int gamemode=0;
//gamemode 1 = bird
//mode 10 birdmenu
//mode 50 barktown
//mode 55 barktown menu
//mode 65 black
//mode 60 rainbow
int posX = 400;
int posY = 800 -50/ 2;
PImage[] teemoL = new PImage[4];
PImage[] teemoR = new PImage[4];
PImage[] bgimage = new PImage[4];
PImage background;
int ismove =0;
float x=1300;
float y=3900;
int teemomode;
PImage play;
PImage cave;
PImage newworld;
PImage enjoy;
PImage barkm;
PImage rainbowm;
//**********bird********************
PImage over;
AudioPlayer birdbsound, bgmusic; 
PImage bg;
int run=0;
boolean win;
boolean large=false;
Bird bird;
int birdSize = 60;
float prevY;

int pipeWidth = 100;
int pipeHeight = 1000;
int verticalPipeDistance = round(3*birdSize);    
int pipeDistance = 500;                        
int N_pipes = 1000;                               
ArrayList<Pipe> pipes = new ArrayList();

float pipeVelocity0 = 2;
float pipeVelocity = pipeVelocity0;

PImage backGround, pipeUp, pipeDown;              
PImage sprite, spriteDead, spriteUp, spriteDown;  

PFont Font;
int textsize;
String fontName = "Pixel.vlw";                  

int score = 0;
int highScore = 0;
PrintWriter output;                           

//***********************************
int velX = 0;
int velY = 0;
int grav = 1;
int ground = 1;
int maxSpd = 10;
platform plat1;
platform plat2;
platform plat3;
platform plat4;
platform plat5;
void setup() {

  minim = new Minim(this); 
  player = minim.loadFile("song.mp3", 2048);

  bark = minim.loadFile("barktown.mp3");
  rainbow=minim.loadFile("rainbowcity.mp3");
  monster=minim.loadFile("monster.mp3");
  maple = minim.loadFile("maple.mp3");
  size(800,800);
  background(0);
  bgimage[0] = loadImage("map.png");
  bgimage[1] = loadImage("barktown.png");
  bgimage[2]=loadImage("rainbowcity.png");
  bgimage[3]=loadImage("maplemap.png");
  teemoL[0] = loadImage("tl1.png");
  teemoL[1] = loadImage("tl2.png");
  teemoL[2] = loadImage("tl3.png");
  teemoL[3] = loadImage("tl.png");
  teemoR[0] = loadImage("tr1.png");
  teemoR[1] = loadImage("tr2.png");
  teemoR[2] = loadImage("tr3.png");
  teemoR[3] = loadImage("tr.png");
  play = loadImage("play.png");
  over = loadImage("over.png");
  cave = loadImage("cave.png");
  newworld=loadImage("newworld.png");
  enjoy = loadImage("enjoy.png");
  barkm = loadImage("barkm.png");
  rainbowm = loadImage("rainbowm.png");
  //********************bird*********************
  birdbsound = minim.loadFile("die.mp3");
  birdbsound.setVolume(100);
  bgmusic = minim.loadFile("music.mp3");
  bgmusic.setVolume(-10);
  String[] lines = loadStrings("HighScores.txt");
  highScore = lines.length > 0 ? parseInt(lines[lines.length-1]) : 0;

  
  //// load the sprites
  backGround = loadImage("data/Background.png");
  backGround.resize(width, height);
  
  pipeUp = loadImage("data/PipeUp.png");
  pipeUp.resize(pipeWidth, pipeHeight);
  pipeDown = loadImage("data/PipeDown.png");
  pipeDown.resize(pipeWidth, pipeHeight);
  
  sprite = loadImage("data/BirdSprite.png");
  spriteDead = loadImage("data/BirdSpriteDead.png");
  spriteUp = loadImage("data/BirdSpriteUp.png");
  spriteDown = loadImage("data/BirdSpriteDown.png");
  
  sprite.resize(birdSize, birdSize);
  spriteDead.resize(birdSize, birdSize);
  spriteUp.resize(birdSize, birdSize);
  spriteDown.resize(birdSize, birdSize);
  //********************bird**************************
  plat1 = new platform(22,671,380);
  plat2 = new platform(342,564,413);
  plat3 = new platform(66,448,360);
  plat4 = new platform(0,422,150);
  plat5 = new platform(375,278,193);
}

void draw() {
  println(gamemode);
  println(x,y);
  
  if(gamemode==0){
      bgmusic.pause();
      player.play();
    frameRate(50);
  imageMode(CORNER);
  image(bgimage[0], -x, -y,5000,5000);
  
  imageMode(CENTER);
  if(teemomode==0&&ismove==0) {
    image(teemoR[0],400,400);
  }
   else if(teemomode==0&&ismove==1){
     if(run<10) image(teemoR[0],400,400);
     else if(run<20&&run>=10) image(teemoR[1],400,400);
     else if(run<30&&run>=20) image(teemoR[2],400,400);
     else image(teemoR[1],400,400);
      }
   else if(teemomode==1&&ismove==0){
       image(teemoL[0],400,400);
   }
   else if(teemomode==1&&ismove==1){
     if(run<10) image(teemoL[0],400,400);
     else if(run<20&&run>=10) image(teemoL[1],400,400);
     else if(run<30&&run>=20) image(teemoL[2],400,400);
     else image(teemoL[1],400,400);
      }
      
     if(large==false){
  imageMode(CORNER);
  image(bgimage[0],600,0,200,200);
  noFill();
  stroke(255,216,0);
  strokeWeight(8);
  rectMode(CENTER);
  rect(600+x/5000*200,y/5000*200,32,32);
  noStroke();
  imageMode(CENTER);
  }
  else if(large==true){
    imageMode(CORNER);
  image(bgimage[0],0,0,800,800);
  noFill();
  stroke(255,216,0);
  strokeWeight(8);
  rectMode(CENTER);
  rect(x/5000*800,y/5000*800,128,128);
  noStroke();
  imageMode(CENTER);
 
  }
     if(x>1680&&x<1850&&y>4060&&y<4110){
     gamemode=10;
   }
   if(x>30&&x<150&&y>3830&&y<3880){
     image(cave,400,400);
   }
    if(x>520&&x<540&&y>640&&y<720){
      gamemode=55;
   }
   if(gamemode==10)image(play,400,400);
    if(gamemode==55)image(newworld,400,400);
   imageMode(CORNER);
  }
   else if(gamemode==50||gamemode==53){
     bark.play();
     background(0);
    frameRate(50);
  imageMode(CENTER);
  image(bgimage[1], 400,400);
  imageMode(CENTER);
  if(gamemode==53) image(enjoy,400,400,150,100);
  if(teemomode==0&&ismove==0) {
    image(teemoR[0],x,y,30,30);
  }
   else if(teemomode==0&&ismove==1){
     if(run<10) image(teemoR[0],x,y,30,30);
     else if(run<20&&run>=10) image(teemoR[1],x,y,30,30);
     else if(run<30&&run>=20) image(teemoR[2],x,y,30,30);
     else image(teemoR[1],x,y,30,30);
      }
   else if(teemomode==1&&ismove==0){
       image(teemoL[0],x,y,30,30);
   }
   else if(teemomode==1&&ismove==1){
     if(run<10) image(teemoL[0],x,y,30,30);
     else if(run<20&&run>=10) image(teemoL[1],x,y,30,30);
     else if(run<30&&run>=20) image(teemoL[2],x,y,30,30);
     else image(teemoL[1],x,y,30,30);
      }
    if(x==270&&y>=380&&y<=410) image(barkm,400,516);
    if(x==260&&y>=380&&y<=410){
      imageMode(CORNER);
     
      x=630; y=340;
      delay(30);
      bark.pause();
     gamemode=60;
   }
    if(x==550&&y>=400&&y<=410){
      imageMode(CORNER);

      x=520; y=640;
      bark.pause();
     gamemode=0;
   }
   }
    else if(gamemode==60){
      rainbow.play();
      maple.pause();
     background(0);
    frameRate(50);
  imageMode(CENTER);
  image(bgimage[2], 400,400,500,360);
  imageMode(CENTER);
  if(teemomode==0&&ismove==0) {
    image(teemoR[0],x,y,30,30);
  }
   else if(teemomode==0&&ismove==1){
     if(run<10) image(teemoR[0],x,y,30,30);
     else if(run<20&&run>=10) image(teemoR[1],x,y,30,30);
     else if(run<30&&run>=20) image(teemoR[2],x,y,30,30);
     else image(teemoR[1],x,y,30,30);
      }
   else if(teemomode==1&&ismove==0){
       image(teemoL[0],x,y,30,30);
   }
   else if(teemomode==1&&ismove==1){
     if(run<10) image(teemoL[0],x,y,30,30);
     else if(run<20&&run>=10) image(teemoL[1],x,y,30,30);
     else if(run<30&&run>=20) image(teemoL[2],x,y,30,30);
     else image(teemoL[1],x,y,30,30);
      }
    if(x==640&&y>=320&&y<=340){
      x=270; y=400;
      delay(30);
      rainbow.pause();
     gamemode=50;
   }
     if(y==280&&x>=200&&x<=210){
      maple.pause();
      rainbow.pause();
      monster.play();
      image(rainbowm,400,600,500,160);
      posX=400;
      posY=800;
      gamemode=75;
      
   }
 
   }
   else if(gamemode==70){
  monster.pause();
  maple.play();
  frameRate(50);
  imageMode(CENTER);
  image(bgimage[3],400,400,800,800);
  imageMode(CENTER);
  if(posX>800){
    gamemode=60;
    y=280;
    x=220;
  }
   if(teemomode==0)image(teemoR[0],posX,posY,50,50);
   else image(teemoL[0],posX,posY,50,50);
 
    posX = posX + velX;
    posY =posY + velY; 
    if (velY < 20 && ground == 0) {
      velY = velY + grav;
    }

    if (velX > maxSpd) {
      velX = maxSpd;
    }
    if (velX < -maxSpd) {
      velX = -maxSpd;
    }
  
    if (posY > 800 - 50 / 2) {
      ground = 1;
      posY = 800 - 50 / 2;
      velY = 0;
    }

  plat1.add();
  plat2.add();
  plat3.add(); 
  plat4.add();
  plat5.add();
  
   }
   
   else if(gamemode==1){
    player.pause();
    bgmusic.play();
    frameRate(80);
    image(backGround, 0, 0);
    float dh = bird.y - prevY;
    prevY = bird.y;
    println("good");
    bird.fall();
    for (Pipe p : pipes) {
      p.move();
      bird.checkCollision(p);
      p.show();
    }
    bird.show(dh);
  
    score = bird.getScore();
    if (score > highScore) {
    highScore = score;
    }
    if (score%5 == 0 && score > 0 && !win) {
      pipeVelocity *= 1.005;
    }
    if (score == N_pipes) {
      win = true;
    }
  
    output = createWriter("HighScores.txt");
    output.println(str(highScore));
    output.flush(); 
    output.close();
    if (!win) {
    if (!bird.dead) {
      textsize = 55;
      Font = createFont("Pixel.vlw", textsize);
      textFont(Font);
      text(str(score), width/2, textsize);
    } else {
        imageMode(CENTER);
        image(over,400,400);
        imageMode(CORNER);
        birdbsound.play();
        birdbsound.rewind();  
      }
    }
    else {
      textsize = 30;
      Font = createFont(fontName, textsize);
      textFont(Font);
      text("YOU WIN!", width/2, height/2-textsize/2);
    }
    textsize = 75;
    Font = createFont(fontName, textsize);
    textFont(Font);
    textAlign(CENTER);
    text(str(highScore), textsize, textsize); 
   }
   
}

void keyPressed(){
  if(gamemode==70){
    if(key==CODED){
  if(keyCode==UP){
      if (velY == 0 && ground == 1) {
        velY = -20;
        ground = 0;
     }
  }
  if (keyCode==LEFT) {
    velX=0;
    teemomode=1;
      velX-=3;
    }
    //right
    if (keyCode==RIGHT) {
      velX=0;
      teemomode=0;
      velX+=3;
    }
}
      
  }
  else{
    if(key == CODED){
    if(keyCode==LEFT) {
       teemomode=1;
     x-=10;
      if(gamemode==0&&x<0) x=0;
      if(gamemode==50&&x<260) x=260;
      if(gamemode==60&&x<160) x=160;
      
      ismove=1;
     run+=2;
     if(run>40)run=0;
    }
    else if(keyCode==RIGHT){
      teemomode=0;
     run+=2;
      if(gamemode==0&&x>4180) x=4180;
       if(gamemode==50&&x>540) x=540;
       if(gamemode==60&&x>640) x=640;
         x+=10; 
      ismove=1;
     
      if(run>30)run=0;
    }
    else if(keyCode==UP){
     y-=10;
      if(gamemode==0&&y<0) y=0;
        if(gamemode==50&&y<290) y=290;
        if(gamemode==60&&y<230) y=230;
      ismove=1;
     run+=2;
     if(run>40)run=0;
    }
     else if(keyCode==DOWN){
       y+=10;
       if(gamemode==0&&y>4190) y=4190;
         if(gamemode==50&&y>510) y=510;
          if(gamemode==60&&y>560) y=560;
      ismove=1;
     run+=2;
     if(run>40)run=0;
  }
 }
 
  }
      
    if(gamemode==1){
    println("why");
    if(bird.dead || win) {
       println("why!!!");
      if(keyCode=='y'||keyCode=='Y') restartGame();
    else if(keyCode=='n'||keyCode=='N') gamemode=0;
      } 
    else {
      bird.fly();
    } 
  }
   if(gamemode==10){
    if(keyCode=='y'||keyCode=='Y'){
        restartGame();
        gamemode=1; 
    }
    else if(keyCode=='n'||keyCode=='N'){
      bgmusic.pause();
      gamemode=0;
      x=1680;
      y=4060;
    }
    }
    if(gamemode==55){
    if(keyCode=='y'||keyCode=='Y'){
        x=540; y=400;
        player.pause();
        gamemode=53;
    }
    else if(keyCode=='n'||keyCode=='N'){
      gamemode=0;
      x=520;
      y=640;
    }
    }
    if(gamemode==53) {
     if(keyCode=='p'||keyCode=='P') gamemode=50;
    }
    if(gamemode==75) {
     if(keyCode=='y'||keyCode=='Y') {
       monster.pause();
       x=400;
       y=800;
       gamemode=70;
     }
    }
}

void mouseReleased(){
  if(mouseX>600&&mouseY<200){
      if(large==true)large=false;
      else large = true;
  }
}

void restartGame() {
    clear();
    win = false;
    bird = new Bird(width/4, height/2);
    prevY = bird.y;
    score = 0;
  
    pipeVelocity = pipeVelocity0;
    pipes = new ArrayList();
    for (int i=0; i<N_pipes; i++) {
      int pipePosition = height - floor(random(height/2) + verticalPipeDistance/2.);
    
      Pipe pipeDown = new Pipe(width + i*pipeDistance, pipePosition, pipeHeight, pipeWidth, false);
      pipes.add(pipeDown);
    
      Pipe pipeUp = new Pipe(width + i*pipeDistance, pipePosition - pipeHeight - verticalPipeDistance, pipeHeight, pipeWidth, true);
      pipes.add(pipeUp);
    }
 }


  
 class Bird {
  float x, y;
  float vy;
  float g, lift;
  boolean dead;
  Bird(int bx, int by) {
    g = 0.3; 
    lift = -7;
    x = bx;
    y = by;
    vy = 0; 
    dead = false;
  }

  void show(float dh) {
        if (dead) {
      image(spriteDead, x-birdSize/2, y-birdSize/2);
    } else {
      if (dh > 0) {
        image(spriteDown, x-birdSize/2, y-birdSize/2);
      } else if (dh < 0) {
        image(spriteUp, x-birdSize/2, y-birdSize/2);
      } else {
        image(sprite, x-birdSize/2, y-birdSize/2);
      }
    }
  }
  
  void checkCollision(Pipe pipe) {
       if (!pipe.up) {
      if ((x+birdSize/2. >= pipe.x) && (x-birdSize/2. <= pipe.x + pipeWidth)) {
        if (y+birdSize/2. >= pipe.y) {
          died();
        }
      }
    }
    else if (pipe.up) {
      if ((x+birdSize/2. >= pipe.x) && (x-birdSize/2. <= pipe.x + pipeWidth)) {
        if (y-birdSize/2. <= pipe.y+pipeHeight) {
          died();
        }
      }
    }
 
    if (y + birdSize/2. >= height-10) {
      died();
    }
  }
  
  int getScore() {
    int score = 0;
    for (Pipe p : pipes) {
      if (bird.x > p.x + pipeWidth) {
        score ++;
      }
    }
    return score/2;
  }
  
  void fall() {
  
    println("ppp");
    if (!win) {
      if (y > height - birdSize/2.-10) {
        vy = 0;
        y = height - birdSize/2.-10;
      }
      if (y <= height - birdSize/2.) {
        vy += g;
        y += vy;
      }
    }
  }

  void fly() {

    if (y-birdSize >= 0) {
      vy = lift;
    }
  }

  void died() {
    dead = true;
   
    vy = 20;
   
  }
}
class Pipe {
  int h, w; 
  int x, y; 
  boolean up; 
  Pipe(int pipeX, int pipeY, int Height, int Width, boolean upperRow) {
    h = Height;
    w = Width;
    x = pipeX;
    y = pipeY;
    up = upperRow;
    
  }
  
  void show() {
    if (up) {
      image(pipeDown, x, y);
    } else if (!up) {
      image(pipeUp, x, y);
    }
  }
  
  void move() {
       if (!bird.dead && !win) {
      x -= pipeVelocity;
    }
  }
}
  
  //***********************************
class platform{
  int x, y,w ;
  platform(int tempX, int tempY,int  tempW) {
    this.x = tempX;
    this.y = tempY;
    this.w = tempW;
  }
 public void add() {
    if (velY > 0 && posX > this.x - 50 / 2 && posX < this.x + this.w + 50 / 2 && posY > this.y-50 && posY < this.y) {
      velY = 0;
      ground = 1;
      posY = this.y - 50 / 2;
    }
    if (ground == 1 && posY == this.y - 50 / 2) {
      if (posX > this.x + this.w+ 50 / 2) {
        ground = 0;
      }
      if (posX < this.x- 50 / 2) {
        ground = 0;
      }
    }
  }
}

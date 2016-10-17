PImage bg, fish, upBadCat, underBadCat, myCat, lose, win, restart;
final int FISH_W = 130;
final int FISH_H = 150;
final int BADCAT_INIT_X = 160;
final int BADCAT_INIT_Y = -140;
final int BADCAT_W = 150;
final int BADCAT_H = 430;
final int SPACE = 350;
final int MYCAT_X = 1080;
final int MYCAT_Y = 280;
final int MYCAT_W = 220;
final int MYCAT_H = 150;
final int RESTART_W = 150;
final int RESTART_H = 150;


int gameState = 0; 
/**************************
*    0: game is playing   *
*    1: game is lose      *
*    2: game is win       *
***************************/

int fishX, fishY,a;
float badCatY;
float x_inc = PI/15.0;
float k = 0.0;
float k_inc = PI/40.0;
final float A = 50.0; 


void setup()
{
  size(1280,755);
  bg = loadImage("img/bg.png");
  fish = loadImage("img/fish.png");
  upBadCat = loadImage("img/upBadCat.png");
  underBadCat = loadImage("img/underBadCat.png");  
  myCat = loadImage("img/myCat.png");
  lose = loadImage("img/lose.png");
  win = loadImage("img/win.png");
  restart = loadImage("img/restart.png");
  a=0;
}

void draw()
{
  switch(gameState) {
    case 0:
        image(bg, 0, 0, 1280, 755);
        
        //move the fish by mouse 
        fishX = mouseX-FISH_W/2;
        fishY = mouseY-FISH_H/2;
        if(fishX < 0 ){
          fishX = 0;
        } else if(fishX > 1280-FISH_W) {
          fishX = 1280-FISH_W;
        }
        if(fishY < 0) {
          fishY = 0;
        } else if(fishY > 755-FISH_H) {
          fishY = 755-FISH_H;
        }
        image(fish, fishX, fishY,FISH_W, FISH_H);
     
             
        //the badCat robs fish
        for(int i = 0; i < 6; i++) {
          badCatY =  A * sin(x_inc*i+k) + BADCAT_INIT_Y ;
           k+=k_inc;
           
           
         /* ... Part I  : badCats line up in sin wave " ...*/                
             a=i*BADCAT_W;
             image(upBadCat,BADCAT_INIT_X+a,badCatY);
             image(underBadCat,BADCAT_INIT_X+a,BADCAT_H+badCatY+SPACE);
             
         /* ... Part II : how to tell "badCats rob fish" ...*/
               if(mouseX+FISH_W/2>BADCAT_INIT_X && mouseX-FISH_W/2<BADCAT_W*6){
                 if(mouseY<BADCAT_H+badCatY+FISH_H/2){
               gameState= 1 ;
               }
             }
             
             if(mouseX+FISH_W/2>BADCAT_INIT_X && mouseX-FISH_W/2<BADCAT_W*7){
                 if(mouseY>1280-BADCAT_H+badCatY-FISH_H){
               gameState= 1 ;
               }
             }
        }
        
        
        /* ... Part III: badCats move in sin wave  ...*/    
        
        
        //success to feed myCat
        image(myCat, MYCAT_X, MYCAT_Y);
            
      
        /* ... Part II : how to tell "myCat has been fed fish" ...*/
      if(fishX+FISH_W>MYCAT_X && fishX<MYCAT_X+MYCAT_W){
        if(fishY+FISH_H>MYCAT_Y && fishY<MYCAT_Y+MYCAT_H){
          gameState=2;
        }
      }
            
        break;
  
      case 1:
        image(lose, 0, 0);
        image(restart, 0, 0);
        if(mousePressed == true) {
          
          
        /* ... Part II : After pressing restart image, game will restart ...*/
          gameState=0;
          
          
        }
        break;
        
      case 2:
        image(win, 0, 0);
        image(restart, 0, 0);
        if(mousePressed == true) {
          
          
        /* ... Part II : After pressing restart image, game will restart ...*/
          gameState=0;
          
        }
        break;
        
     default:
        print("error");
        break;
  }
}
#include <MeggyJrSimple.h>  

/* have curser flash, draw four arrays with the diff colors.
write in code that's like, if one array color = another array color
on that line/column, have it flash. and if it all works out, change the
boolean statement and have the level increase away from the tutorial
*/

  int xcoord = 4; // X-coordinate of the cursor
  int ycoord = 4; // Y-coordinate of the cursor
  
//Upper left hand corner of each of the 16 2x2 squares. starting upper left, reading like a book. b for board
//change 'random' to int color, which will be an array equaling whatever colors wanted?


struct Board

{
  int x; //coordinates for each of the b points
  int y;
  int z;         //[13] = {1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14}; //colors the dots- needs to be RANDOM
  
};
  
  //top row
  Board b1 = {0, 7, random(6)+1}; //random = 1-6 colors
  Board b2 = {2, 7, random(6)+1};
  Board b3 = {4, 7, random(6)+1};
  Board b4 = {6, 7, random(6)+1};
  //second from top
  Board b5 = {0, 5, random(6)+1};
  Board b6 = {2, 5, random(6)+1};
  Board b7 = {4, 5, random(6)+1};
  Board b8 = {6, 5, random(6)+1};
  //second from bottom
  Board b9 = {0, 3, random(6)+1};
  Board b10 = {2, 3, random(6)+1};
  Board b11 = {4, 3, random(6)+1};
  Board b12 = {6, 3, random(6)+1};
  //bottom row
  Board b13 = {0, 1, random(6)+1};
  Board b14 = {2, 1, random(6)+1};
  Board b15 = {4, 1, random(6)+1};
  Board b16 = {6, 1, random(6)+1};
  
  Board boardPoints[16] = {b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16};


void setup()                   
{
  ClearSlate();
  MeggyJrSimpleSetup();     
}

void loop()       
{
  
  drawCursor();
  
  drawBoard();
  
  DisplaySlate();
  
}


void drawCursor()
{
  DrawPx(xcoord, ycoord, White);           // Draw white dot at x=4, y=4
  DisplaySlate();                  // Write the drawing to the screen.
  delay(500);                  
  ClearSlate();                
  DisplaySlate();                 
  delay(200);
  
  CheckButtonsDown(); //check to see which button has been pressed
  
  if (Button_Up) //move dot up one space
    {
      ycoord = ycoord + 1; //move it north one spot
      if (ycoord > 7) //if it's moved past the top line..
        ycoord = 0; //wrap it around
    }
    
  if (Button_Right) //move the dot to the right one space
    {
      xcoord = xcoord + 1;
      if (xcoord > 7)
        xcoord = 0; //wrap it around if gone off the board
    }
  
  if (Button_Down) //move the dot down one space
    {
      ycoord = ycoord - 1;
      if (ycoord < 0)
        ycoord = 7; //wrap it around
    }
   
  if (Button_Left) //move dot to the left
    {
      xcoord = xcoord - 1;
      if (xcoord < 0)
        xcoord = 7; //wrap it around
    }
}


void drawBoard() //outline loop that draws all the dots
{
  for(int i = 0; i<16; i++) //go along every px
    {
       drawFour(boardPoints[i]); //draws drawFour for every point
    }
}

void drawFour(Board origin) //(Board origin) //drawing each 2x2
{
  DrawPx(origin.x, origin.y, origin.z); //RANDOM Vx4
  DrawPx(origin.x+1, origin.y, origin.z);
  DrawPx(origin.x, origin.y+1, origin.z);
  DrawPx(origin.x+1, origin.y+1, origin.z);
}


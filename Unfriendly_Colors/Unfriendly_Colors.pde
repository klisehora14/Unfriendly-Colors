#include <MeggyJrSimple.h>  

/* have curser flash, draw four arrays with the diff colors.
write in code that's like, if one array color = another array color
on that line/column, have it flash. and if it all works out, change the
boolean statement and have the level increase away from the tutorial
*/

  
//Upper left hand corner of each of the 16 2x2 squares. starting upper left, reading like a book. b for board
//change 'random' to int color, which will be an array equaling whatever colors wanted?

//
//int swap = {x, y, z} //greater than possible.. the swaping point that fills the spot when switching

//IF IMPOSSIBLE BOARD, PRESS A AND B AT THE SAME TIME TO GENERATE A NEW BOARD

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


  int xcoord = 0; // X-coordinate of the cursor
  int ycoord = 7; // Y-coordinate of the cursor
  int counter;
  
  int selectedX; //location for storing selected points
  int selectedY;
  int selectedZ;
  boolean isSelecting = false;

void setup()                   
{
  MeggyJrSimpleSetup();     
}

void loop()       
{
  drawBoard();
  counter++;
  if (counter > 100) counter = 0;
  {
    if (counter % 2 == 0) 
      {
        updateCursor();
       }
  }
  
//  flashing();
  
  DisplaySlate();
  delay(200);
  ClearSlate();
}


void selectSquare() //selecting one of the square blocks. xcoord,ycoord selects the given board point.
{
  CheckButtonsDown();
  if (Button_A) //select
    {
      //store points in an empty array? 
      if (isSelecting == false)
        {
          isSelecting = true;
          //A button has been pressed for the first time, selecting the point that it is on. need to store that point.
          selectedX = current x point of what the curser is on;
          selectedY = current Y point of what the curser is on;
          selectedZ = current Z point of what the curser is on;
        }
      else
        {
          if (counter % 2 == 1) //every other turn, flash it to the same tempo as the curser but opposite it.
            {
              ClearSlate();
              delay(200);
              {
                //code to make it switch with the next one selected
              }
            }
        }
    }
   if (Button_B)//unselect
     {
       //empty that open array of the points that were put in by button A
     }
   if (Button_B && Button_A)
     {
       //have z regenerate
     }
   if (Button_A && Button_B)
     {
       //have z regenerate
     }
}

void drawCursor() //draw the curser as a 2x2 block
{
  DrawPx(xcoord, ycoord, 7);
  DrawPx(xcoord + 1, ycoord, 7);
  DrawPx(xcoord, ycoord - 1, 7);
  DrawPx(xcoord + 1, ycoord - 1, 7);
}

void updateCursor()
{
  drawCursor();
  
  CheckButtonsDown(); //check to see which button has been pressed
  
  if (Button_Up) //move dot up one space
    {
      ycoord = ycoord + 2; //move it north one spot
      if (ycoord > 7) //if it's moved past the top line..
        ycoord = 0; //wrap it around
    }
    
  if (Button_Right) //move the dot to the right one space
    {
      xcoord = xcoord + 2;
      if (xcoord > 7)
        xcoord = 0; //wrap it around if gone off the board
    }
  
  if (Button_Down) //move the dot down one space
    {
      ycoord = ycoord - 2;
      if (ycoord < 0)
        ycoord = 7; //wrap it around
    }
   
  if (Button_Left) //move dot to the left
    {
      xcoord = xcoord - 2;
      if (xcoord < 0)
        xcoord = 7; //wrap it around
    }
}


void drawBoard() //outline loop that draws all the dots
{
  for(int i = 0; i<16; i++) //go along every px
    {
       DrawPx(boardPoints[i].x, boardPoints[i].y, boardPoints[i].z); //RANDOM Vx4
       DrawPx(boardPoints[i].x + 1, boardPoints[i].y, boardPoints[i].z);
       DrawPx(boardPoints[i].x, boardPoints[i].y - 1, boardPoints[i].z);
       DrawPx(boardPoints[i].x + 1, boardPoints[i].y - 1, boardPoints[i].z); 
    }
}


void flashing() //makes it flash
{
  for (int i = 0; i<16; i++)
  {
    for (int j = j+1; j<16; j++)
      {
        if (boardPoints[i].x == boardPoints[j].x || boardPoints[i].y == boardPoints[j].y) //draw out lines and columns
          {
            if (boardPoints[i].z == boardPoints[j].z) //if they have the same z (color) //ERROR
            {
              if (counter % 2 == 1) //every other time through the loop, flash
              {
                ClearSlate();
              }
            }
          }
      }
  }
}

//void flashing() //make the dots flash if they're on the same row or column
//{
//  for (int k = 0; k < 16; i++)
//    {
//      for (int j = k; j < 16; j++)
//         if(b1.z == b2.z)
//           {
//             //blink...
//             
////             board[k].x == board[j].x or board[k].y == board[j].y then 
////             if board[k].z == board[j].z
//           }
//       
//    }
//}

//
//for (int i =0; i< arraysize; i++){
//for (int j = i; j < arraysize; j++ ){
//compare array[i] to array[j] and do w.e you need

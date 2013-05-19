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
  int selectedIndex;
  boolean isSelecting = false;
  
  boolean wonGame = false;
  
  //boolean for checkAllColors

  //b1
  boolean b1x = false; //board point b1 x row
  boolean b1y =false; //board point b1 y row .... etc for all following
  
  //b2
  boolean b2x = false; 
  boolean b2y = false;
  
  //b3
  boolean b3x = false; 
  boolean b3y = false;
  
  //b4
  boolean b4x = false; 
  boolean b4y = false; 
  
  //b5
  boolean b5x = false;
  boolean b5y = false;
  
  //b6
  boolean b6x = false; 
  boolean b6y = false;
  
  //b7
  boolean b7x = false; 
  boolean b7y = false;
  
  //b8
  boolean b8x = false; 
  boolean b8y = false;
  
  //b9
  boolean b9x = false; 
  boolean b9y = false;
  
  //b10
  boolean b10x = false; 
  boolean b10y = false;
  
  //b11
  boolean b11x = false; 
  boolean b11y = false;
  
  //b12
  boolean b12x = false; 
  boolean b12y = false;
  
  //b13
  boolean b13x = false; 
  boolean b13y = false;
  
  //b14
  boolean b14x = false; 
  boolean b14y = false;
  
  //b15
  boolean b15x = false; 
  boolean b15y = false;
  
  //b16
  boolean b16x = false; 
  boolean b16y = false;
  

void setup()                   
{
  MeggyJrSimpleSetup();     
}

void loop()       
{
  if (wonGame = false)
    {
      drawBoard();
      counter++;
      selectSquare();
      checkAllColors();
      if (counter > 100) counter = 0;
      if (counter % 2 == 0) //makes all things insi
        {
          updateCursor();
         }
      }
    
  else //if wonGame is true, i.e. they have completed a levelll
    {
      newBoard(); //draws a board with new z for each point.
    }
  
}

void flashing()
{
  if (counter % 2 == 0)
    {
      DisplaySlate();
      delay(200);
      ClearSlate();
    }
}


void selectSquare() //selecting one of the square blocks. xcoord,ycoord selects the given board point.
{
  CheckButtonsDown();
  if (Button_A) //select
    {
      //store points in empty ints 
      if (isSelecting == false)
        {
          isSelecting = true;
          //A button has been pressed for the first time, selecting the point that it is on. need to store that point.
          selectedX = xcoord; //current x point of what the curser is on, also the x coord of the board point
          selectedY = ycoord; //current Y point of what the curser is on, also the y coord of the board point
          for (int i = 0; i < 16; i++)
          {
            if (xcoord == boardPoints[i].x && ycoord == boardPoints[i].y)
            {
              selectedZ = boardPoints[i].z; //color of current  board point
              selectedIndex = i; //current z color
              break;
            }
          }
        }
      else //if isSelecting is true
        {
          if (counter % 2 == 1) //every other turn, flash it to the same tempo as the curser but opposite it.
            {
              flashing();
              for (int i = 0; i < 16; i++)
                {
                  if (xcoord == boardPoints[i].x && ycoord == boardPoints[i].y)
                    {
                       boardPoints[i].z = boardPoints[selectedIndex].z; //color of current  board point
                       boardPoints[selectedIndex].z = selectedIndex;
                       isSelecting = false;
                       levelComplete(); //check to see if that was the last one to fix, if so, wonGame will = true
                       break; //stops it from seraching
                     }
          
                 }
            }
        }
   if (Button_B)//unselect
     {
       isSelecting = false; //unselects the point
     }
  if (Button_B && Button_A)
    {
      for (int i = 0; i < 16; i++)
        {
          Tone_Start(ToneC3, 100);
          boardPoints[i].z = random(6)+1;
        }
    }
  if (Button_A && Button_B)
    {
      for (int i = 0; i < 16; i++)
        {
          Tone_Start(ToneC3, 100);
          boardPoints[i].z = random(6)+1;
        }
    }
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


//void flashing() //makes it flash
//{
//  for (int i = 0; i<16; i++)
//  {
//    for (int j = j+1; j<16; j++)
//      {
//        if (boardPoints[i].x == boardPoints[j].x || boardPoints[i].y == boardPoints[j].y) //draw out lines and columns
//          {
//            if (boardPoints[i].z == boardPoints[j].z) //if they have the same z (color) //ERROR
//            {
//              if (counter % 2 == 1) //every other time through the loop, flash
//              {
//                ClearSlate();
//              }
//            }
//          }
//      }
//  }
//}

void newBoard() //genearates new random z for all points in board points.. plays a sound, player 'levels up'
{
  for (int i = 0; i < 16; i++)
    {
      Tone_Start(ToneFs3, 100); 
      boardPoints[i].z = random(6)+1;
      wonGame = false;
    }
}

void levelComplete() //if there are none flashing (the boolean statements will all be true), then wonGame= true and greate a new board (newBoard())
{                    // hard coded because cannot find a faster way to do it
  checkAllColors(); //see iff the boolean statements are TRUE. if they all are, as the following code checks, then change wonGame = true;
  
  if (b1x == true)        //b1
    {
      if (b1y == true)    //b1
        {
          if (b2x == true)        //b2
            {
              if (b2y == true)    //b2
                {
                  if (b3x == true)        //b3
                    {
                      if (b3y == true)    //b3
                        {
                          if (b4x == true)        //b4
                            {
                              if (b4y == true)    //b4
                                {
                                  if (b5x == true)        //b5
                                    {
                                      if (b5y == true)    //b5
                                        {
                                          if (b6x == true)        //b6
                                            {
                                              if (b6y == true)    //b6
                                                {
                                                  if (b7x == true)        //b7
                                                    {
                                                      if (b7y == true)    //b7
                                                        {
                                                          if (b8x == true)        //b8
                                                            {
                                                              if (b8y == true)    //b8
                                                                {
                                                                  if (b9x == true)        //b9
                                                                    {
                                                                      if (b9y == true)    //b9
                                                                        {
                                                                          if (b10x == true)        //b10
                                                                            {
                                                                              if (b10y == true)    //b10
                                                                                {
                                                                                  if (b11x == true)        //b11
                                                                                    {
                                                                                      if (b11y == true)    //b11
                                                                                        {
                                                                                          if (b12x == true)        //b12
                                                                                            {
                                                                                              if (b12y == true)    //b12
                                                                                                {
                                                                                                  if (b13x == true)        //b13
                                                                                                    {
                                                                                                      if (b13y == true)    //b13
                                                                                                        {
                                                                                                          if (b14x == true)        //b14
                                                                                                            {
                                                                                                              if (b14y == true)    //b14
                                                                                                                {
                                                                                                                  if (b15x == true)        //b15
                                                                                                                    {
                                                                                                                      if (b15y == true)    //b15
                                                                                                                        {
                                                                                                                          if (b16x == true)        //b16
                                                                                                                            {
                                                                                                                              if (b16y == true)    //b16
                                                                                                                                {
                                                                                                                                  wonGame = true;
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


void checkAllColors() //checks colors on line and row. hard coding point by point because cannot come up with a faster way
{
  
  //b1 i.e [0]
       if (boardPoints[0].z == boardPoints[1].z || boardPoints[0].z == boardPoints[2].z || boardPoints[0].z == boardPoints[3].z) //b1 X
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b1x = true;
         }
       if (boardPoints[0].z == boardPoints[4].z || boardPoints[0].z == boardPoints[8].z || boardPoints[0].z == boardPoints[12].z) //b2 Y
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b1y = true;
         }
         
  //b2 i.e [1]
      if (boardPoints[1].z == boardPoints[0].z || boardPoints[1].z == boardPoints[2].z || boardPoints[1].z == boardPoints[3].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b2x = true;
         }
       if (boardPoints[1].z == boardPoints[5].z || boardPoints[1].z == boardPoints[9].z || boardPoints[1].z == boardPoints[13].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b2y = true;
         }
  
  //b3 i.e [2]
       if (boardPoints[2].z == boardPoints[0].z || boardPoints[2].z == boardPoints[1].z || boardPoints[2].z == boardPoints[3].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b3x = true;
         }
       if (boardPoints[2].z == boardPoints[6].z || boardPoints[2].z == boardPoints[10].z || boardPoints[2].z == boardPoints[14].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b3y = true;
         }
  
  //b4 i.e [3]
       if (boardPoints[3].z == boardPoints[0].z || boardPoints[3].z == boardPoints[1].z || boardPoints[3].z == boardPoints[2].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b4x = true;
         }
       if (boardPoints[3].z == boardPoints[7].z || boardPoints[3].z == boardPoints[11].z || boardPoints[3].z == boardPoints[15].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b4y = true;
         }
  
  //b5 i.e [4]
       if (boardPoints[4].z == boardPoints[5].z || boardPoints[4].z == boardPoints[6].z || boardPoints[4].z == boardPoints[7].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b5x = true;
         }
       if (boardPoints[4].z == boardPoints[0].z || boardPoints[4].z == boardPoints[8].z || boardPoints[4].z == boardPoints[12].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b5y = true;
         }
  
  //b6 i.e [5]
       if (boardPoints[5].z == boardPoints[4].z || boardPoints[5].z == boardPoints[6].z || boardPoints[5].z == boardPoints[7].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b6x = true;
         }
       if (boardPoints[5].z == boardPoints[1].z || boardPoints[5].z == boardPoints[9].z || boardPoints[5].z == boardPoints[13].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b6y = true;
         }
  
  //b7 i.e [6]
       if (boardPoints[6].z == boardPoints[4].z || boardPoints[6].z == boardPoints[5].z || boardPoints[6].z == boardPoints[7].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b7x = true;
         }
       if (boardPoints[6].z == boardPoints[2].z || boardPoints[6].z == boardPoints[10].z || boardPoints[6].z == boardPoints[14].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b7y = true;
         }
  
  //b8 i.e [7]
       if (boardPoints[7].z == boardPoints[4].z || boardPoints[7].z == boardPoints[5].z || boardPoints[7].z == boardPoints[6].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b8x = true;
         }
       if (boardPoints[7].z == boardPoints[3].z || boardPoints[7].z == boardPoints[11].z || boardPoints[7].z == boardPoints[15].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b8y = true;
         }
  
  //b9 i.e [8]
       if (boardPoints[8].z == boardPoints[9].z || boardPoints[8].z == boardPoints[10].z || boardPoints[8].z == boardPoints[11].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b9x = true;
         }
       if (boardPoints[8].z == boardPoints[0].z || boardPoints[8].z == boardPoints[4].z || boardPoints[8].z == boardPoints[12].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b9y = true;
         }
  
  //b10 i.e [9]
         if (boardPoints[9].z == boardPoints[8].z || boardPoints[9].z == boardPoints[10].z || boardPoints[9].z == boardPoints[11].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b10x = true;
         }
       if (boardPoints[9].z == boardPoints[1].z || boardPoints[9].z == boardPoints[5].z || boardPoints[9].z == boardPoints[13].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b10y = true;
         }
  
  //b11 i.e [10]
       if (boardPoints[10].z == boardPoints[8].z || boardPoints[10].z == boardPoints[9].z || boardPoints[10].z == boardPoints[11].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b11x = true;
         }
       if (boardPoints[10].z == boardPoints[2].z || boardPoints[10].z == boardPoints[6].z || boardPoints[10].z == boardPoints[14].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b11y = true;
         }
  
  //b12 i.e [11]
       if (boardPoints[11].z == boardPoints[8].z || boardPoints[11].z == boardPoints[9].z || boardPoints[11].z == boardPoints[10].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b12x = true;
         }
       if (boardPoints[11].z == boardPoints[3].z || boardPoints[11].z == boardPoints[7].z || boardPoints[11].z == boardPoints[15].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b12y = true;
         }
  
  //b13 i.e [12]
       if (boardPoints[12].z == boardPoints[13].z || boardPoints[12].z == boardPoints[14].z || boardPoints[12].z == boardPoints[15].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b13x = true;
         }
       if (boardPoints[12].z == boardPoints[0].z || boardPoints[12].z == boardPoints[4].z || boardPoints[12].z == boardPoints[8].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b13y = true;
         }
  
  //b14 i.e [13]
       if (boardPoints[13].z == boardPoints[12].z || boardPoints[13].z == boardPoints[14].z || boardPoints[13].z == boardPoints[15].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b14x = true;
         }
       if (boardPoints[13].z == boardPoints[1].z || boardPoints[13].z == boardPoints[5].z || boardPoints[13].z == boardPoints[7].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b14y = true;
         }
  
  //b15 i.e [14]
       if (boardPoints[14].z == boardPoints[12].z || boardPoints[14].z == boardPoints[13].z || boardPoints[14].z == boardPoints[15].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b15x = true;
         }
       if (boardPoints[14].z == boardPoints[2].z || boardPoints[14].z == boardPoints[6].z || boardPoints[14].z == boardPoints[10].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b15y = true;
         }
  
  //b16 i.e [15]
       if (boardPoints[15].z == boardPoints[12].z || boardPoints[15].z == boardPoints[13].z || boardPoints[15].z == boardPoints[14].z) // X row
         {
           flashing();
         }
       else //if there are none of the same color on X row
         {
           boolean b16x = true;
         }
       if (boardPoints[15].z == boardPoints[3].z || boardPoints[15].z == boardPoints[7].z || boardPoints[15].z == boardPoints[11].z) // Y collumn
         {
           flashing();
         }
       else //if there are none of the same color on Y collumn 
         {
           boolean b16y = true;
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

#include <MeggyJrSimple.h>  
/*
Unfriendly Colors is a game inspired by both Bejeweled and Sudoku. The board starts by being completely covered in 16 2x2 squares, each a random color between 1 and 6 in the Meggy colors
(red, orange, yellow, green, blue, violet). If the same color is present on the same x or y (row or column) more than once, the colors will flash, indicating to the player that they cannot be there.
This part is taken from the idea of sudoku and not being able to have the same number(color) on the same row or column.

The player's curser is a white, 2x2 square that is also flashing. It is moved with the arrow keys and selects and unselects the colored squares with the A and B buttons, respectively. Once a square is selected,
it flashes (or continues to flash). The player then moves the curser to another square and selects it. The two will swap colors and stop flashing if necessary. Once there are no squares of the same color on 
the same row or column the game with sound a tone and generate a new board (yay, you won that board!).

If at any point an unsolvable board is generated or the player gets too frustrated, he/she can press both the A and B buttons at the same time and the board will regenerate with a different sound because it 
is a reset, not a win.

Because this is a puzzle game it can be continuously played without any sort of 'end'; just see how far you can get without having to regenerate the board!

Unfriendly Colors is by Kapri Lisehora.

*/

struct Board //background of 16 2x2 colored squares
{
  int x; //coordinates for each of the board points (Board bx)
  int y;
  int z;
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
  
  Board boardPoints[16] = {b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16}; //array that holds all of the squares together

  // Cursor
  int xcoord = 0; // X-coordinate of the cursor
  int ycoord = 7; // Y-coordinate of the cursor
  
  int counter; //counts how many times through the loop (reset after 100). This is used for the flashing method.
  
  //Selecting and Unselecting
  int selectedX; //location for storing selected x point 
  int selectedY; //location for storing selected y point 
  int selectedZ; //locatoin for temp. storing selected z point 
  int selectedIndex; // where Z will be stored and switched with the second colored square
  boolean isSelecting = false; //selecting/not selecting boolean for A and B buttons
  
  boolean wonGame = false; //if the game is won or not
  
  //boolean for checkAllColors

  //b1
  boolean b1x = false; //board point b1 x row
  boolean b1y =false; //board point b1 y column .... etc for all following
  
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
  if (wonGame == false) //if the level has not been complete:
    {
      counter++;
      if (counter > 10)
         { 
           counter = 0; //this resets the counter so it doesn't go over a hundred. Keeps it clean
         }
      drawBoard(); //method that draws boardPoints as well as the three corresponding dots that go with each one (right of the point, below, and bottom right to make the 2x2 square)
      checkAllColors(); //checks colors to see if they're on the same row/column
      updateCursor(); //every time the counter is divisible by 2, update the curser (makes it flash)
      selectSquare(); //method that allows the player to select and unselect squares
     }
    
  else //if wonGame is true, i.e. they have completed a level
    {
      newBoard(); //draws a board with new z for each point.
    }
 DisplaySlate();
}

void drawBoard() //outline method that draws all the dots
{
  for(int i = 0; i<16; i++) //go along every px
    {
       DrawPx(boardPoints[i].x, boardPoints[i].y, boardPoints[i].z); //draws the upper left hand dot
       DrawPx(boardPoints[i].x + 1, boardPoints[i].y, boardPoints[i].z); //draws the dot +1 in the x direction (right)
       DrawPx(boardPoints[i].x, boardPoints[i].y - 1, boardPoints[i].z); // draws dot in the -1 y direction (bottom)
       DrawPx(boardPoints[i].x + 1, boardPoints[i].y - 1, boardPoints[i].z); //draws dot in the +x, -y direction
                                                                                   // (bottom right)
    }
}

void flashing() //causes it to flash
{
  if (counter % 2 == 0) //counter increases every time through loop. every time it's divisible by two, flash.
    {
      ClearSlate(); //clear the slate
      drawBoard();
      delay(10); //hold it for .2 of a second
    }
}



void selectSquare() //selecting one of the square blocks. xcoord,ycoord selects the given board point.
{
  CheckButtonsDown();
  if (Button_A) //select
    {
      if (isSelecting == false) //if nothing is currently selected, i.e it's the first square the player is selecting out of the two needed to switch colors
        {
          isSelecting = true; //A button has been pressed for the first time. Now, the next time it is pressed, it will regester and switch the colors. Need to store the points of the first selectiong:
          selectedX = xcoord; //current x point of what the curser is on, also the x coord of the board point (stores it)
          selectedY = ycoord; //current Y point of what the curser is on, also the y coord of the board point (stores it)
          for (int i = 0; i < 16; i++)
          {
            if (xcoord == boardPoints[i].x && ycoord == boardPoints[i].y) //checks to see which board point the cursor is on
            {
              flashing();
              selectedZ = boardPoints[i].z; //color of current  board point
              selectedIndex = i; //current z color. Stores the current z color in selectedIndex (ex. if it was b1 and b1 was colored red, 1 (the number for red) would be stored in selectedIndex)
              break; //stops it from checking (so if it's b1, it doesn't go through and check the next 15)
            }
          }
        }
      else //if isSelecting is true (if another point has already been saved and A is being pressed for the second time)
        {
              flashing();
              for (int i = 0; i < 16; i++)
                {
                  if (xcoord == boardPoints[i].x && ycoord == boardPoints[i].y) //figure out which board point the cursor is on
                    {
                       boardPoints[i].z = boardPoints[selectedIndex].z; //color of current  board point
                       boardPoints[selectedIndex].z = i; //switches that color with what was stored in selectedIndex (the color from the first point)
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
  if (Button_B && Button_A || Button_A && Button_B) //redraws the board (two because the game can register one before the other)
    {
      for (int i = 0; i < 16; i++)
        {
          Tone_Start(ToneC3, 100); //play a sound because it's doing something significant
          boardPoints[i].z = random(6)+1;  //regenerates the board's colors randomly
        }
    }
}


void drawCursor() //draw the curser as a 2x2 block
{
  DrawPx(xcoord, ycoord, 7); //starting points, upper left hand corner, color white
  DrawPx(xcoord + 1, ycoord, 7); //draws point to the right, same color
  DrawPx(xcoord, ycoord - 1, 7); // draws the point below, same color
  DrawPx(xcoord + 1, ycoord - 1, 7); //draws point bottom right, same color
}

void updateCursor() //updates the location of the cursor
{
  drawCursor(); //calls upon the method that draws out xcoord,ycoord and the corresponding three points that make it a 2x2 square
  if (counter % 2 == 0)
    {
      flashing();
    }
  
  CheckButtonsPress(); //check to see which button has been pressed
  
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



void newBoard() //genearates new random z for all points in board points.. plays a sound, player 'levels up'
{
  for (int i = 0; i < 16; i++)
    {
      Tone_Start(ToneFs3, 100); // plays a sound
      boardPoints[i].z = random(6)+1; //regenerates the color variable (z) as random between 1 and six
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
       else //if there are none of the same color on Y column 
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
       if (boardPoints[1].z == boardPoints[5].z || boardPoints[1].z == boardPoints[9].z || boardPoints[1].z == boardPoints[13].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[2].z == boardPoints[6].z || boardPoints[2].z == boardPoints[10].z || boardPoints[2].z == boardPoints[14].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[3].z == boardPoints[7].z || boardPoints[3].z == boardPoints[11].z || boardPoints[3].z == boardPoints[15].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[4].z == boardPoints[0].z || boardPoints[4].z == boardPoints[8].z || boardPoints[4].z == boardPoints[12].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[5].z == boardPoints[1].z || boardPoints[5].z == boardPoints[9].z || boardPoints[5].z == boardPoints[13].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[6].z == boardPoints[2].z || boardPoints[6].z == boardPoints[10].z || boardPoints[6].z == boardPoints[14].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[7].z == boardPoints[3].z || boardPoints[7].z == boardPoints[11].z || boardPoints[7].z == boardPoints[15].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[8].z == boardPoints[0].z || boardPoints[8].z == boardPoints[4].z || boardPoints[8].z == boardPoints[12].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[9].z == boardPoints[1].z || boardPoints[9].z == boardPoints[5].z || boardPoints[9].z == boardPoints[13].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[10].z == boardPoints[2].z || boardPoints[10].z == boardPoints[6].z || boardPoints[10].z == boardPoints[14].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[11].z == boardPoints[3].z || boardPoints[11].z == boardPoints[7].z || boardPoints[11].z == boardPoints[15].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[12].z == boardPoints[0].z || boardPoints[12].z == boardPoints[4].z || boardPoints[12].z == boardPoints[8].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[13].z == boardPoints[1].z || boardPoints[13].z == boardPoints[5].z || boardPoints[13].z == boardPoints[7].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[14].z == boardPoints[2].z || boardPoints[14].z == boardPoints[6].z || boardPoints[14].z == boardPoints[10].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
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
       if (boardPoints[15].z == boardPoints[3].z || boardPoints[15].z == boardPoints[7].z || boardPoints[15].z == boardPoints[11].z) // Y column
         {
           flashing();
         }
       else //if there are none of the same color on Y column 
         {
           boolean b16y = true;
         }    
}



/*
levelComplete() and checkAllColors are the least efficient methods in my game. They are hard coded because I couldn't figure out a more efficient way to do what I wanted.
*/

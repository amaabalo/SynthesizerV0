class Board
{
  Button[][] buttonArray; // two-dimensional array of Button objects
  PVector corner; // coordinates of the center of the top-left Button object
  float innerSize;  // size of the inner square of a button
  float outerSize;  // size of the outer square of a button
  float paddingX;  // distance between left edge of board and left edge of window;
  float paddingY;  // distance between top edge of board and top edge of window;
  int bWidth;     // number of button  in the x-direction
  int bHeight;    // number of buttons in the y-direction
  color off;      // color of the button when it is off;
  color on;        // color of the button when it is on;
  color background; // color of the board's background
  color playing;     // color of column whose beats are currently playing
  int current;    // index of the the column whose beats are currently playing
  int prev;    // index of the column whose beats were previously played
  int playTime;  // number of milliseconds for which each column of beats plays
  long timeOff;  // time at which the next column of beats must be played
  SoundFile[] files;  // array of different sound files for board
  String[] soundNames;
  
  Board(float xC, float yC, int bW, int bH, float iS, float oS, color bOff, color bOn, color bG, color p, SoundFile[] f, int pT, String[] sN)
  {
    if (bW <= 0 || bH <= 0)
    {
      throw new IllegalArgumentException("Board dimensions must be greater than zero.");
    }
    corner = new PVector(xC, yC);
    bWidth = bW;
    bHeight = bH;
    innerSize = iS;
    outerSize = oS;
    paddingX = corner.x - (outerSize / 2);
    paddingY = corner.y - (outerSize / 2);
    buttonArray = new Button[bWidth][bHeight];
    off = bOff;
    on = bOn;
    background = bG;
    current = bWidth - 1;      
    playing = p;
    files = f;
    playTime = pT;
    soundNames = sN;
    timeOff = 0;
    float x;    // x-coordinate of Button object
    float y;    // y-coordinate of Button object
    for(int i = 0; i < bWidth; i++)
    {
      x = corner.x + i * outerSize;
      for(int j = 0; j < bHeight; j++)
      {
        y = corner.y + j * outerSize;
        buttonArray[i][j] = new Button(x, y, innerSize, outerSize, off, on, background, playing, files[j]);
      }
    }
  }
  
  /* Display the sequencer, playing the next column of beats every playTime seconds */
  void display()
  {
    if (millis() >= timeOff)
    {
      next();
      timeOff = millis() + playTime;
    }
    for(int i = 0; i < bWidth; i++)
    {
      for(int j = 0; j < bHeight; j++)
      {
        buttonArray[i][j].display();
      }
    }
  } 
  
  /* Determine which Button object a click falls within and turn on 'actual' button if it was clicked */
  void whichButton(float X, float Y)
  {
    float xCoordinate = X - paddingX;
    float yCoordinate = Y - paddingY;
    int i = int(xCoordinate / outerSize);
    int j = int(yCoordinate / outerSize);
    if (i < 0 || i >= bWidth || j < 0 || j >= bHeight)
    {
      // clicking outside of the board has no effect
      return;
    }
    Button B = buttonArray[i][j];
    if(withinBoundaries(B, X, Y))
    {
      buttonArray[i][j].state = (buttonArray[i][j].state + 1) % 2;
    }      
  }
  
  /* Check if 'actual' button was clicked */
  private boolean withinBoundaries(Button b, float xCoord, float yCoord)
  {
    float xLower = b.position.x - innerSize/2;
    float xUpper = xLower + innerSize;
    float yLower = b.position.y - innerSize/2;
    float yUpper = yLower + innerSize;
    if ((xCoord >= xLower) && (xCoord < xUpper) && (yCoord >= yLower) && (yCoord < yUpper))
    {
      return true;  
    }
    else
    {
      return false;
    }
  }
  
  /* Plays the next column of beats */
  void next()
  {
    prev = current;
    current = (current + 1) % bWidth;    
    for (int i = 0; i < bHeight; i++)
    {
      buttonArray[prev][i].playing = 0;
      buttonArray[current][i].playing = 1;
      if (buttonArray[current][i].state==1)
      {
        buttonArray[current][i].file.play();
      }
    } 
  }  
  
  void showLabels()
  {
    fill(0, 102, 153);
    textSize(25);
    textAlign(RIGHT);
    for (int i = 0; i < soundNames.length; i++)
    {     
      text(soundNames[i], corner.x - outerSize, corner.y + outerSize * (i + 0.125));
    }
  }
}
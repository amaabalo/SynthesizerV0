class Board
{
  Button[][] buttonArray;
  float xCorner;
  float yCorner;
  float innerSize;
  float outerSize;
  float paddingX;
  float paddingY;
  int bWidth;
  int bHeight;
  color off;
  color on;
  color background;
  color playing;
  int current;
  int prev;
  int playTime;
  long timeOff;
  
  Board(float xC, float yC, int bW, int bH, float iS, float oS, color bOff, color bOn, color bG, color p)
  {
    xCorner = xC;
    yCorner = yC;
    bWidth = bW;
    bHeight = bH;
    innerSize = iS;
    outerSize = oS;
    paddingX = xCorner - (outerSize / 2);
    paddingY = yCorner - (outerSize / 2);
    float x;
    float y;
    buttonArray = new Button[bWidth][bHeight];
    off = bOff;
    on = bOn;
    background = bG;
    current = bWidth - 1;
    prev = -1;
    playing = p;
    for(int i = 0; i < bWidth; i++)
    {
      x = xCorner + i * outerSize;
      for(int j = 0; j < bHeight; j++)
      {
        y = yCorner + j * outerSize;
        buttonArray[i][j] = new Button(x, y, innerSize, outerSize, off, on, background, playing);
      }
    }
    
    playTime = 300;
    timeOff = 0;
  }
  
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
  
  void whichButton(float X, float Y)
  {
    float xCoordinate = X - paddingX;
    float yCoordinate = Y - paddingY;
    int i = int(xCoordinate / outerSize);
    int j = int(yCoordinate / outerSize);
    Button B = buttonArray[i][j];
    //println(withinBoundaries(B, xCoordinate, yCoordinate));
    if(withinBoundaries(B, X, Y))
    {
      //println("yessss");
      buttonArray[i][j].state = (buttonArray[i][j].state + 1) % 2;
    }      
  }
  
  private boolean withinBoundaries(Button b, float xCoord, float yCoord)
  {
    float xLower = b.x - innerSize/2;
    float xUpper = xLower + innerSize;
    float yLower = b.y - innerSize/2;
    float yUpper = yLower + innerSize;
    //println("yes");
    println("Button coordinates: " + b.x + " " + b.y);
    println("Mouse coordinates: " + xCoord + " " + yCoord);
    println("Lower and upper boundaries: " + xLower + " " + xUpper + " " + yLower + " " + yUpper + " ");
    if ((xCoord >= xLower) && (xCoord < xUpper) && (yCoord >= yLower) && (yCoord < yUpper))
    {
      println("Clicked within button.");
      return true;  
    }
    else
    {
      println("Did not click within button.");
      return false;
      
    }
  }
  
  void next()
  {
    prev = current;
    current = (current + 1) % bWidth;    
    for (int i = 0; i < bHeight; i++)
    {
      buttonArray[prev][i].playing = 0;
      buttonArray[current][i].playing = 1;
    } 
  }
  
}
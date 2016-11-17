class Button
{
  float x;
  float y;
  float innerSize;
  float outerSize;
  int state;
  color [] stateColors;
  color outerColor;
  int playing;
  color [] playingColors;
  
  
  //SoundFile file;
  
  Button(float xP, float yP, float iS, float oS, color off, color on, color oC, color p)
  {
    x = xP;
    y = yP;
    innerSize = iS;
    outerSize = oS;
    stateColors = new color[2];
    stateColors[0] = off;
    stateColors[1] = on;
    outerColor = oC;
    state = 0;
    playingColors = new color[2];
    playingColors[0] = oC;
    playingColors[1] = p;
  }
  
  void display()
  {
    rectMode(CENTER);
    noStroke();
    fill(playingColors[playing]);
    rect(x, y, outerSize, outerSize);
    fill(stateColors[state]);
    rect(x, y, innerSize, innerSize);
  }
    
}
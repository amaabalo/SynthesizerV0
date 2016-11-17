class Button
{
  PVector position;  // position of the center of the Button ocject
  float innerSize;   // size of the inner square
  float outerSize;   // size of the outer square
  int state;        // Has this button been turned on or not?
  color [] stateColors; // colors of the inner square(the 'actual' button) when it is turned off (index 0), and when it is turned on (index 1)
  int playing;    // Is it the time for this beat to play or not?
  color [] playingColors; // colors of the outer square when its beat is not being played (index 0), and when it is being played (index 1)
  SoundFile file;  // the sound/beat associated with this button
  
  Button(float xP, float yP, float iS, float oS, color off, color on, color oC, color p, SoundFile f)
  {
    if (iS < 0)
    {
      throw new IllegalArgumentException("Size of inner square cannot be less than 0.");
    }
    if (oS <= 0)
    {
      throw new IllegalArgumentException("Size of outer square must be greater than zero.");
    }
    if (iS > oS)
    {
      throw new IllegalArgumentException("Size of inner square must be less than or equal to size of outer square.");
    }
    
    position =  new PVector(xP, yP);
    innerSize = iS;
    outerSize = oS;
    stateColors = new color[2];
    stateColors[0] = off;
    stateColors[1] = on;
    state = 0;
    playingColors = new color[2];
    playingColors[0] = oC;
    playingColors[1] = p;
    file = f;
  }
  
  void display()
  {
    rectMode(CENTER);
    noStroke();
    fill(playingColors[playing]);
    rect(position.x, position.y, outerSize, outerSize);
    fill(stateColors[state]);
    rect(position.x, position.y, innerSize, innerSize);
  }    
}
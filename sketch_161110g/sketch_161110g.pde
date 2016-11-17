import processing.sound.*;
SoundFile f;
Button[][] buttonArray;
int   g_SpeakerWidth     = 32; //number of speakers in x-direction
int   g_SpeakerHeight    = 12; //number of speakers in y-direction (cell dimensions will be calculated by dividing this by two)
float xI = 25;
float yI = 25;
float x;
float y;
Board b;
color off;
color on;
color background;
color playing;
color notPlaying;
PVector topLeft;
Button c;
void setup()
{
  f = new SoundFile(this, "trash_clap.mp3");
  size(2240, 840);
  //off = color(137, 207, 240);
  off = color(255);
  on = color(0,200,0);
  background = color(50);
  notPlaying = background;
  playing = color(200, 0, 0);
  topLeft = new PVector(35, 35);
  
  b = new Board(topLeft.x, topLeft.y, 32, 12, 40, 70, off, on, background, playing);
  
  //b.display();
}

void draw()
{
  b.display();
}

void mouseReleased()
{
  f.play();
  b.whichButton(mouseX, mouseY);
}
import processing.sound.*;

/* A Board contains a matrix of Button  objects. Each Button is two squares - a smaller square
 * displayed on top of a larger square. The smaller inner square is the 'actual' button, i.e.
 * the part that can be clicked to turn a beat on or off. The larger outer square forms the 
 * background of the board when all the buttons are arranged next to each other
 */

Board b;  // Sequencer object
PVector topLeft;  // coordinates of the center of the top-left button object
int   boardWidth; // number of buttons in the x-direction
int   boardHeight; // number of speakers in y-direction (cell dimensions will be calculated by dividing this by two)
float innerSize;  // size of the inner square of a button
float outerSize;  // sze of the outer square of a button
color off;         // color of the button when it is off;
color on;          // color of the button when it is on
color background;  // color of the board's background
color playing;     // color of the column whose beats are currently playing
int playTime;      // number of milliseconds for which each column of beats plays
// list of names of sound files for the board
String [] fileNames = {"trash_clap.mp3", "trash_cowbell.mp3", "trash_cymbal.mp3", "trash_hhclosed.mp3", "trash_hhopen.mp3", "trash_kick.mp3", "trash_rimshot.mp3", "trash_snare.mp3", "trash_tom.mp3"};
// list of names of sounds
String [] soundNames = {"Clap", "Cowbell", "Cymbal", "Closed Hi Hat", "Open Hi Hat", "Kick", "Rimshot", "Snare", "Tom"};
SoundFile[] sounds;  // array of sound files

void setup()
{
  size(775, 630);
  
  background(230);
  topLeft = new PVector(250, 35);
  boardWidth = 8;
  boardHeight = fileNames.length; // there are only as many rows as there are different sounds
  innerSize = 40;
  outerSize = 70;
  off = color(255);      
  on = color(0,250,0);
  background = color(50);
  playing = color(200, 0, 0);  
  playTime = 250;
  sounds = new SoundFile[fileNames.length];
  for (int i = 0; i < fileNames.length; i++)
  {
    sounds[i] = new SoundFile(this, fileNames[i]); 
  }
  b = new Board(topLeft.x, topLeft.y, boardWidth, boardHeight, innerSize, outerSize, off, on, background, playing, sounds, playTime, soundNames);
  b.showLabels();
  println ("Click on a button to turn it on (green) or off (white). The beat for that button will be played when it lies within the red strip.");
}

void draw()
{
  b.display();
}

void mouseReleased()
{
  b.whichButton(mouseX, mouseY);
}
/**
 * This sketch shows how to use the Waveform class to analyze a stream
 * of sound. Change the number of samples to extract and draw a longer/shorter
 * part of the waveform.
 */

import processing.sound.*;

// Declare the sound source and Waveform analyzer variables
SoundFile sample;
Waveform waveform;

// Define how many samples of the Waveform you want to be able to read at once
int samples = 100;

public void setup() {
  size(720, 1280);
  background(255);

  // Load and play a soundfile and loop it.
  sample = new SoundFile(this, "daftpunk.mp3");
  sample.rate(2);
  sample.loop();

  // Create the Waveform analyzer and connect the playing soundfile to it.
  waveform = new Waveform(this, samples);
  waveform.input(sample);
}

public void draw() {
  // Set background color, noFill and stroke style
  background(0);
  stroke(255);
  strokeWeight(2);
  noFill();

  // Perform the analysis
  waveform.analyze();
  
  int shapes = 10;
  for(int j = 0; j < shapes-1; j++){
    beginShape();
    vertex(0, (100*j)+70);
    vertex(200,(100*j)+70);
    
    //draw the sampled active data
    for(int i = (samples/shapes)*j; i < (samples/shapes)*(j+1); i++){
      // Draw current data of the waveform
      // Each sample in the data array is between -1 and +1 
      vertex(
        map(i, (samples/shapes)*j, (samples/shapes)*(j+1), 200, 520), //width
        map(waveform.data[i], -1, 1, 0+(j*70), 70+(j*120))//height
      );
    }
    
    vertex(520, (100*j)+70);
    vertex(720,(100*j)+70);
    endShape();
  }
  delay(200);
  /*
  beginShape();
  for(int i = 0; i < samples/10; i++){
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1 
    vertex(
      map(i, 0, samples/10, 20, 700), //width
      map(waveform.data[i], -1, 1, 0, 200)//height
    );
  }
  endShape();
  */
}

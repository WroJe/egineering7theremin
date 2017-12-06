/**
 * Processing Sound Library, Example 1
 * https://processing.org/tutorials/sound/
 * Five sine waves are layered to construct a cluster of frequencies. 
 * This method is called additive synthesis. Use the mouse position 
 * inside the display window to detune the cluster.
 */

import processing.sound.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class


SinOsc[] sineWaves; // Array of sines
float[] sineFreq; // Array of frequencies
int numSines = 5; // Number of oscillators to use


int prev;
int counter;

void setup() {  
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  portName = "/dev/ttyUSB0";
  myPort = new Serial(this, portName, 9600);


  size(640, 360);
  background(255);

  sineWaves = new SinOsc[numSines]; // Initialize the oscillators
  sineFreq = new float[numSines]; // Initialize array for Frequencies

  for (int i = 0; i < numSines; i++) {
    // Calculate the amplitude for each oscillator
    float sineVolume = (1.0 / numSines) / (i + 1);
    // Create the oscillators
    sineWaves[i] = new SinOsc(this);
    // Start Oscillators
    sineWaves[i].play();
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);
  }
  
  counter = 0;
  prev = 0;
}

void draw() {

  String sval="";     // Data received from the serial port

  if ( myPort.available() > 0) 
  {  // If data is available,
    sval = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  println("sval="+sval); //print it out in the console

    int ival = getNum(sval);    
    println("ival="+ival);
   
   if (ival<1) {
     if (counter<5) {
       ival = prev;
       counter++;
     }
     else
       ival = 0;
   }
   else{
     counter = 0;
     prev = ival;
   }
    float frequency=0;
    float detune = 0;
    // fix sound
    if (ival>10 && ival<40) frequency = 261.62;    // C
    
    float v1=40.0, v2=110.0;
    float f1=261.62, f2 = 277.18;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // C->C#
  
    
    v1=110; v2=210;
    f1=277.18; f2 = 293.66;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // C# -> D
    
    v1=210; v2=272.5;
    f1=293.66; f2 = 311.12;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // D-D#
        
    v1=272.5; v2=360;
    f1=311.12; f2 = 329.62;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // D#-E
   
    v1=360; v2=460;
    f1=329.62; f2 = 349.22;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // E->F

    v1=460; v2=570;
    f1=349.22; f2 = 369.99;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // F->F#
     
    v1=570; v2=640;
    f1=369.99; f2 = 391.99;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // F#-G

    v1=640; v2=730;
    f1=391.99; f2 = 415.305;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // G->G#
        
    v1=730; v2=820;
    f1=415.305; f2 = 440.000;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // G#-A
        
    v1=820; v2=905;
    f1=440.000; f2 = 466.164;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // A-A#
   
    v1=905; v2=1023;
    f1=466.64; f2 = 493.88;
    if (ival>v1 && ival<v2) 
        frequency = f1+(ival-v1)/(v2-v1)*(f2-f1);  // D#-E

    
    
   // if (ival>190 && ival<230) frequency = 293.66;  // D
 //   if (ival>230 && ival<315) frequency = 311.12;  // D#
   // if (ival>315 && ival<410) frequency = 329.62;  // E
  //  if (ival>410 && ival<510) frequency = 349.22;  // F
  //  if (ival>510 && ival<610) frequency = 369.99;  // F#
//    if (ival>610 && ival<680) frequency = 391.99;  // G
//    if (ival>680 && ival<760) frequency = 415.305;  // G#
//    if (ival>760 && ival<840) frequency = 440.000;  // A
//    if (ival>840 && ival<930) frequency = 466.164;  // A#
 //   if (ival>930 && ival<1024) frequency = 493.88;  // B
    
    
   

    


    for (int i = 0; i < numSines; i++) { 
        sineFreq[i] = frequency * (i + 1 * detune);
        // Set the frequencies for all oscillators
        sineWaves[i].freq(sineFreq[i]);
    }
    
    /*
    if (ival >100) {



      //Map mouseY from 0 to 1
      float yoffset = map(mouseY, 0, height, 0, 1);
      if ( ival < 512)
          yoffset = map(ival, 0, 512, 0, 0.75);
      else
          yoffset = map(ival, 512, 1024, 0.75, 1);
      
      //Map mouseY logarithmically to 150 - 1150 to create a base frequency range
      float frequency = pow(1000, yoffset) + 150;
      //Use mouseX mapped from -0.5 to 0.5 as a detune argument
      float detune = map(mouseX, 0, width, -0.5, 0.5);

      for (int i = 0; i < numSines; i++) { 
        sineFreq[i] = frequency * (i + 1 * detune);
        // Set the frequencies for all oscillators
        sineWaves[i].freq(sineFreq[i]);
      }
    }
    */
}


int getNum(String s){
  if(s==null) return -1;
  
  String out="";
  for(int i=0;i<s.length();i++){
    char c=s.charAt(i);
    if(isNum(c))
      out+=c;
  }
  
  if (out.length()==0) return -1;
  return Integer.parseInt(out);
  
}



boolean isNum(char c){
  
  if(c>='0' && c <= '9')
    return true;
    else
      return false;
}
/*Note: In order for this class to work you must install the Sound library made by Processing **/
import processing.sound.*;
//Global variables for visualize() 
int bands = 128; //Bands present for frequency spectrum
float bandWidth = width/7; //Width of each band/rectangle
float[] sum = new float [bands]; 
float smoothFactor = 0.2; //Smoothens out the fall and rise of bands
//Global components and Booleans
SoundFile music;
FFT fft;
LowPass lowPass;
HighPass highPass;
BandPass bandPass;
FilterSlider lowSlider;
FilterSlider highSlider;
Button playbutton;
Button submitbutton;
Button clearbutton;
TextBox lowPassValue;
TextBox highPassValue;
TextBox lowFreqBand;
TextBox highFreqBand;
boolean isPlaying = false;
boolean lowPassOn = false; //Checks whether lowPass filter is on
boolean highPassOn = false;
boolean bandPassOn = false;


void setup() {
  size(1024, 512);
  colorMode(HSB);
  initializeVariables();
}

void initializeVariables() {
  music = new SoundFile(this, "Song1.wav"); //Switch between Song1 and Song2 
  fft = new FFT(this, bands); //instance of fft object, used to analyze the spectrum of frequencies found in the song
  lowPass = new LowPass(this);  //instace of the low Pass filter object
  highPass = new HighPass(this);
  bandPass = new BandPass(this);
  lowSlider = new FilterSlider(width/6, "Low Pass"); // slider for low pass filter
  highSlider = new FilterSlider(width/4+150, "High Pass"); //high pass filter
  playbutton = new Button(50, "Play", "Pause");
  submitbutton = new Button(width/1.5+156, "Submit", "Submit");
  clearbutton = new Button(width/1.5 + 250, "CLEAR", "CLEAR");
  lowFreqBand = new TextBox(width/2+125, 15, 20, ""); //Lower range of band pass filter
  highFreqBand = new TextBox(width/2+225, 15, 20, ""); //Higher range of band pass
  lowPassValue = new TextBox (width/6+50, 38, 15, "");
  highPassValue = new TextBox (width/3+120, 38, 15, "");
}

void draw() {
  background(0);
  fill(255);
  dashedLine(width*1/3, width*1/3, 56, height, 50); 
  dashedLine(width*2/3, width*2/3, 56, height, 50);
  //Analyze frequency spectrum of music and visualize it
  visualize();
  //Interface details
  fill(255);
  rect(0, 0, width, 65); //Creats a 'control panel'
  fill(120);
  stroke(0);
  rect(0, 0, width, 60);
  fill(255);
  textSize(15);
  text("BandPass", width/1.5+25, 48);

  //Display Interface Components
  lowSlider.displaySlider();
  highSlider.displaySlider();
  lowPassValue.displayTextBox();
  highPassValue.displayTextBox();
  playbutton.displayButton();
  submitbutton.displayButton();
  clearbutton.displayButton();
  lowFreqBand.displayTextBox();
  highFreqBand.displayTextBox();

  //Call to the low pass filter method 
  if (lowPassOn ) { 
    lowPass();
  }
  //Calls high pass filter method
  if (highPassOn) { 
    highPass();
  }
  //Calls band pass filter method
  if (bandPassOn) {
    bandPass();
  }
}

void visualize() {  //Processing's Sound tutorial (Example 5, 6:Audio Analysis)
  fft.analyze(); //Calculates the frequency spectrum which is returned as an array. Accesed via fft.spectrum[]
  for (int i = 0; i < sum.length; i++) {
    //The sum[] array utilized smoothen out the values of the spectrum[]
    sum[i] += (fft.spectrum[i] - sum[i]) * smoothFactor; 
    fill(i*3, 255, 255); //Creates a color gradient
    rect( i*bandWidth, height, bandWidth-2, -sum[i]*(height-55)*10 ); //Rectangles are drawn representing a frequency band
  }
}

//Filter Methods
void lowPass() {  ///https://p5js.org/examples/sound-filter-lowpass.html
  float mappedLowFreq = map(lowSlider.getSliderX(), 0, lowSlider.length, 20, 10000); //mapping the slider length 20-10000 hz 
  lowPass.freq(mappedLowFreq); 
  lowPassValue.setText(mappedLowFreq);
  lowPass.process(music);
}
void highPass() { //https://processing.org/reference/libraries/sound/HighPass.html
  float mappedHighFreq = map(-highSlider.getSliderX(), 0, -highSlider.length, 2000, 10000); //invert the mapping, moving the slider left makes the frequency increase
  highPass.freq(mappedHighFreq);
  highPassValue.setText(mappedHighFreq);
  highPass.process(music);
}
void bandPass() { //https://processing.org/reference/libraries/sound/BandPass.html
  try {
    float lowBand = lowFreqBand.getBandValue(); //Takes lower frequency inputted via the textbox 
    float highBand = highFreqBand.getBandValue(); 
    bandPass.process(music, lowBand, highBand); //Applies low-high frequency (bandpass) on music playing
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void playMusic(SoundFile music) { //Handles the playing of music
  isPlaying = true; 
  try { 
    if (playbutton.buttonClicked() && !music.isPlaying()) { //(Starting state) Play button is pressed, but no music is playing
      music.play(); 
      fft.input(music);
    }
    if (playbutton.buttonClicked() && music.isPlaying()) { //Pauses music
      music.pause();
    }
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void stopFilters() {
  try {
    if (lowPassOn) {
      lowPass.stop(); //Removes filter
      lowPassOn = !lowPassOn;
      lowSlider.resetPositionX(); //Resets position to its starting phase
    } else if (highPassOn) {
      highPass.stop();
      highPassOn = !highPassOn;
      highSlider.resetPositionX();
    }
    else if(bandPassOn){
    bandPass.stop();
    bandPassOn = !bandPassOn;
    lowFreqBand.resetText();
    highFreqBand.resetText();
  } }
  catch(Exception e) {
    e.printStackTrace();
  }
}
//Event handlers
void mouseClicked() {
  if (playbutton.buttonClicked() ) {
    playMusic(music);
  } else if (clearbutton.buttonClicked() ) {
    stopFilters();
    lowPassValue.resetText();
    highPassValue.resetText();
  }
  playbutton.buttonSelected();
  submitbutton.buttonSelected();
  clearbutton.buttonSelected();
  lowFreqBand.textBoxSelected();
  highFreqBand.textBoxSelected();
}

void mouseDragged() {
  if (lowSlider.sliderSelected()) {
    lowPassOn = true;
  }  
  if (highSlider.sliderSelected()) {
    highPassOn = true;
  }  
  if (lowFreqBand.textBoxSelected()) {
    bandPassOn = true;
  }
  highSlider.sliderDragged();
  lowSlider.sliderDragged();
}

void keyPressed() { //Handles event for typing the BandPass values(low and high)
  lowFreqBand.keyPress(key, keyCode);
  highFreqBand.keyPress(key, keyCode);
}


//For UI: Creates a dashed line, to separate between the bass, the mid and the treble
void dashedLine(float xstart, float xend, float ystart, float yend, float detail) { 
  noStroke();
  for (int i =0; i <= detail; i++) {
    float x = lerp(xstart, xend, i/detail);
    float y = lerp(ystart, yend, i/detail);
    ellipse(x, y, 3, 3);
  }
}


class FilterSlider {
  public int x;
  public int y = 5;
  public int w = 30;
  public int h = 30;
  public int sliderPosition; //stores current position of the 'ellipse' (main slider component)
  public int length = 200; 
  public String filterLable; //text placed underneath the slider as identifier

  FilterSlider(int xPosition, String lable) { //Passed an x and Lable for the slider 
    x = xPosition;
    sliderPosition = xPosition+length;
    filterLable = lable;
  }

  void displaySlider() {
    //Rectangle to border the slider
    strokeWeight(1);
    stroke(255);
    fill(40);
    rect(x, y, length, h);

    //Text to lable the slider 
    fill(255);
    textSize(15);
    text(filterLable, x+length/2-w, y+w);

    //Line to 'slide' on
    strokeWeight(5);
    stroke(255);
    line(x+5, y+w/2, x+length-5, y+w/2); 

    //Circle element of the slider
    if (sliderSelected()) {
      fill(110); //Changes color indicating a click
    } else {
      fill(220);
    }
    noStroke();
    ellipse (sliderPosition-h/4, y+w/2, w/2, h/2); 
  }

  private void sliderDragged() {//Changes direction of Slider according to the mouse
    if (sliderSelected()) { 
      sliderPosition = mouseX; 
      sliderPosition = constrain(sliderPosition, x+h/2, x+length-h/12); 
      //Slider can only move between the length of itself (left to right)
    }
  }
  private boolean sliderSelected() { //Verifies slider has been clicked 
    if (mouseX > (sliderPosition -w/2) && mouseX < (sliderPosition + w/2) ) {
      if (mouseY > y+w/2 - h/2 && mouseY < y+w/2 + h/2) {
        return true;
      }
    }
    return false;
  }
  private float getSliderX() { //Used for either low or high pass filter, by getting the current position of the slider
    float sliderPos = (float)(sliderPosition - x);
    return sliderPos;
  }
  private void resetPositionX() {
    sliderPosition = x+length-h/12; //Resests to starting position
    sliderPosition = constrain(sliderPosition, x+h/2, x+length-h/12); 
  }
}

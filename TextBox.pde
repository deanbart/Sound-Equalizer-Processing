
class TextBox {
  float x;
  float y;
  int h;
  int w = 100;
  int textSize = 15;
  String text;
  int textLength = 0;
  boolean textBoxClicked = false;

  TextBox(float X, float Y, int H, String Text) {
    x=X;  
    y=Y;
    h=H;
    text = Text;
  }

  void displayTextBox() { 
    fill(255);
    stroke(0);
    strokeWeight(1);
    if (textBoxClicked) {
      fill(9, 150, 234); //Change the color, to signify a click has occured
    }
    rect(x, y, w, h); 
    fill(0);
    textSize(textSize);
    text(text, x + (textWidth("a") / 2), y + textSize); //display text, according to the placement of the textbox
  }

  private void keyPress(char KEY, int KEYCODE) { //Handles keyboard input
    if (textBoxSelected()) {
      boolean isKeyNumber = (KEY >= '0' && KEY <= '9');   
      boolean isKeyBackSpace = (KEYCODE ==8);
      boolean isKeyDecimalPoint = (KEYCODE == 46);
      if (isKeyNumber||isKeyDecimalPoint) {
        displayText(KEY);
      } else if (isKeyBackSpace) {
        backSpace();
      }
    }
  }

  private void backSpace() { //Handles backspaces via user input
    try {
      if (textLength - 1 >= 0) {
        text = text.substring(0, textLength - 1);
        textLength--;
      }
    }
    catch(Exception e) {
      System.out.println("Error");
    }
  }

  private void displayText(char userInput) {
    if (textWidth(text + userInput)< w) { //ensures text doesnt run outside the textbox
      text += userInput;
      textLength++;
    }
  }
  private float getBandValue() { //Retrieves text within the textbox and parses it to a usable float 
    float bandValue = Float.parseFloat(text);
    return bandValue;
  }
  boolean textBoxSelected() {
    if (mouseX >= x && mouseX <= x + w) {
      if (mouseY >= y && mouseY <= y + h) {
        return textBoxClicked = true;
      }
    }
    return textBoxClicked = false;
  }
  private void setText(float value) { //Used to display the slider values for low and high pass filters
    value = round(value);
    text = Float.toString(value);
    text = text.substring(0, text.length() - 2); //Removes unnecesary '.0' decimal place
    text += "Hz";
  }
  private void resetText() { //Used to clear the current text
    text = "";
  }
}

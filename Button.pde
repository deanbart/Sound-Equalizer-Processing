
class Button {
  float x;
  int y = 15;
  int w = 60;
  int h = 20;
  boolean selected = false; //boolean set to true when button is selected
  String buttonLable;
  String buttonLable2;
  String currentLable; //Intermediary lable used to swap between the 2

  Button(float xPos, String lable, String lable2) {
    x = xPos;
    buttonLable = lable;
    buttonLable2 = lable2;
    currentLable = buttonLable;
  }
  void displayButton() {
    fill(255);
    strokeWeight(2);
    stroke(0);
    rect(x, y, w, h, 3); //Create button
    fill(0);
    textSize(12);
    text(currentLable, x+10, h/2+y+4); //Create text within the button
  }
  private void buttonSelected() { //Alternate between lables with each click
    if (buttonClicked()) {
      fill(9, 150, 234);
      rect(x, y, w, h, 3); //Indicator that the user has clicked
      currentLable = buttonLable;
    }
    if (buttonClicked() && selected) {
      currentLable = buttonLable2;
    }
  }
  private boolean buttonClicked() {
    if (mouseX >= x && mouseX <= x+w) { //Mouse clicked within the range of the button component
      if (mouseY >= y && mouseY <= y+h) {
        selected = !selected;
        return true;
      }
    }
    return false;
  }
}

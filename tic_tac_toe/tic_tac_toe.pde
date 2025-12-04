void setup() {
  size(500, 500);
  initGame();
}

void draw() {
  renderBoard();
}

void keyPressed() {
  handleKeyPress();
}

void drawBoard() {
  stroke(0);
  for (int i = 1; i < BOARD_SIZE; i++) {
    line(i * CELL_SIZE, 0, i * CELL_SIZE, CANVAS_SIZE);
    line(0, i * CELL_SIZE, CANVAS_SIZE, i * CELL_SIZE);
  }
}

void drawX(int row, int col) {
  float x = col * CELL_SIZE;
  float y = row * CELL_SIZE;
  line(x + 20, y + 20, x + CELL_SIZE - 20, y + CELL_SIZE - 20);
  line(x + 20, y + CELL_SIZE - 20, x + CELL_SIZE - 20, y + 20);
}

void drawO(int row, int col) {
  float x = col * CELL_SIZE + CELL_SIZE/2;
  float y = row * CELL_SIZE + CELL_SIZE/2;
  ellipse(x, y, CELL_SIZE - 40, CELL_SIZE - 40);
}

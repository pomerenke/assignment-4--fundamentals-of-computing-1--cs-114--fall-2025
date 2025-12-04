int[][] board;
boolean gameOver = false;

void initGame() {
  board = new int[BOARD_SIZE][BOARD_SIZE];
  for (int r = 0; r < BOARD_SIZE; r++) {
    for (int c = 0; c < BOARD_SIZE; c++) {
      board[r][c] = EMPTY;
    }
  }
  computerMove();
}

void renderBoard() {
  background(255);
  drawBoard();
  for (int r = 0; r < BOARD_SIZE; r++) {
    for (int c = 0; c < BOARD_SIZE; c++) {
      if (board[r][c] == USER) {
        drawO(r, c);
      } else if (board[r][c] == COMP) {
        drawX(r, c);
      }
    }
  }
}

void handleKeyPress() {
  if (gameOver) {
    println("Game has ended.");
    return;
  }

  if (key >= '0' && key <= '8') {
    int move = key - '0';
    int row = move / BOARD_SIZE;
    int col = move % BOARD_SIZE;

    if (board[row][col] == EMPTY) {
      board[row][col] = USER;
      checkGameState();

      if (!gameOver) {
        computerMove();
        checkGameState();
      }
    } else {
      println("Square already taken.");
    }
  } else {
    println("Incorrect key pressed.");
  }
}

void computerMove() {
  if (tryCompleteLine(COMP)) return;
  if (tryCompleteLine(USER)) return;

  ArrayList<int[]> emptySquares = new ArrayList<int[]>();
  for (int r = 0; r < BOARD_SIZE; r++) {
    for (int c = 0; c < BOARD_SIZE; c++) {
      if (board[r][c] == EMPTY) {
        emptySquares.add(new int[]{r, c});
      }
    }
  }

  if (emptySquares.size() > 0) {
    int[] choice = emptySquares.get((int)random(emptySquares.size()));
    board[choice[0]][choice[1]] = COMP;
  }
}

boolean tryCompleteLine(int player) {
  for (int r = 0; r < BOARD_SIZE; r++) {
    if (countLine(board[r][0], board[r][1], board[r][2], player)) {
      for (int c = 0; c < BOARD_SIZE; c++) {
        if (board[r][c] == EMPTY) {
          board[r][c] = COMP;
          return true;
        }
      }
    }
  }
  for (int c = 0; c < BOARD_SIZE; c++) {
    if (countLine(board[0][c], board[1][c], board[2][c], player)) {
      for (int r = 0; r < BOARD_SIZE; r++) {
        if (board[r][c] == EMPTY) {
          board[r][c] = COMP;
          return true;
        }
      }
    }
  }
  if (countLine(board[0][0], board[1][1], board[2][2], player)) {
    if (board[0][0] == EMPTY) { board[0][0] = COMP; return true; }
    if (board[1][1] == EMPTY) { board[1][1] = COMP; return true; }
    if (board[2][2] == EMPTY) { board[2][2] = COMP; return true; }
  }
  if (countLine(board[0][2], board[1][1], board[2][0], player)) {
    if (board[0][2] == EMPTY) { board[0][2] = COMP; return true; }
    if (board[1][1] == EMPTY) { board[1][1] = COMP; return true; }
    if (board[2][0] == EMPTY) { board[2][0] = COMP; return true; }
  }
  return false;
}

boolean countLine(int a, int b, int c, int player) {
  int countPlayer = 0;
  int countEmpty = 0;
  if (a == player) countPlayer++; else if (a == EMPTY) countEmpty++;
  if (b == player) countPlayer++; else if (b == EMPTY) countEmpty++;
  if (c == player) countPlayer++; else if (c == EMPTY) countEmpty++;
  return (countPlayer == 2 && countEmpty == 1);
}

void checkGameState() {
  int winner = checkWinner();
  if (winner == USER) {
    println("User wins!");
    gameOver = true;
  } else if (winner == COMP) {
    println("Computer wins!");
    gameOver = true;
  } else if (isBoardFull()) {
    println("No one has won.");
    gameOver = true;
  } else {
    println("Game still in play.");
  }
}

int checkWinner() {
  for (int r = 0; r < BOARD_SIZE; r++) {
    if (board[r][0] != EMPTY && board[r][0] == board[r][1] && board[r][1] == board[r][2]) {
      return board[r][0];
    }
  }
  for (int c = 0; c < BOARD_SIZE; c++) {
    if (board[0][c] != EMPTY && board[0][c] == board[1][c] && board[1][c] == board[2][c]) {
      return board[0][c];
    }
  }
  if (board[0][0] != EMPTY && board[0][0] == board[1][1] && board[1][1] == board[2][2]) return board[0][0];
  if (board[0][2] != EMPTY && board[0][2] == board[1][1] && board[1][1] == board[2][0]) return board[0][2];

  return EMPTY;
}

boolean isBoardFull() {
  for (int r = 0; r < BOARD_SIZE; r++) {
    for (int c = 0; c < BOARD_SIZE; c++) {
      if (board[r][c] == EMPTY) return false;
    }
  }
  return true;
}

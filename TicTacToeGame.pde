/* ----------COLOUR PALETTE-----------
Dark red: 120, 0, 0
Red: 193, 18, 31
Cream: 253, 240, 213
Navy blue: 0, 48, 73
Azure: 102, 155, 188
-------------------------------------- */

import java.util.*;
import java.lang.Math;

// DO NOT TOUCH BELOW

// VARIABLES

// Instantiante Button objects
Button buttonTicTacToe; // Button to play TTT
Button buttonQuit; // Button to quit game after starting
Button buttonSingle;
// Buttons have to be assigned in setup() as width and height are not defined yet

// Declare booleans for what "screen" to run
boolean runHomeScreen = true;
boolean runTicTacToe = false;
boolean showWinner = false;
boolean runSinglePlayer = false;
// If true, draw() method will display the screen

// If true, clear the board to draw a new board/reset the game when game is started
boolean clearBoard = true;

int time = millis();

// ArrayList to store all the games that can be played in this program:
// Future games can be added to gameList ArrayList
ArrayList<Game> gameList = new ArrayList<Game>();

// Instantiate new game that will store the current game if/when there is one
Game currentGame; // Make board an attribute of Game?

// Store the number of clicks when homeScreen is started until a new game is created
int clicks = 0;
// Solves the issue where clicking on the New Game button in home screen immediately marks the board at where the button is

void settings() {
    // Create window
    
    // Big window:
    // size((int) (displayWidth * 0.95), (int) (displayHeight * 0.9));  
    
    // Square window:
    size((int) (displayHeight * 0.8), (int) (displayHeight * 0.8));
}

void setup() { // Contains Game List.
    // Fill background to cream colour
    background(253, 240, 213);
    
    // Make sure drawn shapes do not have a stroke
    noStroke();

    // Set the params of shapes and text are the center coordinate
    textAlign(CENTER, CENTER);
    rectMode(CENTER);    
    ellipseMode(CENTER);
    
    // Create buttons that will be displayed
    buttonTicTacToe = new Button("Tic-Tac-Toe", (width/2), height/2, 350, 80); // Button to play TTT
    buttonQuit = new Button("quit", 110, 50, 150, 50); // Button to quit game after starting
    buttonSingle = new Button("Single Player", (width/2), (height/2) + 100, 350, 80);

    // Add all games to gameList ArrayList
    gameList.add(new TicTacToe());
    gameList.add(new SinglePlayerTicTacToe());
}
// DO NOT TOUCH ABOVE


void draw() {
    // When runHomeScreen = true, it runs the homeScreen method
    if(runHomeScreen) {
        homeScreen();
    }
    
    // When TicTacToe button is pressed, it makes the condition to be true
    // Then runs the code needed to play the game
    if(runTicTacToe) {
        // Set game board to the currentGame board (TicTacToe)
        int[][] board = currentGame.getBoard();
        
        // Traverse through every element in the array:
        for(int r = 0; r < board.length; r++) {
            for(int c = 0; c < board[0].length; c++) {
                // If the element is marked by Player 1, draw X
                if(board[r][c] == 1) {
                    // Draw X
                    currentGame.drawX(currentGame.getBoardCoords(r,c));
                } else if(board[r][c] == 2) {
                    // If the element is marked by Player 2, draw O
                    currentGame.drawO(currentGame.getBoardCoords(r,c));
                }
            }
        }
    }

    if(runSinglePlayer) {
        // Set game board to the currentGame board (TicTacToe)
        int[][] board = currentGame.getBoard();
        
        // Traverse through every element in the array:
        for(int r = 0; r < board.length; r++) {
            for(int c = 0; c < board[0].length; c++) {
                // If the element is marked by Player 1, draw X
                if(board[r][c] == 1) {
                    // Draw X
                    currentGame.drawX(currentGame.getBoardCoords(r,c));
                } else if(board[r][c] == 2) {
                    // If the element is marked by Player 2, draw O
                    currentGame.drawO(currentGame.getBoardCoords(r,c));
                }
            }
        }
    }
    
    // When there is a winner, the showWinner() method is called after mouse is clicked and makes showWinner condition true
    // If/when true, program displays the winner for 1.3 seconds before returning to the home screen
    if(showWinner) {
        delayTime(1300);
        homeScreen();
    }

}

// Runs after mouse pressed and released
void mouseClicked() {
    // Add one click to clicks
    clicks++;

    // RUN DURING HOME SCREEN
    if(runHomeScreen) { 
        // If Tictactoe Button pressed, start the game
        if(mouseX >= buttonTicTacToe.getLeft() && mouseX <= buttonTicTacToe.getRight()) {
            if(mouseY >= buttonTicTacToe.getTop() && mouseY <= buttonTicTacToe.getBottom()) {
                System.out.println("\nPlaying Tic-Tac-Toe");
                startTicTacToe();
            }
        }

        if(mouseX >= buttonSingle.getLeft() && mouseX <= buttonSingle.getRight()) {
            if(mouseY >= buttonSingle.getTop() && mouseY <= buttonSingle.getBottom()) {
                System.out.println("\nPlaying Single Player");
                startSingle();
            }
        }
    } else { 
        // The following is run during games
        
        // If quit button clicked, return to home screen:
        if(mouseX >= buttonQuit.getLeft() && mouseX <= buttonQuit.getRight()) {
            if(mouseY >= buttonQuit.getTop() && mouseY <= buttonQuit.getBottom()) {
                currentGame.reset();
                System.out.println("\nReturning to home screen...\n");
                homeScreen();
            }
        }
    }

    // Mark player move on board if mouse pressed during a game
    if(!runHomeScreen && (clicks != 0)) {
        currentGame.mark();
        currentGame.checkForWinner();
    }
}

void homeScreen() {
    // Set window title to Home
    surface.setTitle("Home");

    // (Re)set variables
    runHomeScreen = true;
    runTicTacToe = false;
    runSinglePlayer = false;
    showWinner = false;

    // Set clearBoard to true as starting a game requires board to clear
    clearBoard = true;

    // Clear background
    background(253, 240, 213);
    
    // DRAW GAME TITLE
    fill(102, 155, 188);
    textSize(104);
    text("Tic-Tac-Toe", width/2, height/2 - 200);

    // DRAW TICTACTOE BUTTON
    textSize(30);
    fill(102, 155, 188);
    buttonTicTacToe.drawButton();
    fill(255);
    text("New Game", width/2, height/2);

    // DRAW SINGLE PLAYER BUTTON
    textSize(30);
    fill(102, 155, 188);
    buttonSingle.drawButton();
    fill(255);
    text("Single Player Mode", width/2, buttonSingle.getY());
}

void showWinner() {  
    // Set conditions
    showWinner = true;
    runTicTacToe = false;
    runSinglePlayer = false;

    // Clear background
    background(253, 240, 213);

    // Show the win statement based on currentGame results
    if(currentGame.getWinner() == 0) {
        // Game tie
        textSize(105);
        fill(120, 0, 0);
        text("It's a tie!", width / 2 , (height / 2) - 20);
    } else {
        // Display winner
        String winStatement = "Player " + currentGame.getWinner() + " wins!";
        textSize(105);
        fill(120, 0, 0);
        text(winStatement, width / 2 , (height / 2) - 20);
    }

    currentGame.reset();
}

void delayTime(int millis) {
    int time = millis();
    while(true) {
        if((millis() - time) >= millis) {
            break;
        }
    }
}

void startTicTacToe() {
    clicks = 0;
    
    // Update conditions so draw() runs the right window
    runHomeScreen = false;
    runTicTacToe = true;

    // Set window title to "Tic Tac Toe!"
    surface.setTitle("Tic Tac Toe!");

    // CLEAR WINDOW
    // clearBoard is only true when quit button is pressed and window is on the home screen
    if(clearBoard) {
        background(253, 240, 213);
        clearBoard = false;
    }

    currentGame = gameList.get(0);
    currentGame.reset();
    currentGame.changePlayer(1);
    runTicTacToe();
}

void runTicTacToe() {
    currentGame.drawBoard();
}

void startSingle() {
    clicks = 0;
    
    runHomeScreen = false;
    runSinglePlayer = true;

    // Set window title to "Tic Tac Toe!"
    surface.setTitle("Tic Tac Toe!");

    // CLEAR WINDOW
    // clearBoard is only true when quit button is pressed and window is on the home screen
    if(clearBoard) {
        background(253, 240, 213);
        clearBoard = false;
    }

    currentGame = gameList.get(1);
    currentGame.reset();
    currentGame.changePlayer(1);
    runSingle();
}

void runSingle() {
    currentGame.drawBoard();
}

// Button class
public class Button {
    private String name;
    private int x;
    private int y;
    private int rectLength;
    private int rectWidth;

    // Store the coordinate bounds of the button so that mouse click can be checked if it is inbetween these bounds
    private int leftCoord;
    private int rightCoord;
    private int topCoord;
    private int bottomCoord;


    // Constructor
    public Button(String name, int x, int y, int rectLength, int rectWidth) {
        this.name = name;
        this.x = x;
        this.y = y;
        this.rectLength = rectLength;
        this.rectWidth = rectWidth;

        // Assigns the bounds of the button so that the mouseClick position can be easily coded
        leftCoord = x - (rectLength/2);
        rightCoord = x + (rectLength/2);
        topCoord = y - (rectWidth/2);
        bottomCoord = y + (rectWidth/2);
    }

    // ACCESSORS METHODS
    public void drawButton() {
        rect(x, y, rectLength, rectWidth);
    }
    public int getX() {
        return x;
    }
    public int getY() {
        return y;
    }
    public String getName() {
        return name;
    }
    public int getLeft() {
        return leftCoord;
    }
    public int getRight() {
        return rightCoord;
    }
    public int getTop() {
        return topCoord;
    }
    public int getBottom() {
        return bottomCoord;
    }
    public String toString() {
        return name;
    }
}

// Game class -- Game object will never be instantiated to a new Game object, only inherited classes
public class Game {
    // Board attributes
    private int rows;
    private int cols;
    private int pixelsPerRow; // How large is one grid? Y value
    private int pixelsPerColumn; // How large is one grid? X value
    private int[][] board;
    private int[][][] boardCoords;
    private int inARow;

    // Game attributes
    private int playerTurn = 1;
    private int winner = -1; // Unfinished game = -1, tie = 0, winners = player number

    // Constructor
    public Game(int rows, int cols, int inARow) {
        // SET ROW COLS VARIABLES
        this.rows = rows;
        this.cols = cols;
        this.inARow = inARow;

        board = new int[rows][cols];
        boardCoords = new int[rows][cols][2]; // Stores the x and y coordinate maximum for each grid
        
        // Divide window into equal rows
        pixelsPerRow = height / rows;
        // Divide window into equal columns
        pixelsPerColumn = width / cols;
        generateCoords();
    }
    
    // Draw board
    public void drawBoard() {        
        // Make grid dark red
        fill(120, 0, 0);

        for(int i = 1; i < rows; i++) {
            rect(width/2, pixelsPerRow * i, width, 3);
        }
        for(int i = 1; i < cols; i++) {
            rect(pixelsPerColumn * i, height/2, 3, height);
        }
        
        // Draw quit button when drawBoard is called
        drawQuitButton();
    }
    
    // Draw the quit button
    public void drawQuitButton() {
        // Make QUIT Button
        fill(102, 155, 188); // Make azure blue
        buttonQuit.drawButton();
        fill(255);
        textSize(30);
        text("Quit", 110, 50);
    }
    
    // Generates the board coordinates
    public void generateCoords() {
        for(int r = 0; r < rows; r++) {
            for(int c = 0; c < cols; c++) {
                for(int coord = 0; coord < 2; coord++) {
                    if(coord == 0) { // This is the X max
                        boardCoords[r][c][0] = (c + 1) * pixelsPerColumn;
                    } else { // This is the Y max
                        boardCoords[r][c][1] = (r + 1) * pixelsPerRow;
                    }
                }
            }
        }
        // // Test if the coordinates are working:
        // for(int r = 0; r < rows; r++) {
        //     // Print Row #
        //     System.out.println("Row: " + (r + 1));
        //     for(int c = 0; c < cols; c++) {
        //         System.out.print("(" + (c + 1) + ")");
        //         System.out.print(Arrays.toString(boardCoords[r][c]));
        //     }
        //     // Print next row on new line
        //     System.out.println();
        // }
    }
    
    // Mutates the board[] when a grid is clicked
    // Overriden in extended classes
    public void mark() {
        // Empty, but needs to be here for no compile errors
        // Because, all games are placed in the gameList ArrayList<Game>
        // Since the object is declared with the Game class and not the class that inherits Game,
        // The methods in the inherited classes have to be in this class as well
    }
    public void changePlayer(int i) {
        playerTurn = i;
    }
    public void checkForWinner() {
        // Check for any horizontal "in a row's"
        for(int r = 0; r < rows; r++) {
            if(checkHorizontal(r, 1)) {
                winner = board[r][0];
                break;
            }
        }
        // Check for any vertical "in a row's"
        for(int c = 0; c < cols; c++) {
            if(checkVertical(1, c)) {
                winner = board[0][c];
                break;
            }
        }
        // Check diagonals
        if(checkDiagonalLR(1,1)) {
            // If there is a winner, the winner is set
            winner = board[1][1];
        } else if (checkDiagonalRL(1,1)) {
            winner = board[1][1];
        }
        
        if(winner > 0) {
            System.out.println("Player " + winner + " wins!");
            showWinner();
        } else { 
            // Check if board is full and therefore a tie
            boolean boardFull = false;
            // Traverse through every element in board
            for(int r = 0; r < rows; r++) {
                for(int c = 0; c < cols; c++) {
                    if(board[r][c] != 0) {
                        boardFull = true;
                    } else {
                        // If one element is empty (= 0), board is not full
                        boardFull = false;
                        // Break out of the loop
                        break;
                    }
                }
                // Break out of loop if board is not full
                if(!boardFull) {
                    break;
                }
            }

            // Set conditions for when game is a tie
            if(boardFull) {
                winner = 0;
                System.out.println("It's a tie!");
                showWinner();
            }

        }
        
    }
    // Checks to see if element at [r, c] = element BEFORE,
    // PRECONDITION: Column must be greater than 0, less than board[0].length (cols)
    public boolean checkHorizontal(int r, int c) {
        if(board[r][c] == board[r][c - 1] && board[r][0] != 0) {
            // If element equals element prior AND is not the last element in list, call method again but check if the next element is equal to the one before it
            if(c < cols - 1) {
                return checkHorizontal(r, c + 1);
            } else { // This will only run if the last element in row is equal to the one before it, and the elements before this equal each other
                return true;
            }
        }
        // Return false if elements do not equal the one before it
        return false;
    }
    // Checks to see if element at [r, c] = element ABOVE,
    // PRECONDITION: Row must be greater than 0, less than board.length (rows)
    public boolean checkVertical(int r, int c) {
        if(board[r][c] == board[r - 1][c] && board[0][c] != 0) {
            // If element equals element prior AND is not the last element in list, call method again but check if the next element is equal to the one above it
            if(r < rows - 1) {
                return checkVertical(r + 1, c);
            } else {
                return true;
            }
        }
        // Return false if elements do not equal the one above it
        return false;
    }
    // Checks to see if element at [r, c] = element ABOVE and LEFT
    // PRECONDITION: Row must be greater than 0, less than board.length (rows), 0 < col < 3
    public boolean checkDiagonalLR(int rIndex, int cIndex) {
        // System.out.println("checkDiagonalLR(" + rIndex + " ," + cIndex + ")");
        if(board[rIndex][cIndex] == board[rIndex - 1][cIndex - 1] && board[rIndex][cIndex] != 0) {
            if((rIndex < rows - 1 && cIndex < cols - 1) && (rIndex > 0 && cIndex > 0)) {
                return checkDiagonalLR(rIndex + 1, cIndex + 1);
            } else {
                return true;
            }
        }
        // Return false if elements do not equal the one above and left of it
        return false;
    }
    // Checks to see if element at [r, c] = element BELOW and LEFT
    // PRECONDITION: Row must be greater than 0, less than board.length (rows), 0 < col < 3
    public boolean checkDiagonalRL(int rIndex, int cIndex) {
        // System.out.println("checkDiagonalRL(" + rIndex + " ," + cIndex + ")");
        if(board[rIndex][cIndex] == board[rIndex + 1][cIndex - 1] && board[rIndex][cIndex] != 0) {
            if((rIndex < rows - 1 && cIndex < cols - 1) && (rIndex > 0 && cIndex > 0)) {
                return checkDiagonalRL(rIndex - 1, cIndex + 1);
            } else {
                return true;
            }
        }
        // Return false if elements do not equal the one below and left of it
        return false;
    }

    // Changes element in board that corresponds to where mouse was clicked to the player number
    public void updateBoard(int r, int c) {
        if(playerTurn == 1) {
            board[r][c] = 1;
            changePlayer(2);
        } else {
            board[r][c] = 2;
            changePlayer(1);
        }
    }
    
    public void drawX(int[] coords) { // Given the X and Y bounds, draw X
        textSize(128);
        // Make blue
        fill(0, 48, 73);
        // Centers "X" in the grid where mouse was clicked:
        // Takes the average of the left bound and right bounds for X, top and bottom bounds for Y
        text("X", ((coords[0] + (coords[0] - pixelsPerColumn)) / 2),((coords[1] + (coords[1]-pixelsPerRow)) / 2));
    }
    public void drawO(int[] coords) { // Given the X and Y bounds, draw X
        textSize(128);
        // Make red
        fill(193, 18, 31);
        // Centers "O" in the grid where mouse was clicked:
        // Takes the average of the left bound and right bounds for X, top and bottom bounds for Y
        text("O", ((coords[0] + (coords[0] - pixelsPerColumn)) / 2),((coords[1] + (coords[1]-pixelsPerRow)) / 2));
    }  

    // Reset the board so that all elements in board[] = 0
    // Will stop drawing X and O in draw() method
    public void reset() {
        for(int r = 0; r < board.length; r++) {
            for(int c = 0; c < board[0].length; c++) {
                board[r][c] = 0;
            }
        }
        // Reset winner to -1
        winner = -1;
    }
    
    // Accessor methods
    public int getRows() {
        return rows;
    }
    public int getCols() {
        return cols;
    }
    public int[][] getBoard() {
        return board;
    }
    public int[] getBoardCoords(int r, int c) {
        return boardCoords[r][c];
    }
    public int getBoardCoords(int r, int c, int xy) {
        return boardCoords[r][c][xy];
    }
    public int getPlayerTurn() {
        return playerTurn;
    }
    public int getPixelsPerColumn() { // X
        return pixelsPerColumn;
    }
    public int getPixelsPerRow() { // Y
        return pixelsPerRow;
    }
    public int getWinner() {
        return winner;
    }
}

public class TicTacToe extends Game {
    public TicTacToe() {
        super(3, 3, 3); // Creates Game class with 3 rows and 3 columns, 3 must be in a row to win
    } 

    @Override
    public void mark() {
        int tempRow = 0;
        int tempCol = 0;
        // Check MouseX column (X value)
        for(int c = 0; c < getCols(); c++) {
            // Check if MouseX is less than the column's maximum x value
            // getBoardCoords() parameters: (row index, column index, x or y)
            if(mouseX < getBoardCoords(0, c, 0)) {
                // Set temp column index to c
                tempCol = c;
                break;
            }
        }
        for(int r = 0; r < getRows(); r++) {
            // Check if MouseY is less than the row's maximum y value
            // getBoardCoords() parameters: (row index, column index, x or y)
            if(mouseY < getBoardCoords(r, 0, 1)) {
                // Set temp row index to r
                tempRow = r;
                break;
            }
        }
        // If board[] is unplayed at that index, update it to the player turn's
        if(getBoard()[tempRow][tempCol] == 0) {
            updateBoard(tempRow, tempCol);
        }
    }  
}

// Create a new game mode where a player plays against a computer
public class SinglePlayerTicTacToe extends Game {
    public SinglePlayerTicTacToe() {
        super(3, 3, 3); // Creates Game class with 3 rows and 3 columns, 3 must be in a row to win
    } 
    
    // When player plays
    public void mark() {
        int tempRow = 0;
        int tempCol = 0;

        // Check MouseX column (X value)
        for(int c = 0; c < getCols(); c++) {
            // Check if MouseX is less than the column's maximum x value
            // getBoardCoords() parameters: (row index, column index, x or y)
            if(mouseX < getBoardCoords(0, c, 0)) {
                // Set temp column index to c
                tempCol = c;
                break;
            }
        }
        for(int r = 0; r < getRows(); r++) {
            // Check if MouseY is less than the row's maximum y value
            // getBoardCoords() parameters: (row index, column index, x or y)
            if(mouseY < getBoardCoords(r, 0, 1)) {
                // Set temp row index to r
                tempRow = r;
                break;
            }
        }
        // If board[] is unplayed at that index, update it to the player turn's
        if(getBoard()[tempRow][tempCol] == 0 && getPlayerTurn() == 1) {
            updateBoard(tempRow, tempCol);
            currentGame.checkForWinner();

            // After player marks, immediately run the computer's play
            computerMark();
        }
    }  

    // Computer randomly plays a spot (it's not very smart so it's easy to win)
    public void computerMark() {
        // Double checks that the method only runs if it is the computer's turn
        if(getPlayerTurn() == 2) {
            // Set computer's mark to a random slot in the board[] array
            int tempRow = (int)random(0, 3);
            int tempCol = (int)random(0, 3);

            // If the slot is already played, randomly re-select a slot
            while(getBoard()[tempRow][tempCol] != 0) {
                tempRow = (int)random(0, 3);
                tempCol = (int)random(0, 3);
            }
            
            // Mark board with computer's player number (2)
            updateBoard(tempRow, tempCol);
        } 
    }
}
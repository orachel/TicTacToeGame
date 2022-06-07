# **AP CS A Final Project**

### Tic-Tac-Toe
<center><font color = #ffa6c8>3 in a row to win, 2 players, 3 x 3 grid</font></center>

### Project Requirements
**Classes:**
* `Game` class
    * The `Game` class stores the grid, board, coordinates of each box's bounds, player turn, and the winner of each Game object
* `Button` class
    * The `Button` class makes creating a button easier. Given the position of where the button is supposed to be and the length, it calculates the coordinate bounds to make it easier to program when the button is clicked. 
    
**Array(s), ArrayList(s), and/or 2D array(s):**
* `ArrayList\<Game\> gameList` stores all the available games that have been programmed and are playable.
    * Right now, there is Tic-Tac-Toe and Single Player Tic-Tac-Toe. Examples of games that can be added to the ArrayList are: Four in a Row, and variations of that

**Demonstration of effective use of inheritance:**
* `TicTacToe` class inherits `Game` class
    * Has a specific `mark()` method when a player plays their turn
    * Fixed row and column number in `super()` for all games of Tic-Tac-Toe
* `SinglePlayer` class inherits `Game` class
    * Has the same attributes as `TicTacToe` class
    * However, has different methods:
        * The `mark()` method is essentially the same as the `TicTacToe` class, but after each time the board is updated after Player 1's turn, it runs a *new* method specific to the class: `computerMark()`
        * `computerMark()` automatically runs Player 2's turn (which is the computer) and randomly selects an empty spot to mark
            * Since `computerMark()` is random, it's not very smart: Player 1 (the human) can easily outwin the computer
* Other games with the same kind of behaviour to inherit the `Game` class in the future




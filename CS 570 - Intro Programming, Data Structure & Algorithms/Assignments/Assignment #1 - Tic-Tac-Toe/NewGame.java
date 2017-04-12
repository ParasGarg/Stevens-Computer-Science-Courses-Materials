/* NEW GAME CLASS */

// importing libraries
import java.util.*;
import java.io.*;

/* Class :: New Game starts from here */
class NewGame {
    // objects and variables :: class scope
    Scanner inp = new Scanner(System.in);
    int playersCount, boardSize_rows, boardSize_cols, winSequence, playersTurn = 0;
    char [][] playingBoard;
    
    // method to set up specifications for a new game
    void gameConfig() {
        // specification 1 :: number of players playing
        System.out.print("\n\t1. How many players are playing (range 2 through 26) : ");
        playersCount = playersCount();    
        
        // specification 2 :: size of board
        System.out.print("\t2. How large the board should be (range 3 through 999)");
        boardSize_rows = boardRowSize();
        boardSize_cols = boardColSize();

        // specification 3 :: win sequence count
        System.out.print("\t3. What would be the win sequence count (3 is normal standard) : ");
        winSequence = winSequence();
        
        // specification 4 :: preparing playing board
        playingBoard = new char[boardSize_rows][boardSize_cols];
        
        // specification 5 :: game board layout
        System.out.print("\nAll set!! Your board is: \n\n");
    }

    // method :: get the count of number of players playing
    private int playersCount() {
        // variables declaration
        int playersCount;
        // user input :: number of players playing  
        playersCount = inp.nextInt();
        // validation :: number of players playing         
        while(true) {
            if (playersCount >= 2 && playersCount <= 26) {
                break;
            } else {
                System.out.print("\t\tInvalid input. Enter again : ");
                playersCount = inp.nextInt();
            }
        }
        // returning value
        return playersCount;
    }

    // method :: get the rows size of board
    private int boardRowSize() {
        // variables declaration
        int rowSize;;
        // user input :: size of board rows 
        System.out.print("\n\t\t Enter rows : ");
        rowSize = inp.nextInt();
        // validation :: size of board rows          
        while(true) {
            if (rowSize < 3 || rowSize > 999) {
                System.out.print("\t\t\tInvalid input. Enter rows size again : ");
                rowSize = inp.nextInt();
            } else {
                break;
            }
        }
        // returning value
        return rowSize;
    }

    // method :: get the columns size of board
    private int boardColSize() {
        // variables declaration
        int colSize;
        // user input :: size of board columns 
        System.out.print("\t\t Enter columns : ");
        colSize = inp.nextInt();
        // validation :: size of board columns          
        while(true) {
            if (colSize < 3 || colSize > 999) {
                System.out.print("\t\t\tInvalid input. Enter columns size again : ");
                colSize = inp.nextInt();
            } else {
                break;
            }
        }
        // returning value
        return colSize;
    }

    // method :: get the win sequence count
    private int winSequence() {
        // variables declaration
        int sequenceCount;
        // user input :: win sequence count 
        sequenceCount = inp.nextInt();
        // validation :: win sequence count         
        while(true) {
            if (sequenceCount > 0) {
                if (sequenceCount > boardSize_rows) {
                    System.out.print("\t\tInvalid input. Must be lesser than row size ie " + boardSize_rows + " : ");
                    sequenceCount = inp.nextInt();           
                } else if (sequenceCount > boardSize_cols) {
                    System.out.print("\t\tInvalid input. Must be lesser than column size ie " + boardSize_cols + " : ");
                    sequenceCount = inp.nextInt();
                } else {
                    break;
                }
            } else {
                System.out.print("\t\tInvalid input. Must be greater than 0 : ");
                sequenceCount = inp.nextInt();
            }
        }
        // returning value
        return sequenceCount;
    }
}
/* Class :: New Game ends here*/
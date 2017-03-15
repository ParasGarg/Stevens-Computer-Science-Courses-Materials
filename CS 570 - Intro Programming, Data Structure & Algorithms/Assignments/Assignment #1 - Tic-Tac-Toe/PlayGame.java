/* PLAY GAME CLASS */

// importing libraries
import java.util.*;
import java.io.*;

/* Class :: Play Game starts from here */
class PlayGame {
    // objects and variables :: class scope
    Scanner inp = new Scanner(System.in);
    char [][] playingBoard;
    char [] playersName;
    int boardRows, boardCols, playerCount, playerTurn, winSequence;

    // method :: game data repository
    void gameRepository(char [][] playBoard,int boardSize_rows, int boardSize_cols, int playersCount, int winSeq,  int turnsPlayed) {
        // specification 1 :: defining the playing board size
        boardRows = boardSize_rows;
        boardCols = boardSize_cols;
        // the board
        playingBoard = new char[boardRows][boardCols];
        playingBoard = playBoard;
            
        // specification 2 :: defining an array of players playing
        playersOrder(playersCount);

        // specification 3 :: count of players playing
        playerCount = playersCount;

        // specification 4 :: defining winning sequence
        winSequence = winSeq;

        // specification 5 :: finding player's turns
        playerTurn = turnsPlayed;
    }
    
    // method :: start game
    void startGame() {
        // variables declaration
        String playerInput;
        
        System.out.print("Enter any of the given choices. \n\t1. 'Q' to Quit Game, \n\t2. 'S' to Save Game or \n\t3. 'row<space>column' to Play Turn.\n\n");        
        // condition :: checking new game or saved game 
        while (checkBoardFull() == false) {            
            if (playerTurn == playersName.length)  playerTurn = 0;                  // rotating player cycle
            enterPosition();                                                        // user input :: position location
            showBoard();                                                            // display :: latest board with inputs
            playerTurn++;                                                           // changing player
        }
    }
    
    // method :: user position input
    private void enterPosition() {
        // variables declaration
        String regex = "\\d+\\s\\d+";
        String playerInput;
        int rowInput, colInput;
        
        // user input
        System.out.print("Player " + playersName[playerTurn] + " :: ");
        playerInput = inp.nextLine().toUpperCase();

        // validation :: user input
        while (true) {
            // condition 1 :: input matches the regex pattern             
            if (playerInput.matches(regex) == true) {
                // fetching rows and column from input
                rowInput = getRow(playerInput);
                colInput = getCol(playerInput);

                // inner condition 1 :: input out boundary
                if ((rowInput > 0 && rowInput <= boardRows) && (colInput > 0 && colInput <= boardCols)) {
            
                // inner condition 2 :: input must be unique
                    if (playingBoard[rowInput-1][colInput-1] == 0) {
                        playingBoard[rowInput-1][colInput-1] = playersName[playerTurn];

        // validation :: win status
                        if (checkWin(playersName[playerTurn], rowInput-1, colInput-1) == true) {
                            System.out.print("\n");
                            showBoard();
                            System.out.println("****** Player " + playersName[playerTurn] + " Won! ******");
                            QuitGame();
                        }

                        break;
                    } else {
                        System.out.print("\tPosition already marked. Enter again : ");
                        playerInput = inp.nextLine();
                    }                    
                } else {
                    System.out.print("\tIncorrect position. Enter again : ");
                    playerInput = inp.nextLine();
                }
            } 
            // condition 2 :: input matches the game quiting pattern 
            else if (playerInput.matches("Q") == true) {
                // display :: quit commands
                System.out.print("\nAre you sure to Quit the Game?\n\t1. Press 'Y' to Quit without Saving, \n\t2. Press 'S' to Save and Quit, \n\t3. Press 'R' to Return.");
                // user input :: other quiting options
                System.out.print("\nPlease enter : ");                
                playerInput = inp.nextLine().toUpperCase();
                // user input :: quit the game 
                if (playerInput.matches("Y") == true) {
                    System.out.println("\nYou chose to Quit the Game. Bye, will see you again!");
                    QuitGame();
                }
            }                        
            // condition 3 :: input matches the game saving pattern    
            else if (playerInput.matches("S") == true) {
                SaveGame();
                // display :: quit commands
                System.out.print("\nYour game has been Saved!!\n\t1. Press 'Q' to Quit, \n\t2. Press 'R' to Return.");
                // user input :: other quiting options
                System.out.print("\nPlease enter : ");
                playerInput = inp.nextLine().toUpperCase();
                // user input :: quit the game 
                if (playerInput.matches("Q") == true) {
                    System.out.println("\nYou chose to Quit the Game. Bye, will see you again!");
                    QuitGame();
                }
            }
            // condition 3 :: input matches the returning to game pattern    
            else if (playerInput.matches("R") == true) {
                // user input :: returning to game
                System.out.print("Player " + playersName[playerTurn] + " :: ");
                playerInput = inp.nextLine().toUpperCase();
            }                       
            // condition 4 :: input matches none of the game patterns                         
            else {
                System.out.print("\tInvalid value. Enter again : ");
                playerInput = inp.nextLine().toUpperCase();
            }   
        }
        System.out.print("\n");
    }

    // method :: check board full status
    boolean checkBoardFull() {
        // variables declaration
        boolean full = true;
        // checking each element of the board array
        for (int i = 0; i < boardRows; i++) {
            for (int j = 0; j < boardCols; j++) {
                if (playingBoard[i][j] == 0) {
                    full = false;
                    break;
                }
            }
        }
        // codition :: board full
        if (full == true) { 
            System.out.print("\n****** GAME TIE ******");             // display :: tie message
            QuitGame ();                                              // quiting :: game ended
        }
        // returning value
        return full;
    }

    // method :: check win status
    boolean checkWin(char player, int rowPosition, int colPosition) {
        int startRowPoint, endRowPoint, startColPoint, endColPoint, winCount;
        int i;

        winCount = 0;
        // ****** checking horizontal axis condition :: row's axis        
        {
            startColPoint = colPosition - winSequence + 1;
            endColPoint = colPosition + winSequence - 1;
            // reinitializing for boundary cases
            if (startColPoint < 0)                  startColPoint = 0;
            if (endColPoint > (boardCols - 1))      endColPoint = boardCols - 1;
            // loop to row's axis
            for (i = startColPoint; i <= endColPoint; i++) {
                if (playingBoard[rowPosition][i] == player){
                    winCount++; 
                    // returning result                   
                    if (winCount == winSequence) return true;
                }    
                else winCount = 0;
            }
        } 
        
        winCount = 0;
        // ****** checking vertical axis condition :: column's axis
        {
            startRowPoint = rowPosition - winSequence + 1;
            endRowPoint = rowPosition + winSequence - 1;
            // reinitializing for boundary cases
            if (startRowPoint < 0)               startRowPoint = 0;
            if (endRowPoint > (boardRows - 1))   endRowPoint = boardRows - 1;
            // loop to column's axis
            for (i = startRowPoint; i <= endRowPoint; i++) {
                if (playingBoard[i][colPosition] == player){
                    winCount++;
                    // returning result
                    if (winCount == winSequence) return true;
                }
                else winCount = 0;
            }
        }   
        
        winCount = 0;
        // ****** checking diagonal axis condition :: top row-column to bottom row-column axis
        {
            startColPoint = colPosition - winSequence + 1;
            endColPoint = colPosition + winSequence - 1;
            startRowPoint = rowPosition - winSequence + 1;
            endRowPoint = rowPosition + winSequence - 1;
            // reinitializing for boundary cases
            for (i = 0; i <= endColPoint-startColPoint; i++ ) { 
                if (startColPoint < 0 || startRowPoint < 0) {
                    startColPoint++;
                    startRowPoint++;                    
                }
                if (endColPoint > (boardCols-1) || endRowPoint > (boardRows-1)) {
                    endColPoint--;
                    endRowPoint--;                    
                }
            }
            // loop to up to down row-column's axis
            int diagonalLength = endColPoint - startColPoint;         // or int diagonalLength = endRowPoint - startRowPoint;
            for (i = 0; i <= diagonalLength; i++) {                   
                if (playingBoard[startRowPoint + i][startColPoint + i] == player) {
                    winCount++;
                    if (winCount == winSequence) return true;          
                }
                else winCount = 0;
            }
        }

        winCount = 0;
        // ****** checking diagonal axis condition :: bottom row-column to top row-column axis
        {
            startColPoint = colPosition - winSequence + 1;
            endColPoint = colPosition + winSequence - 1;
            startRowPoint = rowPosition + winSequence - 1;
            endRowPoint = rowPosition - winSequence + 1;
            // reinitializing for boundary cases
            for (i = 0; i <= endColPoint-startColPoint; i++ ) { 
                if (startColPoint < 0 || startRowPoint > (boardRows-1)) {
                    startColPoint++;
                    startRowPoint--;                    
                }
                if (endColPoint > (boardCols-1) || endRowPoint < 0 ) {
                    endColPoint--;
                    endRowPoint++;                    
                }
            }
            // loop to down to up row-column's axis
            int diagonalLength = endColPoint - startColPoint;         // or int diagonalLength = endRowPoint - startRowPoint;
            for (i = 0; i <= diagonalLength; i++) {                   
                if (playingBoard[startRowPoint - i][startColPoint + i] == player) {
                    winCount++;
                    if (winCount == winSequence) return true;          
                }
                else winCount = 0;
            }
        }
        // returning value
        return false;
    }

    // method :: show customized board
    void showBoard() {
        // variables declarations        
        int [][] board = new int [boardRows][boardCols];
        int i, j;

        // creating the board
        for (i = 0; i <= boardRows; i++) {            
            for (j = 0; j <= boardCols; j++) {
                // condition for i=0 & j=0 cell 
                if (i == 0 && j == 0) {
                    System.out.print("   ");
                } 
                // condition for i=0 row (first row of board)
                else if (i == 0 && j > 0) {
                    if (j >= 100)       System.out.print(j);
                    else if (j >= 10)   System.out.print(j + "  ");
                    else                System.out.print(" " + j + "  ");                       
                }
                // condition for j=0 column (first column of board)              
                else if ( i > 0 && j == 0) {
                    if (i >= 100)       System.out.print(i);
                    else if (i >= 10)   System.out.print(i + " ");
                    else                System.out.print(i + "  ");
                }
                // condition to show data on board 
                else {
                    System.out.print(" " + playingBoard[i-1][j-1] + " "); 
                    // condition to avoid last '|'
                    if (j < boardCols)  System.out.print("|");
                }
            }
 
            // drawing row's bottom boundary
            System.out.print("\n");
            if (i > 0 && i < boardRows) {
                for (j = 0; j <= boardCols; j++) {
                    // condition for j=0 column (first column of board)
                    if (j == 0) {
                        System.out.print("   ");
                    } 
                    // condition for j>0 columns (first column of board)
                    else {
                        System.out.print("---");
                        // condition to avoid last '+'
                        if (j < boardCols)  System.out.print("+");
                    }
                }
            }
            System.out.print("\n");
        }
    }

    // method :: fetching row position from string
    private int getRow (String playerInput) {
        // variables declaration
        int row;
        String str = "";
        // fetching
        for (int i = 0; i < playerInput.length(); i++) {
            if (Character.isDigit(playerInput.charAt(i))) {
                str += playerInput.charAt(i);    
            }
            else break;
        }
        // type cast
        row = Integer.parseInt(str);
        // returning
        return row;
    }

    // method :: fetching column position from string
    private int getCol (String playerInput) {
        // variables declaration
        int col, i;
        String str = "", str_rev= "";
        // reversing the input [row col] = [col row]
        for (i = playerInput.length()-1 ; i >= 0; i--) {
			str_rev = str_rev + playerInput.charAt(i);	
		}
        // re-initializing variables
        playerInput = str_rev;
        str_rev = "";
        // fetching
        for (i = 0; i < playerInput.length(); i++) {
            if (Character.isDigit(playerInput.charAt(i))) {
                str += playerInput.charAt(i);    
            }
            else break;
        }
        // reversing the output (if 321 = 123)
        for (i = str.length()-1 ; i >= 0; i--) {
			str_rev = str_rev + str.charAt(i);	
		}
        // type cast
        col = Integer.parseInt(str_rev);
        // returning value
        return col;
    }

    // method :: array of players playing
    private void playersOrder(int playerCount) {
        // variables declaration
        playersName = new char [playerCount];
        int i, asciiGap = 0;
        // default players
        playersName[0] = 'X';
        playersName[1] = 'O';
        // auto assigning other players by order
        for (i = 2; i < playersName.length; i++) {
            if (i == 16 || i == 24) playersName[i] = (char) (i + 63 + ++asciiGap);
            else playersName[i] = (char) (i + 63 + asciiGap);
        }
    }

    // method :: quiting game
    private void QuitGame () {
        // system quits
        System.exit(0);                              
    }

    // method :: saving game
    private void SaveGame() {        
        // variables and objects declaration        
        Scanner inp = new Scanner(System.in);
        String fileName, fileContent = "Good Work";
        char data;
        File f;
        FileWriter fw;

        // writing content for file
        fileContent = "playerCount:" + playerCount + "#\n" + 
                        "boardRows:" + boardRows + "#\n" + 
                        "boardCols:" + boardCols + "#\n" +
                        "winSequence:" + winSequence + "#\n" +
                        "playerTurn:" + playerTurn + "#\n" +                         
                        "playingBoard:" + convertBoardInString() + "#\n";

        // user input :: saved file name
        System.out.print("Enter file name to saved (eg. filename.txt) : ");
        fileName = inp.nextLine();

        // reading the saved file
        try {
            while (true) {
                int extension = fileName.lastIndexOf('.') + 1;
                String extensionType = fileName.substring(extension);
                // validation :: file extension
                if (extensionType.equals("txt")) {
                    f = new File(fileName);
                    fw = new FileWriter(f);
                    // writing in a file
                    fw.write(fileContent);
                    // closing file
                    fw.close();	
                    break;		
                } else {
                    System.out.print("\tIncorrect file. Enter '.txt' file : ");
                    fileName = inp.nextLine();
                }
            }
        } catch (Exception ex) {
			System.out.print(ex);
		}
    }

    // method :: saving game
    private String convertBoardInString() {
        // variables declaration
        String contentConverted = "";
        // reading board values
        for (int i = 0; i < boardRows; i++) {
            for (int j = 0; j <boardCols; j++) {
                if (playingBoard[i][j] != 0) {
                    contentConverted = contentConverted + i + playingBoard[i][j] + j + " ";
                }
            }
        }
        // returning value
        return contentConverted;
    }
}      
/* Class :: Play Game ends here */
/* MAIN CLASS */

/*
  === ASSISGNMENT DETAILS ===
  Student's Name : Paras Garg
  Class Section  : CS 570 A 
  Assisgnment 1  : Create an advanced, flexible tic-tac-toe game for the console.
*/

// importing libraries
import java.util.*;
import java.io.*;

/* Class :: Main starts from here */
class TicTacToe {
    public static void main(String [] arg) {
        // objects and variables declarations
        Scanner inp = new Scanner(System.in);
        String gameOption;
        int rowSize, colSize;

        LoadGame objLG = new LoadGame();                    // LoadGame Class object                 
        NewGame objNG = new NewGame();                      // NewGame Class object                 
        PlayGame objPG = new PlayGame();                    // PlayGame Class object
        
        // display welcome screen
        System.out.print("\nWelcome to TicTacToe!\n");                        

        // game options :: continue saved game or play new game
        System.out.print("\nWanted to Continue Saved Game or Play New Game. \n\t1. Enter 'C' to Resume Saved Game. \n\t2. Enter 'N' to Play New Game.");
        System.out.print("\nPlease enter : ");
        gameOption = inp.nextLine().toUpperCase();
        // game options validation :: user input validation         
        while(true) {
            if ( gameOption.equals("C") || gameOption.equals("N")) {
                break;
            } else {
                System.out.print("Invalid input. Please enter again (C/N): ");
                gameOption = inp.nextLine().toUpperCase();
            }
        }

        // menu for continue or saved game
        switch(gameOption) {
            // if opt for continue saved game
            case "C":
                System.out.println("\nYou chose to Play a Saved Game.");    // display message to screen
                objLG.gameConfig();                                         // calling gameConfig method      
                                                                            // calling gameRepository method
                objPG.gameRepository(objLG.playingBoard, objLG.boardSize_rows, objLG.boardSize_cols, objLG.playersCount, objLG.winSequence, objLG.playersTurn);    
                break;
            // if opt for new game
            case "N":
                System.out.print("\nYou chose to Play a New Game.");        // display message to screen
                objNG.gameConfig();                                         // calling gameConfig method
                                                                            // calling gameRepository method
                objPG.gameRepository(objNG.playingBoard, objNG.boardSize_rows,objNG.boardSize_cols, objNG.playersCount, objNG.winSequence, 0);                                                                                
                break;                          
        }   
        objPG.showBoard();                                                  // display board
        objPG.startGame();                                                  // calling startGame method to start game                                                                                                           
    }
}
/* Class :: Main ends here */
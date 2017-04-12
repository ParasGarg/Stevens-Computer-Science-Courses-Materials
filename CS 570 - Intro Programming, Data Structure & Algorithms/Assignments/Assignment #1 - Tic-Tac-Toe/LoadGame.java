/* LOAD GAME CLASS */

// importing libraries
import java.util.*;
import java.io.*;

/* Class :: Load Game starts from here */
class LoadGame {
    // objects and variables :: class scope
    int playersCount, playersTurn, boardSize_rows, boardSize_cols, winSequence;
    String fileData;
    char [][] playingBoard;

    // method to set up specifications for a new game
    void gameConfig() {
        // specification 1 :: reading the file data from saved file
        fileData = loadFileData();  

        // specification 2 :: number of players playing
        playersCount = fetchData("playerCount");   

        // specification 3 :: size of board
        boardSize_rows = fetchData("boardRows");
        boardSize_cols = fetchData("boardCols");

        // specification 4 :: win sequence count
        winSequence = fetchData("winSequence");

        // specification 5 :: player's turn
        playersTurn = fetchData("playerTurn");

        // specification 4 :: preparing playing board
        playingBoard = new char [boardSize_rows][boardSize_cols];
        fetchBoardData("playingBoard");

        // specification 5 :: game board layout
        System.out.print("\nGame loaded!! Your game status was: \n\n");
    }

    // method :: load content from the saved file
    private String loadFileData() {
        // variables and objects declaration        
        Scanner inp = new Scanner(System.in);
        String fileName, fileContent = "";
        char data;
        File f;
        FileReader fr;
        // user input :: saved file name
        System.out.print("Enter your saved file name (eg. filename.txt) : ");
        fileName = inp.nextLine();

        // reading the saved file
        try {
            while (true) {
                f = new File(fileName);
                // validation :: file exsits or not
                if (f.exists() == true && f.isFile() == true && f.canRead() == true) {
                    fr = new FileReader(f);
                    int x;
                    // reading file
                    while ( (x = fr.read()) >= 0 ) {
                        data = (char) x;
                        fileContent = fileContent + data;
                    }
                    // closing file
                    fr.close();	
                    break;		
                } else {
                    System.out.print("\tIncorrect file. Enter '.txt' file : ");
                    fileName = inp.nextLine();
                }
            }
        } catch (Exception ex) {
			System.out.print(ex);
		}
        // returning value
        return fileContent;
    }

    // method :: fetch data from the saved file
    private int fetchData(String find) {
        // variables declaration                
        int findLoc = fileData.indexOf(find);
        int valueLoc = findLoc + find.length() + 1;
        String value = "";
        // fetching data from file
        for (int i = valueLoc; fileData.charAt(i) != '#'; i++) {
            value = value + fileData.charAt(i);
        }
        // returning value
        return Integer.parseInt(value);
    }

    // method :: load playing board data
    private void fetchBoardData(String find) {
        // variables declaration    
        int findLoc = fileData.indexOf(find);
        int valueLoc = findLoc + find.length() + 1;
        String rowLoc = "", colLoc = "";
        // fetching data from file
        for (int i = valueLoc; fileData.charAt(i) != '#'; i++) {
            // initializing null to row and loc values
            rowLoc = "";
            colLoc = "";
            if (fileData.charAt(i) >= 65 && fileData.charAt(i) <= 90) {
                for (int k = i-1; Character.isDigit(fileData.charAt(k)); k--) {
                    rowLoc = rowLoc + fileData.charAt(k);
                }

                for (int k = i+1; Character.isDigit(fileData.charAt(k)); k++) {
                    colLoc = colLoc + fileData.charAt(k);
                }

                playingBoard[Integer.parseInt(rowLoc)][Integer.parseInt(colLoc)] = fileData.charAt(i);                             
            }
        }
    }   
}
/* Class :: Load Game ends here */
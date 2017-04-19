/*
  === GROUP DETAILS ===
  Class Section  : CS 570 LA
  Group Name     : Lab Group 24
  Members Name   : Paras Garg, Paromitta Dutta
*/

/*
  Lab Assisgnment 2:
  You will be deciphering a given message. 
  It is encrypted with a Caesar Cipher that increases by 2 after every 3 characters (including symbol characters, which are not encoded), starting at key = 5. 
  You should save this message to a file using a text editor. 
  Then, your program will prompt the user for the name of the file, decrypt the message stored in the file, and then write the decrypted message to a new file called solution.txt.
*/

// importing libraries
import java.util.*;
import java.io.*;

class CaesarCipher {
    // main method
    public static void main(String [] args) {
      String fileName, fileContent = "", solutionContent = "";
      Scanner inp = new Scanner(System.in);

      // user input :: enter decrypted .txt file name
      System.out.print("Enter decrypted message file name (eg. file_name.txt) :: ");
      fileName = inp.nextLine();

// calling file name to load file and encrypted message from the file
      File f;
      FileReader fr;

      // reading file
      try {
        f = new File(fileName);
        // checking file exists or not
        if (f.exists() == true && f.isFile() == true && f.canRead() == true) {
          fr = new FileReader(f);
          int data;
          // collecting file data
          while( (data = fr.read()) >= 0) {
            fileContent = fileContent + (char) data;
          }
          fr.close();
        }
      } catch (Exception ex) { System.out.print(ex); }

// calling caesar cipher decryption function
      int ascii, key = 5;
      char data;

      key = key - 2;                                      // key for first use
      for (int i = 0; i < fileContent.length(); i++) {
        ascii = fileContent.charAt(i);                    // finding ascii value of each character        
        
        if (key > 26)     key = key % 26;                 // defining range of key               
        if (i % 3 == 0)   key = key + 2;                  // increasing key value by 2
        
        if (ascii >= 65 && ascii <= 90) {
          ascii = ascii - key;
          if (ascii < 65) {
            ascii = 90 - (65 - ascii - 1);                
          }
        }
        else if (ascii >= 97 && ascii <= 122) {
          ascii = ascii - key;
          if (ascii < 97) {
            ascii = 122 - (97 - ascii - 1);
          }
        }
      
        // saving new character to file content
        solutionContent = solutionContent + (char) ascii;
      }

// calling file name to save decrypted message to "solution.txt" file
      FileWriter fw;

      System.out.println("\nMessage has been Deciphered and saved to 'solution.txt' file.");
      // writing file
      try {
        f = new File("solution.txt");
        fw = new FileWriter(f);
        fw.write(solutionContent);
        fw.close();
      } catch (Exception ex) { 
        System.out.print(ex); 
      }        
    }
}
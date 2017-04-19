/*
  GROUP DETAILS
  =============
  GROUP MEMBERS	: PARAS GARG & PAROMITA DATTA
  GROUP SECTION	: CS 570-LA 
  LAB ASSIGNMENT - WEEK 6 : BOUNCY BUBBLE SORT
*/

// importing libraries
import java.util.*;

// main class
class BubbleSort {
    // main function
    public static void main(String args[]) {
        List<Integer> dataset = new ArrayList<Integer>();
        Scanner inp = new Scanner(System.in);
        int index, usrInp;
        
        // size of array
        System.out.print("Enter the size of an dataset : ");
        index = inp.nextInt();

        // adding elements in dataset
        System.out.println("\nEnter numeric element in dataset : ");
        for (int i = 0; i < index; i++) {
            System.out.print("\tEnter " + (i+1) + " element : ");
            usrInp = inp.nextInt();
            dataset.add(usrInp);
        }
        
        // displaying the entered List
        System.out.print("Entered dataset is :- \n ");
        for (int data : dataset) {
            System.out.print(" | " + data + " | ");
        }
        System.out.print("\n");

        // calling sorting method
        Sort sort = new Sort();
        sort.sortData(dataset);

        // displaying the sorted List
        System.out.print("\nSorted dataset is :- \n ");
        for (int data : dataset) {
            System.out.print(" | " + data + " | ");
        }

    }
}

class Sort {
    public List<Integer> sortData (List<Integer> dataset) {
        int index = dataset.size();

        for (int i = 0; i < index; i++) {

            // parsing from begining through end
            if (i % 2 == 0) {
                for (int j = i+1; j < index; j++) {
                
                    if (dataset.get(i) > dataset.get(j)) {
                        int temp = dataset.get(j);
                        dataset.set(j, dataset.get(i));
                        dataset.set(i, temp);
                    }

                }
            }

            // parsing from end through begining
            else {
                for (int j = index-1; j >= i; j--) {

                    if (dataset.get(i) > dataset.get(j)) {
                        int temp = dataset.get(j);
                        dataset.set(j, dataset.get(i));
                        dataset.set(i, temp);
                    }

                }
            }
        }

       return dataset; 
    }
}


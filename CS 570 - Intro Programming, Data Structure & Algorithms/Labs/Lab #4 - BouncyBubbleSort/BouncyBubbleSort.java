/*
  GROUP DETAILS
  =============
  GROUP MEMBERS	: PARAS GARG & PAROMITA DATTA
  GROUP SECTION	: CS 570-LA 
  LAB ASSIGNMENT - WEEK 6 : BOUNCY BUBBLE SORT
*/
import java.util.*;

class BouncyBubbleSort {
   
    public static void main(String args[]) {
        List<Integer> dataset = new ArrayList<Integer>();
        dataset.add(66);
        dataset.add(32);
        dataset.add(12);
        dataset.add(90);
        dataset.add(14);
        dataset.add(21);        
        System.out.print("Entered dataset is :- \n "); // displaying the entered List
        for (int data : dataset) {
            System.out.print(" | " + data + " | ");
        }
        System.out.print("\n");
        Sort sort = new Sort();
        sort.sortData(dataset);
        System.out.print("\nSorted dataset is :- \n ");	 // displaying the sorted List
        for (int data : dataset) {
            System.out.print(" | " + data + " | ");
        }
    }
}

class Sort {
    public List<Integer> sortData (List<Integer> dataset) {
        int index = dataset.size();
        for (int i = 0; i < index; i++) {
            if (i % 2 == 0) {	// // parsing from beginning to end
            	for (int j = i+1; j < index; j++) {
                    if (dataset.get(i) > dataset.get(j)) {
                        int temp = dataset.get(j);
                        dataset.set(j, dataset.get(i));
                        dataset.set(i, temp);
                    }
                }
            }           
            else {
                for (int j = index-1; j >= i; j--) {	// parsing from end to beginning
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


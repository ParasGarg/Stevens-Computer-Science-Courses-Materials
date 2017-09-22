/*
  GROUP DETAILS
  =============
  GROUP MEMBERS	: PAROMITA DATTA & PARAS GARG
  GROUP SECTION	: CS 570-LA 
  LAB ASSIGNMENT - WEEK 7 : MAX HEAP SORT
*/
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.CopyOnWriteArrayList;

public class MaxHeap {
	private static List<Integer> input = new CopyOnWriteArrayList<>();
	//private static Integer[] intArr = new Integer[]{50, 20, 30, 40, 10, 70, 100, 80, 60, 90};

	public static void main(String[] args) {
		Scanner k = new Scanner(System.in);
		for(int i = 0; i < 10; i++) {
			System.out.print("Enter element " + (i+1) + ": ");
			String ip = k.nextLine();
			input.add(Integer.parseInt(ip));
			//input.add(intArr[i]);
			heapifyUp();
		}
		k.close();
		heapifyDown();
	}
		
//	first half of the list are parent nodes. Start from the bottom and heapify going up 
	private static void heapifyUp() {
		int toBeParent = Math.floorDiv(input.size() - 1,2); //fetches the middle pos
		for(int i = toBeParent; i >= 0; i--) {
			System.out.println("Parent at: " + i);
			System.out.println("Before max-heapifying: " + input);
			maxHeapify(i);
			System.out.println("After max-heapifying: " + input);
			System.out.println("-----------------------------------------------");
		}
	}

//	prepare max heap for i-th
	private static void maxHeapify(int parent) {
		int lChild = 2*parent + 1;
		int rChild = 2*parent + 2;
		int largest = parent;
		
		if(lChild < input.size() && input.get(lChild) > input.get(largest))
			largest = lChild;
		if(rChild < input.size() && input.get(rChild) > input.get(largest))
			largest = rChild;
		
//		swap parent value with the largest child
		if(largest != parent) {
			Integer temp = input.get(parent);
			input.set(parent, input.get(largest));
			input.set(largest, temp);
			
//			recursive call for next level
			maxHeapify(largest);
		}
	}
	
//	extract from heap
	private static void heapifyDown() {
		while(input.size() > 0) {
			System.out.println(input.get(0));
			Integer lastElem = input.remove(input.size() - 1);
			if(input.size() > 0) {
				input.set(0, lastElem);
				maxHeapify(0);
			}
		}
	}	
}
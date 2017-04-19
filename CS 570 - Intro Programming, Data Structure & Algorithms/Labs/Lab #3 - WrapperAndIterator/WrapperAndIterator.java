/*
  === GROUP DETAILS ===
  Class Section  : CS 570 LA
  Group Name     : Lab Group 24
  Members Name   : Paras Garg, Paromitta Dutta
*/

/*
  Lab Assignment 3:
  Write a fake vector class. 
  The class should use the built-in vector/list/array in your language of choice to effectively "wrap" inside of it an existing vector, 
  while presenting a limited vector-like functionality to the user. 
*/

import java.util.Scanner;

// main class
public class WrapperAndIterator {

	public static void main(String[] args) {
		int data, opt, loc;
		boolean exit = false;
		
		// objects
		Scanner inp = new Scanner(System.in);
		LinkedList list = new LinkedList();
		
		
		// user operations
		do {
			System.out.println("Select Option: \n\t1. Press '1' insert node at any location."
											+ "\n\t2. Press '2' insert node in last. "
											+ "\n\t3. Press '3' to delete node from any location."
											+ "\n\t4. Press '4' to delete node at last location."
											+ "\n\t5. Press '5' to print the list."
											+ "\n\t6. Press '6' to terminate program.");

			System.out.print("Enter choice : ");
			opt = inp.nextInt();
				
			if (opt > 0 && opt <= 6) {
				switch(opt) {
					// insert node at any location
					case 1 : 
						// value input and validation
						System.out.print("\nEnter Value : ");
						do {						
							data = inp.nextInt();
							
							if (data > 0) 	break;
							else 			System.out.print("\tInvalid Value. Enter Again : ");	
							
						} while(true);
						// location input and validation
						System.out.print("\nEnter Location : ");
						do {						
							loc = inp.nextInt();
							
							if (loc > 0) 	break;
							else System.out.print("\tInvalid Location. Enter Again : ");				

						} while(true);
					
						list.insert(data, loc);
						break;
			
					// insert node in last
					case 2 :
						// value input and validation
						System.out.print("\nEnter Value : ");
						do {						
							data = inp.nextInt();
							
							if (data > 0) 	break;
							else 			System.out.print("\tInvalid Value. Enter Again : ");				
						
						} while(true);
						// calling push function
						list.push(data);
						break;
			
					// delete node from any location
					case 3 : 
						// location input and validation
						System.out.print("\nEnter Location : ");
						do {						
							loc = inp.nextInt();
							
							if (loc > 0) 	break;
							else System.out.print("\tInvalid Location. Enter Again : ");				

						} while(true);
						
						// calling delete at particular location function
						if(list.isEmpty()) System.out.print("List is empty, nothing to print in the list.");	
						else if (list.countNodes() < loc) System.out.print("No such location found in the list.");
						else list.delete(loc);
						
						break;
						
					// delete node at last location
					case 4 :
						// calling pop function
						if(list.isEmpty()) System.out.print("List is empty, nothing to delete in the list.");	
						else list.pop();
						
						break;
						
					// print the list
					case 5 : 
						// calling print list function
						if(list.isEmpty()) System.out.print("List is empty, nothing to print in the list.");	
						else list.print();
						break;
						
					// terminate program
					case 6 :
						// assigning exit as true
						exit = true;
						break;
				
					default : System.out.print("\nInvalid input. Try again.");		
				}
			}
						
			else {
				System.out.print("\tInvalid choice. Enter again : ");
			}
			
			System.out.print("\n");
			
		} while(exit == false);
	}
}

// node class
class Node {
	public int data;
	public Node next;
	
	// constructor
	Node(int value) {
		data = value;
	}
	
	// printing node value
	public void printLink() {
	    System.out.print("\n|" + data + "|");
    }
}

// linked list class
class LinkedList {
	private Node head, current;
	
	// constructor
	LinkedList() {
		head = null;
		current = null;
	}
	
	// checking list whether empty or not
	public boolean isEmpty() {
		if (head == null) return true;
		return false;
	}
	
	// inserting node at specified location
	public void insert(int value, int loc) {
		current = head;
		
		// case 1 : starting of the list
		if (loc == 1) {
			if (head == null)
				push(value);
				
			else {
				Node node = new Node(value);
				head = node;
				head.next = current;
			}
		}
		
		int countNode = countNodes();
		
		// case 2 : between two nodes of the list
		if (loc < countNode) {
			current = head;
			
			for (int i = 2; i < loc; i++) current = current.next;
						
			Node node = new Node(value);
			node.next = current.next;
			current.next = node;
		}
		
		// case 3 : end of the list
		else if (loc > countNode) {
			
			// creating empty nodes
			for (int i = 1; i < loc - countNode; i++) {
				push(0);
			}
			
			// creating node on specified location
			push(value);
		}
	}
			
	// inserting node in last location
	public void push(int value) {
		Node node = new Node(value);
		
		if (isEmpty())  head = node;
		else {
			// parsing current through end
			while(current.next != null) 
				current = current.next;
			current.next = node;	
		}
		
		current = node;
		node.next = null;
	}
	
	// delete at specified location
	public void delete(int loc) {
		int countNode = countNodes();
		// case 1 : first node
		if (loc == 1) {
			head = head.next;
		}
		
		// case 2 : any node inside list exclusive ends
		else if (loc < countNode) {
			current = head;
			for (int i = 2; i < loc; i++) 
				current = current.next;
			
			current.next = current.next.next;			
		}
			
		// case 3 : last node
		else if (loc == countNode)
			pop();
	}
	
	// deleting last node
	public void pop() {
		Node temp = head;
		
		// parsing current pointer till last node
		while(current.next != null)
			current = current.next;
		
		// parsing tem2p node pointer till second last node
		while (temp.next.next != null) 
			temp = temp.next;
		
		current = temp;
		current.next = null;
	}
	
	// printing list
	public void print() {
		Node currentNode = head;
	    System.out.print("List: ");
	    while(currentNode != null) {
	    	currentNode.printLink();
	    	currentNode = currentNode.next;
	    }
	    System.out.println("\n");
	}
	
	// counting number of nodes
	public int countNodes() {
		current = head;
		int countNode = 1;
		
		if (current.next == null);
		
		else {
			while(current.next != null) {
				countNode ++;
				current = current.next;
			}
		}
		
		return countNode;
	}
}
	
	

// importing libraries
import java.io.File;
import java.io.FileReader;
import java.util.Scanner;

public class BinarySearchTree {

	public static void main(String[] args) {
		
		// reading data from a file
		ReadFileData rf = new ReadFileData();
		String fData = rf.ReadData();

		// filling a binary search tree
		Tree tree = new Tree();
		
		String fVal = "";
		for (int i = 0; i < fData.length(); i++) {
			if(fData.charAt(i) == ',') {
				tree.add(Integer.parseInt(fVal));
				fVal = "";
				i++;
			}
			
			else if (fData.charAt(i) == ' ')
				i++;
			
			else 
				fVal += fData.charAt(i);
		}
		if (fVal != "")
			tree.add(Integer.parseInt(fVal));
	
		// user input
		System.out.print("Enter number to search :: ");
		Scanner inp = new Scanner(System.in);
		String inpt;
		int usrInp;
		String regex = "^\\d+$";
		while (true) {
			inpt = inp.nextLine();

			if(inpt.matches(regex)) {
				usrInp = Integer.parseInt(inpt);			
				break;
			} else 
				System.out.print("\tEnter again : ");
		}
			
		// searching value
		tree.contains(usrInp);
	}
}

// tree node class
class Node {
	int value;
	Node left;
	Node right;
	
	// class constructor
	Node(int nodeValue) {
		this.value = nodeValue;
		this.left = null;
		this.right = null;
	}
}

// tree class
class Tree {	
	private Node root;
	
	// class constructor
	Tree() {
		root = null;
	}
	
	// checking whether tree is empty or not
	public void isEmpty() {
		System.out.println("No");
	}
	
	
	// adding value to tree
	public void add(int nodeValue) {
		// checking root node
		if (root == null) {
			root = new Node(nodeValue);
		} else {
			addLeaf(root, nodeValue);
		}
	}
	
	public void addLeaf(Node current, int nodeValue) {
		// add leaf node to left
		if (nodeValue <= current.value) {
			
			if (current.left == null) {
				current.left = new Node(nodeValue);
			} else {
				addLeaf(current.left, nodeValue);
			}
		}
		// adding leaf node to right
		else if (nodeValue > current.value) {
			
			if (current.right == null) {
				current.right = new Node(nodeValue);
			} else {
				addLeaf(current.right, nodeValue);
			}
		}
	}
	
	
	
	// searching for a value
	public void contains(int searchValue) {
		if(root == null) {
			isEmpty();
		} else {
			contains(root, searchValue);
		}
	}
	
	public void contains(Node current, int searchValue) {
		
		// traversing left
		if (current.value > searchValue && current.left != null)
			contains(current.left, searchValue);

		// traversing right
		else if (current.value < searchValue && current.right != null)
			contains(current.right, searchValue);

		// on containing node
		else if (current.value == searchValue)
			System.out.println("\nYes");
		
		// no match
		else 
			System.out.println("\nNo");
	}
}

// class to read data from a file
class ReadFileData {
	File f;
	
	//method to read an input from a file
	public String ReadData() {
		FileReader fr = null;
		String fData = "";
		
		try {
			f= new File("infile.dat");
			
			// checking file
			if (f.exists() == true && f.isFile() == true && f.canRead() == true) {
				fr = new FileReader(f);
				int data;
				
				// reading data character by character
				while ( (data = fr.read()) >= 0 ) {
					fData += (char) data;
				}
			}
			
			else {
				// showing error while reading the file
				System.out.print("Something went wrong, either the 'file (input.dat) not found' "
						+ "or the 'file do not have read permission'.");
				System.exit(0);
			}
			
			// closing file
			fr.close();
		}
		catch(Exception ex) {
			System.out.print(ex);
		}
		
		return fData;
	}
}
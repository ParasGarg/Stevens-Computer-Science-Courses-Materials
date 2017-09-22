import java.util.Map;
import java.util.TreeMap;

public class RBTree{	
	public static void main(String[] args){
		// java implementation of RedBlackTrees as per javadoc
		// http://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html
		
		Map<String, String> rbTree = new TreeMap<String, String>();
		
		// sample function
		rbTree.put("key", "value");		// insert key value pairs
		rbTree.get("key"); 				// retrieves values associated with key value pairs
		rbTree.remove("key"); 			// delete keys
		rbTree.containsKey("key"); 		// search for a key in the dictionary

		// inserting values in a tree
		rbTree.put("hello", "world");
		rbTree.put("goodbye", "everyone");
		rbTree.put("name", "student");
		rbTree.put("occupation", "student");
		rbTree.put("year", "2016");
		rbTree.put("gpa", "4.0");
		rbTree.put("lab", "yes");
		rbTree.put("assignment", "no");
		rbTree.put("department", "cs");
		
/*		// proof that the tree is sorted by its keys
		for (Map.Entry<String, String> entry: rbTree.entrySet()) {
			System.out.println(entry.getKey() + "---" + entry.getValue());
		}
*/		
		// searching values in a tree
		String gpa = rbTree.get("gpa");
		String dept = rbTree.get("department");		
		System.out.println("The value of gpa is:: " + gpa);
		System.out.println("The value of department is:: " + dept);

		
/*		// proof that the tree is sorted even after key was removed
		rbTree.remove("goodbye");
		System.out.println("\n The tree after removing the 'goodbye' key:");
		for (Map.Entry<String, String> entry: rbTree.entrySet()) {
			System.out.println(entry.getKey() + "---" + entry.getValue());
		}
*/		
	}
}
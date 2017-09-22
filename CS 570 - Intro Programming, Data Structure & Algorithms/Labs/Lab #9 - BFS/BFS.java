import java.io.File;
import java.util.*;

public class BFS {
	private static List<Node> nodes;
	
	static class Node{
		String data;
		boolean visited;
		
		Node(String data) 
		{
			this.data = data;
		}
		public String toString(){
			return data;
		}
	}
	
	public void bfs(int adjMatrix[][]) {
		LinkedList<Node> queue = new LinkedList<Node>();
		nodes.get(0).visited = true;
		queue.add(nodes.get(0));
		while (!queue.isEmpty()){
			Node n = queue.remove();
			n.visited = true;
			LinkedList<Node> neighbors = findEligibleNeighbors(adjMatrix, n);
			queue.addAll(neighbors);
			System.out.println(n + "\t" +neighbors.size());
		}
	}
	
	public LinkedList<Node> findEligibleNeighbors(int adjMatrix[][], Node x){
		int nodeIndex = -1;
		for (int i = 0; i <nodes.size(); i++){
			if (nodes.get(i).equals(x)) {
				nodeIndex = i;
				break;
			}
		}
		
		LinkedList<Node> neighbors = new LinkedList<Node>();
		for (int j = 0; j < adjMatrix[nodeIndex].length; j++) {
			if(adjMatrix[nodeIndex][j] == 1){
				if(!nodes.get(j).visited) {
					nodes.get(j).visited = true;
					neighbors.add(nodes.get(j));
				}
			}
		}
		return neighbors;
	}

 public static void main(String[] args) throws Exception {
	 File f = new File("infile.dat");
	 Scanner in = new Scanner(f);
	 int count = Integer.parseInt(in.nextLine());
	 nodes = new ArrayList<Node> (count);
	 int adjMatrix[][] = new int[count][count];
	 
	 String[] vertices = in.nextLine().split(" ");
	 for (String vertex : vertices) {
		 nodes.add(new Node(vertex));
	 }
	
	 while(in.hasNext()) {
		 String[] line = in.nextLine().split(" ");
		 String v1 = line[0].trim();
		 String v2 = line[1].trim();
		 int v1Idx = -1;
		 int v2Idx = -1;
		 for (int i=0; i < nodes.size(); i++){
			 if (nodes.get(i).toString().equals(v1))
				 v1Idx = i;
			 
			 if (nodes.get(i).toString().equals(v2))
				 v2Idx = i;
			 
			 if (v1Idx != -1 && v2Idx !=-1)
				 break;
		 }
		 adjMatrix[v1Idx] [v2Idx] = 1;
		 adjMatrix[v2Idx] [v1Idx] = 1;
	 }
	 in.close();

	 BFS bfs = new BFS();
	 bfs.bfs(adjMatrix);
	}

}

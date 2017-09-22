import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.CopyOnWriteArrayList;

public class TopoSort {
	int vCount;
	List<Integer> adjList[];
	List<Integer> sortedV = new ArrayList<Integer>();
	
	public TopoSort(int vCount){
		this.vCount = vCount;
		adjList = new ArrayList[vCount];
		for(int i = 0; i < vCount; i++)
			adjList[i] = new ArrayList<Integer>();
	}
	
	public void addEdge(int x, int y){
		adjList[x].add(y);
	}
	
	public void resetSortedList(){
		sortedV = new ArrayList<Integer>();
	}

	public void topologicalSort(boolean alternateStartPoint){
		int indegree[] = new int[vCount];
		// adjacency list to fill indegrees
		for (int i = 0; i < vCount; i++){
			ArrayList<Integer> temp = (ArrayList<Integer>) adjList[i];
			for(int node : temp){
				indegree[node]++;
			}
		}
		
		// create a list of vertices with indegree 0
		List<Integer> originV = new CopyOnWriteArrayList<Integer>();
		for (int i = 0; i < vCount; i++ ){
			if (indegree[i] == 0)
				originV.add(i);
		}
		
		//reverse the origin vertices list to start from alternate point
		if(alternateStartPoint){
			List<Integer> reverseOriginV = new CopyOnWriteArrayList<Integer>();
			for (int i = originV.size() - 1; i>=0; i--){
				reverseOriginV.add(originV.get(i));
			}
			originV = reverseOriginV;
		}
		
		while(!originV.isEmpty()){
			int temp = originV.remove(0);  // take first element
			sortedV.add(temp);
			for(int node : adjList[temp]){ //iterate through all neighbors of node and decrease indegree
				indegree[node]--;
				if(indegree[node] == 0)
					originV.add(node);
			}
		}
	}
	
	public String toString(){
		return sortedV.toString();
	}
	
	public static void main(String args[]) throws Exception {
		File f = new File("infile.dat");
		Scanner in = new Scanner(f);
		String countOfNodes = in.nextLine();
		
		TopoSort t = new TopoSort(Integer.parseInt(countOfNodes));	
		while(in.hasNext()){
			String[] line = in.nextLine().split(" ");
			int v1 = Integer.parseInt(line[0].trim());
			int v2 = Integer.parseInt(line[1].trim());
			t.addEdge(v1, v2);
		}
		in.close();
		t.topologicalSort(false);;
		System.out.println(t);
		
		t.resetSortedList();
		t.topologicalSort(true);
		System.out.println(t);
	}
}

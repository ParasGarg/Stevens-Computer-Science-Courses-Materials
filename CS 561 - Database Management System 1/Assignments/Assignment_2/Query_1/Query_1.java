/*
 * Student Name : Paras Garg
 * CWID			: ​10414982
 * Subject		: Database Management System 1 
 * Assignment	: #2
 * Query		: #1
 */

package Assignment_2.Query_1;

// importing packages
import java.sql.*;
import java.util.Enumeration;
import java.util.Hashtable;

public class Query_1 {
	
	// initializing static variables 
	public static Integer key = new Integer(1);
	public static Hashtable<Integer, SalesData_Q1> ht = new Hashtable<Integer, SalesData_Q1>();
	public static Enumeration<Integer> itr;
	public static Integer nextKey;
	
	public static void main(String[] args) {
		// database connection configuration
		String usr = "postgres";
		String pwd = "12345";
		String url = "jdbc:postgresql://localhost:5432/postgres";
		
		try {
			Class.forName("org.postgresql.Driver");
			System.out.println("Successfully loaded the driver!");			
		} catch (Exception ex) {
			System.out.println("Failed to load the driver!");
			ex.printStackTrace();
		}
		
		// connection server
		try {
			// opening connection
			Connection conn = DriverManager.getConnection(url, usr, pwd);
			System.out.println("Successfully connected to the server! \n");
			
			// get query result to ResultSet rs
			Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ResultSet rs = stmt.executeQuery("SELECT * FROM sales");
			
			// traversing through each element to get values that are combination of customer, product, and state
			while (rs.next()) {
			
				// storing values in object
				SalesData_Q1 sd = new SalesData_Q1();
				sd.setCustomer(rs.getString("cust"));
				sd.setProduct(rs.getString("prod"));
				sd.setState(rs.getString("state"));
				
				// calling method to create a data set which would be the combination of customer, product, and state
				createDataset(sd);				
			}
			
			// reseting header of ResultSet to first element 
			rs.beforeFirst();
			
			// traversing through each element for other/different products
			while (rs.next()) {
			
				// storing values in object
				SalesData_Q1 sd = new SalesData_Q1();
				sd.setCustomer(rs.getString("cust"));
				sd.setProduct(rs.getString("prod"));
				sd.setState(rs.getString("state"));
				sd.setQty(rs.getInt("quant"));
				
				// calculating for the same customers and states but for different products
				calculateQueries(sd);				
			}

			// displaying output
			System.out.println(String.format("%-8s", "CUSTOMER") + "  " + String.format("%-7s", "PRODUCT") + "  " 
					+ String.format("%-5s", "STATE") + "  " + String.format("%-8s", "CUST_AVG") + "  " 
					+ String.format("%-15s", "OTHER_STATE_AVG") + "  " + String.format("%-14s", "OTHER_PROD_AVG"));
			System.out.println("========  =======  =====  ========  ===============  ==============");
			
			itr = ht.keys();
			while(itr.hasMoreElements()) {
				nextKey = (Integer) itr.nextElement();
				
				System.out.println(String.format("%-8s", ht.get(nextKey).getCustomer()) + "  " 
						+ String.format("%-7s", ht.get(nextKey).getProduct()) + "  " + String.format("%-5s", ht.get(nextKey).getState()) + "  "
						+ String.format("%8s", ht.get(nextKey).getProductForStateAvg()) + "  " + String.format("%15s", ht.get(nextKey).getProductForOtherStateAvg()) + "  " 
						+ String.format("%14s", ht.get(nextKey).getOtherProductAvg()));
			}
			
			// closing connection
			conn.close();
		} catch (SQLException ex) {
			System.out.println("Connection URL or username or password errors!");
			ex.printStackTrace();
		}
	}
		
	// creating a data set for the combination of customer, product, and state
	public static void createDataset(SalesData_Q1 sd) {
		boolean addNewFlag = true;
		
		if (ht.isEmpty()) {						// adding values in hash table if null
			ht.put(key, sd);
			key++;
		} else {								// traversing hash table to check for existing values
			itr = ht.keys();
			while(itr.hasMoreElements()) {
				nextKey = (Integer) itr.nextElement();
				
				if (sd.getCustomer().equalsIgnoreCase(ht.get(nextKey).getCustomer()) && 
						sd.getProduct().equalsIgnoreCase(ht.get(nextKey).getProduct()) &&
						sd.getState().equalsIgnoreCase(ht.get(nextKey).getState())) {
				
					addNewFlag = false;
				}
			}
			
			if (addNewFlag) {
				ht.put(key, sd);
				key++;
			}
		}				
	}

	// calculating for the same customers and states but for different products
	public static void calculateQueries(SalesData_Q1 sd) {
		
		itr = ht.keys();
		while(itr.hasMoreElements()) {
			nextKey = (Integer) itr.nextElement();
			
			// checking condition #1 - the customer's average sale of this product for the state
			if (sd.getCustomer().equalsIgnoreCase(ht.get(nextKey).getCustomer()) && 
					sd.getProduct().equalsIgnoreCase(ht.get(nextKey).getProduct()) &&
					sd.getState().equalsIgnoreCase(ht.get(nextKey).getState()) ) {

				ht.get(nextKey).setProductForStateCount(ht.get(nextKey).getProductForStateCount() + 1);
				ht.get(nextKey).setProductForStateTotal(ht.get(nextKey).getProductForStateTotal() + sd.getQty());
				ht.get(nextKey).setProductForStateAvg(ht.get(nextKey).getProductForStateTotal() / ht.get(nextKey).getProductForStateCount());
				
			}
			
			// checking condition #2 - the average sale of the product and the customer but for the other states
			if (sd.getCustomer().equalsIgnoreCase(ht.get(nextKey).getCustomer()) && 
					sd.getProduct().equalsIgnoreCase(ht.get(nextKey).getProduct()) &&
					!sd.getState().equalsIgnoreCase(ht.get(nextKey).getState()) ) {
			
				ht.get(nextKey).setProductForOtherStateCount(ht.get(nextKey).getProductForOtherStateCount() + 1);
				ht.get(nextKey).setProductForOtherStateTotal(ht.get(nextKey).getProductForOtherStateTotal() + sd.getQty());
				ht.get(nextKey).setProductForOtherStateAvg(ht.get(nextKey).getProductForOtherStateTotal() / ht.get(nextKey).getProductForOtherStateCount());
			}
			
			// checking condition #3 - the customer’s average sale for the given state, but for the other products
			if (sd.getCustomer().equalsIgnoreCase(ht.get(nextKey).getCustomer()) && 
					sd.getState().equalsIgnoreCase(ht.get(nextKey).getState()) &&
					!sd.getProduct().equalsIgnoreCase(ht.get(nextKey).getProduct()) ) {
				
				ht.get(nextKey).setOtherProductCount(ht.get(nextKey).getOtherProductCount() + 1);
				ht.get(nextKey).setOtherProductTotal(ht.get(nextKey).getOtherProductTotal() + sd.getQty());
				ht.get(nextKey).setOtherProductAvg(ht.get(nextKey).getOtherProductTotal() / ht.get(nextKey).getOtherProductCount());
					
			}
		}
	}			
}
/*
 * Student Name : Paras Garg
 * CWID			: ​10414982
 * Subject		: Database Management System 1 
 * Assignment	: #2
 * Query		: #2
 */

package Assignment_2.Query_2;

// importing packages
import java.sql.*;
import java.util.Enumeration;
import java.util.Hashtable;

public class Query_2 {
	
	// initializing static variables 
	public static Integer key = new Integer(1);
	public static Hashtable<Integer, SalesData_Q2> ht = new Hashtable<Integer, SalesData_Q2>();
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
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Sales");
			
			// traversing through each element
			while (rs.next()) {
			
				// storing values in object
				SalesData_Q2 sd = new SalesData_Q2();
				sd.setCustomer(rs.getString("cust"));
				sd.setProduct(rs.getString("prod"));
				sd.setQty(rs.getInt("quant"));
				sd.setMonth(rs.getInt("month"));
				
				if (sd.getMonth() > 0 && sd.getMonth() < 13) {
					sd.setIsExist(sd.getMonth()-1);		// setting value existing flag
					
					sd.setMonthTotal(sd.getMonth()-1, sd.getQty());		// setting total
					sd.setMonthCount(sd.getMonth()-1, 1);				// setting count
					sd.setMonthAvg(sd.getMonth()-1, sd.getMonthTotal(sd.getMonth()-1) / sd.getMonthCount(sd.getMonth()-1));		// setting average
					
					// calculating average sales for month before and after of particular sale
					Calculate(sd);	
				}
			}
			
			// displaying output
			System.out.println(String.format("%-8s", "CUSTOMER") + "  " + String.format("%-7s", "PRODUCT") + "  " 
					+ String.format("%-5s", "MONTH") + "  " + String.format("%-10s", "BEFORE_AVG") + "  " 
					+ String.format("%-9s", "AFTER_AVG"));
			System.out.println("========  =======  =====  ==========  =========");
			
			itr = ht.keys();
			while(itr.hasMoreElements()) {
				nextKey = (Integer) itr.nextElement();
				
				for (int i = 0; i < 12; i++) {
					if (ht.get(nextKey).getIsExist(i)) {
					
						if (i == 0) {	// checking for first month of an year
							System.out.println(String.format("%-8s", ht.get(nextKey).getCustomer()) + "  " + String.format("%-7s", ht.get(nextKey).getProduct()) + "  " 
									+ String.format("%5s", i+1) + "  " 
									+ String.format("%10s", "<NULL>") + "  " + String.format("%9s", ht.get(nextKey).getMonthAvg(i+1)));
						} else if (i == 11) {	// checking for last month of an year
							System.out.println(String.format("%-8s", ht.get(nextKey).getCustomer()) + "  " + String.format("%-7s", ht.get(nextKey).getProduct()) + "  " 
									+ String.format("%5s", i+1) + "  " 
									+ String.format("%10s", ht.get(nextKey).getMonthAvg(i-1)) + "  " + String.format("%9s", "<NULL>"));
						} else {	// checking for other months
							System.out.println(String.format("%-8s", ht.get(nextKey).getCustomer()) + "  " + String.format("%-7s", ht.get(nextKey).getProduct()) + "  " 
									+ String.format("%5s", i+1) + "  " 
									+ String.format("%10s", ht.get(nextKey).getMonthAvg(i-1)) + "  " + String.format("%9s", ht.get(nextKey).getMonthAvg(i+1)));
						}
					}
				}
			}
						
			// closing connection
			conn.close();
		} catch (SQLException ex) {
			System.out.println("Connection URL or username or password errors!");
			ex.printStackTrace();
		}
	}
	
	public static void Calculate(SalesData_Q2 sd) {
		boolean addNewFlag = true;
		
		if (ht.isEmpty()) {						// adding values in hash table if null
			ht.put(key, sd);
			key++;
		} else {								// traversing hash table for comparison and modification
			itr = ht.keys();
			while(itr.hasMoreElements()) {		// iterating hash table
				nextKey = (Integer) itr.nextElement();
				
				if (sd.getCustomer().equalsIgnoreCase(ht.get(nextKey).getCustomer()) && 
						sd.getProduct().equalsIgnoreCase(ht.get(nextKey).getProduct())) {
					addNewFlag = false;
					
					ht.get(nextKey).setIsExist(sd.getMonth()-1);
				
					ht.get(nextKey).setMonthTotal(sd.getMonth()-1, (ht.get(nextKey).getMonthTotal(sd.getMonth()-1) + sd.getQty()));
					ht.get(nextKey).setMonthCount(sd.getMonth()-1, (ht.get(nextKey).getMonthCount(sd.getMonth()-1) + 1));
					ht.get(nextKey).setMonthAvg(sd.getMonth()-1, (ht.get(nextKey).getMonthTotal(sd.getMonth()-1) / ht.get(nextKey).getMonthCount(sd.getMonth()-1)));
				}
			}
			
			if (addNewFlag) {
				ht.put(key, sd);
				key++;
			}	
		}
	}
}
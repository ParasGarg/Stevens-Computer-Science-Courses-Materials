/*
 * Student Name : Paras Garg
 * CWID			: ​10414982
 * Subject		: Database Management System 1
 * Assignment	: #2
 * Query		: #3
 */

package Assignment_2.Query_3;

// importing packages
import java.sql.*;
import java.util.Enumeration;
import java.util.Hashtable;

public class Query_3 {

	// initializing static variables 
	public static Integer key = new Integer(1);
	public static Hashtable<Integer, SalesData_Q3> ht = new Hashtable<Integer, SalesData_Q3>();
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
				SalesData_Q3 sd = new SalesData_Q3();
				sd.setCustomer(rs.getString("cust"));
				sd.setProduct(rs.getString("prod"));
				sd.setMonth(rs.getInt("month"));
				sd.setQty(rs.getInt("quant"));

				if (sd.getMonth() > 0 && sd.getMonth() < 13) {
					sd.setMonthTotal(sd.getMonth()-1, sd.getQty());
					sd.setMonthTarget(sd.getQty() / 3);

					// calculating 1/3 of total sales
					Calculate(sd);
				}
			}

			// displaying output
			System.out.println(String.format("%-8s", "CUSTOMER") + " " + String.format("%-7s", "PRODUCT") + "  " 
					+ String.format("%-22s", "1/3 PURCHASED BY MONTH"));
			System.out.println("======== =======  ======================");

			itr = ht.keys();
			while(itr.hasMoreElements()) {
				nextKey = (Integer) itr.nextElement();

				boolean isMinMonthPrinted = false;
				int targetAchieved = 0;
				for (int i = 0; i < 12; i++) {
					targetAchieved += ht.get(nextKey).getMonthTotal(i);
					
					if (targetAchieved >= ht.get(nextKey).getMonthTarget() &&
							isMinMonthPrinted == false) {

						System.out.println(String.format("%-8s", ht.get(nextKey).getCustomer()) + " " + String.format("%-7s", ht.get(nextKey).getProduct()) + "  " 
								+ String.format("%-22s", i+1));
						
						isMinMonthPrinted = true;
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
	
	public static void Calculate(SalesData_Q3 sd) {
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

					ht.get(nextKey).setMonthTotal(sd.getMonth()-1, ht.get(nextKey).getMonthTotal(sd.getMonth()-1) + sd.getQty());
					ht.get(nextKey).setMonthTarget(ht.get(nextKey).getMonthTarget() + sd.getMonthTarget());		
				}
			}
			
			if (addNewFlag) {
				ht.put(key, sd);
				key++;
			}	
		}
	}
}
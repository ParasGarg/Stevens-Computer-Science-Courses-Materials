package assignment_1.query_1;

// importing packages
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Sales");
			
			// traversing through each element
			while (rs.next()) {
			
				// parsing date in a format (MM/DD/YYYY) 
				Calendar calendar = Calendar.getInstance();
				calendar.set(Calendar.YEAR, rs.getInt("year"));
				calendar.set(Calendar.MONTH, rs.getInt("month") - 1);
				calendar.set(Calendar.DAY_OF_MONTH, rs.getInt("day"));
				
				Date dateObj = calendar.getTime();
				String date = new SimpleDateFormat("MM/dd/yyyy").format(dateObj);

				// storing values in object
				SalesData_Q1 sd = new SalesData_Q1();
				sd.setCustomerName(rs.getString("cust"));
				sd.setMinQty(rs.getInt("quant"));
				sd.setMinProduct(rs.getString("prod"));
				sd.setMinDate(date);
				sd.setMinState(rs.getString("State"));
				sd.setMaxQty(rs.getInt("quant"));
				sd.setMaxProduct(rs.getString("prod"));
				sd.setMaxDate(date);
				sd.setMaxState(rs.getString("State"));
				sd.setProductCount(1);
				sd.setProductQtySum(rs.getInt("quant"));
				sd.setAvgQty(sd.getProductQtySum() / sd.getProductCount());
								
				// calculating average, minimum and maximum values for each customer
				Calculate(sd);				
			}
			
			// displaying output
			System.out.println(String.format("%-8s", "CUSTOMER") + "  " + String.format("%5s", "MIN_Q") + "  " 
					+ String.format("%-8s", "MIN_PROD") + "  " + String.format("%-8s", "MIN_DATE  ") + "  " + String.format("%2s", "ST") + "  " 
					+ String.format("%5s", "MAX_Q") + "  " + String.format("%-8s", "MAX_PROD") + "  " + String.format("%-8s", "MIN_DATE  ") + "  " 
					+ String.format("%2s", "ST") + "  " + String.format("%5s", "AVG_Q"));
			System.out.println("========  =====  ========  ==========  ==  =====  ========  ==========  ==  =====");
			
			itr = ht.keys();
			while(itr.hasMoreElements()) {
				nextKey = (Integer) itr.nextElement();
				
				System.out.println(String.format("%-8s", ht.get(nextKey).getCustomerName()) + "  " 
						+ String.format("%5s", ht.get(nextKey).getMinQty()) + "  " + String.format("%-8s", ht.get(nextKey).getMinProduct()) + "  "
						+ String.format("%-10s", ht.get(nextKey).getMinDate()) + "  " + String.format("%2s", ht.get(nextKey).getMinState()) + "  " 
						+ String.format("%5s", ht.get(nextKey).getMaxQty()) + "  " + String.format("%-8s", ht.get(nextKey).getMaxProduct()) + "  "
						+ String.format("%-10s", ht.get(nextKey).getMaxDate()) + "  " + String.format("%2s", ht.get(nextKey).getMaxState()) + "  "
						+ String.format("%-10s", ht.get(nextKey).getAvgQty()));
			}
			
			// closing connection
			conn.close();
		} catch (SQLException ex) {
			System.out.println("Connection URL or username or password errors!");
			ex.printStackTrace();
		}
	}
		
	public static void Calculate(SalesData_Q1 sd) {
		boolean addNewFlag = true;
		
		if (ht.isEmpty()) {						// adding values in hash table if null
			ht.put(key, sd);
			key++;
		} else {								// traversing hash table for comparison and modification
			itr = ht.keys();
			while(itr.hasMoreElements()) {
				nextKey = (Integer) itr.nextElement();
				
				if (sd.getCustomerName().equalsIgnoreCase(ht.get(nextKey).getCustomerName())) {
					addNewFlag = false;
					
					if(sd.getMinQty() < ht.get(nextKey).getMinQty()) {
						ht.get(nextKey).setMinQty(sd.getMinQty());
						ht.get(nextKey).setMinProduct(sd.getMinProduct());
						ht.get(nextKey).setMinDate(sd.getMinDate());
						ht.get(nextKey).setMinState(sd.getMinState());
					} else if(sd.getMinQty() > ht.get(nextKey).getMaxQty()) {
						ht.get(nextKey).setMaxQty(sd.getMaxQty());
						ht.get(nextKey).setMaxProduct(sd.getMaxProduct());
						ht.get(nextKey).setMaxDate(sd.getMaxDate());
						ht.get(nextKey).setMaxState(sd.getMaxState());
					}
					
					ht.get(nextKey).setProductCount(ht.get(nextKey).getProductCount() + 1);
					ht.get(nextKey).setProductQtySum(ht.get(nextKey).getProductQtySum() + sd.getProductQtySum());
					ht.get(nextKey).setAvgQty(ht.get(nextKey).getProductQtySum() / ht.get(nextKey).getProductCount());
				}
			}
			
			if (addNewFlag) {
				ht.put(key, sd);
				key++;
			}
		}				
	}
}
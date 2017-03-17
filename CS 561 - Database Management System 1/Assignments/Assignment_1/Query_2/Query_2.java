package Assignment_1.Query_2;

// importing packages
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
			
				// parsing date in a format (MM/DD/YYYY) 
				Calendar calendar = Calendar.getInstance();
				calendar.set(Calendar.YEAR, rs.getInt("year"));
				calendar.set(Calendar.MONTH, rs.getInt("month") - 1);
				calendar.set(Calendar.DAY_OF_MONTH, rs.getInt("day"));
				
				Date dateObj = calendar.getTime();
				String date = new SimpleDateFormat("MM/dd/yyyy").format(dateObj);

				// storing values in object
				SalesData_Q2 sd = new SalesData_Q2();
				sd.setCustomer(rs.getString("cust"));
				sd.setProduct(rs.getString("prod"));
				sd.setState(rs.getString("state"));
				sd.setYear(rs.getInt("year"));
				sd.setNJQty(rs.getInt("quant"));
				sd.setNJDate(date);
				sd.setNYQty(rs.getInt("quant"));
				sd.setNYDate(date);
				sd.setCTQty(rs.getInt("quant"));
				sd.setCTDate(date);
								
				// calculating average, minimum and maximum values for each customer
				Calculate(sd);				
			}
			
			// displaying output
			System.out.println(String.format("%-8s", "CUSTOMER") + "  " + String.format("%-7s", "PRODUCT") + "  " 
					+ String.format("%-6s", "NJ_MAX") + "  " + String.format("%-10s", "DATE      ") + "  " 
					+ String.format("%-6s", "NY_MIN") + "  "  + String.format("%-10s", "DATE      ") + "  "
					+ String.format("%-6s", "CT_MIN") + "  "  + String.format("%-10s", "DATE      "));
			System.out.println("========  =======  ======  ==========  ======  ==========  ======  ==========");
			
			itr = ht.keys();
			while(itr.hasMoreElements()) {
				nextKey = (Integer) itr.nextElement();
				
				System.out.println(String.format("%-8s", ht.get(nextKey).getCustomer()) + "  " + String.format("%-7s", ht.get(nextKey).getProduct()) + "  " 
						+ String.format("%6s", ht.get(nextKey).getNJQty()) + "  " + String.format("%-10s", ht.get(nextKey).getNJDate()) + "  "
						+ String.format("%6s", ht.get(nextKey).getNYQty()) + "  " + String.format("%-10s", ht.get(nextKey).getNYDate()) + "  "
						+ String.format("%6s", ht.get(nextKey).getCTQty()) + "  " + String.format("%-10s", ht.get(nextKey).getCTDate()));
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
			while(itr.hasMoreElements()) {
				nextKey = (Integer) itr.nextElement();
				
				if (sd.getCustomer().equalsIgnoreCase(ht.get(nextKey).getCustomer()) && 
						sd.getProduct().equalsIgnoreCase(ht.get(nextKey).getProduct())) {
					addNewFlag = false;
					
					if(sd.getState().equalsIgnoreCase("NJ")) {
						if (sd.getNJQty() > ht.get(nextKey).getNJQty() && sd.getYear() < 2009) {
							ht.get(nextKey).setNJQty(sd.getNJQty());
							ht.get(nextKey).setNJDate(sd.getNJDate());
						}
					} else if(sd.getState().equalsIgnoreCase("NY")) {
						if (sd.getNYQty() < ht.get(nextKey).getNYQty() && sd.getYear() < 2009) {
							ht.get(nextKey).setNYQty(sd.getNYQty());
							ht.get(nextKey).setNYDate(sd.getNYDate());
						}
					} else if(sd.getState().equalsIgnoreCase("CT")) {
						if (sd.getCTQty() < ht.get(nextKey).getNYQty()) {
							ht.get(nextKey).setCTQty(sd.getCTQty());
							ht.get(nextKey).setCTDate(sd.getCTDate());
						}
					}					
				}
			}
			
			if (addNewFlag) {
				ht.put(key, sd);
				key++;
			}	
		}
	}
}
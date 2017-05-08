/*
 * Student Name : Paras Garg
 * CWID			: ​10414982
 * Subject		: Database Management System 1
 * Assignment	: #2
 * Query		: #3
 */

package Assignment_2.Query_3;

public class SalesData_Q3 {
	private String customer;
	private String product;
	private int month;
	private int qty;
	
	private int[] monthTotal = new int[12];
	private int monthTarget;
		
	// getters
	public String getCustomer() {
		return customer;
	}
	
	public String getProduct() {
		return product;
	}
	
	public int getQty() {
		return qty;
	}
	
	public int getMonth() {
		return month;
	}
	
	public int getMonthTotal(int index) {
		return monthTotal[index];
	}
	
	public int getMonthTarget() {
		return monthTarget;
	}
	
		
	// setters
	public void setCustomer(String customerName) {
		this.customer = customerName;
	}
	
	public void setProduct(String productName) {
		this.product = productName;
	}
	
	public void setQty(int qty) {
		this.qty = qty;
	}
	
	public void setMonth(int month) {
		this.month = month;
	}
	
	public void setMonthTotal(int index, int monthTotal) {
		this.monthTotal[index] = monthTotal;
	}
	
	public void setMonthTarget(int monthTarget) {
		this.monthTarget = monthTarget;
	}
	
	
	// initializing values
	public SalesData_Q3() {
		customer = null;
		product = null;
		month = -1;
		monthTarget = 0;
	}
}

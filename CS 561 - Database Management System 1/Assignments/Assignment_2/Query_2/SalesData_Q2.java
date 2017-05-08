/*
 * Student Name : Paras Garg
 * CWID			: ​10414982
 * Subject		: Database Management System 1 
 * Assignment	: #2
 * Query		: #2
 */

package Assignment_2.Query_2;

public class SalesData_Q2 {
	private String customer;
	private String product;
	private int qty;
	private int month;
	
	private boolean[] isExist = new boolean[12];
	private int[] monthTotal = new int[12];
	private int[] monthCount = new int[12];
	private int[] monthAvg = new int[12];
	
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
	
	public boolean getIsExist(int index) {
		return isExist[index];
	}
	
	public int getMonthTotal(int index) {
		return monthTotal[index];
	}
	
	public int getMonthCount(int index) {
		return monthCount[index];
	}
	
	public int getMonthAvg(int index) {
		return monthAvg[index];
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
	
	public void setIsExist(int index) {
		this.isExist[index] = true;
	}
	
	public void setMonthTotal(int index, int qty) {
		this.monthTotal[index] = qty;
	}
	
	public void setMonthCount(int index, int count) {
		this.monthCount[index] = count;
	}
	
	public void setMonthAvg(int index, int avg) {
		this.monthAvg[index] = avg;
	}
	
	
	// initializing values
	public SalesData_Q2() {
		customer = null;
		product = null;
		qty = 0;
		month = 0;
	}
}

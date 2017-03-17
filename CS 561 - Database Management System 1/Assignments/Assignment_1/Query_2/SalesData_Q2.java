package Assignment_1.Query_2;

public class SalesData_Q2 {
	private String customer;
	private String product;
	private String state;
	private int year;
	
	private int njQty;
	private String njDate;
	private int nyQty;
	private String nyDate;
	private int ctQty;
	private String ctDate;
	
	// getters
	public String getCustomer() {
		return customer;
	}
	
	public String getProduct() {
		return product;
	}
	
	public String getState() {
		return state;
	}
	
	public int getYear() {
		return year;
	}

	public int getNJQty() {
		return njQty;
	}
	
	public String getNJDate() {
		return njDate;
	}
	
	public int getNYQty() {
		return nyQty;
	}
	
	public String getNYDate() {
		return nyDate;
	}
	
	public int getCTQty() {
		return ctQty;
	}
	
	public String getCTDate() {
		return ctDate;
	}
	
		
	// setters
	public void setCustomer(String customerName) {
		this.customer = customerName;
	}
	
	public void setProduct(String productName) {
		this.product = productName;
	}
	
	public void setState(String stateName) {
		this.state = stateName;
	}
	
	public void setYear(int year) {
		this.year = year;
	}
	
	public void setNJQty(int quantity) {
		this.njQty = quantity;
	}
	
	public void setNJDate(String date) {
		this.njDate = date;
	}
	
	public void setNYQty(int quantity) {
		this.nyQty = quantity;
	}
	
	public void setNYDate(String date) {
		this.nyDate = date;
	}
	
	public void setCTQty(int quantity) {
		this.ctQty = quantity;
	}
	
	public void setCTDate(String date) {
		this.ctDate = date;
	}
}

package assignment_1.query_1;

public class SalesData_Q1 {
	private String customerName;
	private int minQty;
	private String minProduct;
	private String minDate;
	private String minState;
	private int maxQty;
	private String maxProduct;
	private String maxDate;
	private String maxState;
	
	private int productCount;
	private int productQtySum;
	private int avgQty;
	
	
	// getters
	public String getCustomerName() {
		return customerName;
	}
	
	public int getMinQty() {
		return minQty;
	}
	
	public String getMinProduct() {
		return minProduct;
	}
	
	public String getMinDate() {
		return minDate;
	}
	
	public String getMinState() {
		return minState;
	}
	
	public int getMaxQty() {
		return maxQty;
	}
	
	public String getMaxProduct() {
		return maxProduct;
	}
	
	public String getMaxDate() {
		return maxDate;
	}
	
	public String getMaxState() {
		return maxState;
	}	
	
	public int getProductCount() {
		return productCount;
	}
	
	public int getProductQtySum() {
		return productQtySum;
	}
	
	public int getAvgQty() {
		return avgQty;
	}
		
	// setters
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	
	public void setMinQty(int quantity) {
		this.minQty = quantity;
	}
	
	public void setMinProduct(String productName) {
		this.minProduct = productName;
	}
	
	public void setMinDate(String date) {
		this.minDate = date;
	}
	
	public void setMinState(String stateName) {
		this.minState = stateName;
	}
	
	public void setMaxQty(int quantity) {
		this.maxQty = quantity;
	}
	
	public void setMaxProduct(String productName) {
		this.maxProduct = productName;
	}
	
	public void setMaxDate(String date) {
		this.maxDate = date;
	}
	
	public void setMaxState(String stateName) {
		this.maxState = stateName;
	}	
	
	public void setProductCount(int count) {
		this.productCount = count;
	}
	
	public void setProductQtySum(int sum) {
		this.productQtySum = sum;
	}
	
	public void setAvgQty(int avg) {
		this.avgQty = avg;
	}
}

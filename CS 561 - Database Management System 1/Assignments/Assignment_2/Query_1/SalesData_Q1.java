/*
 * Student Name : Paras Garg
 * CWID			: ​10414982
 * Subject		: Database Management System 1 
 * Assignment	: #2
 * Query		: #1
 */

package Assignment_2.Query_1;

public class SalesData_Q1 {
	private String customer;
	private String product;
	private String state;
	private int quant;
	
	private int countProductForState;
	private int totalProductForState;
	private int avgProductForState;
	
	private int countProductForOtherState;
	private int totalProductForOtherState;
	private int avgProductForOtherState;

	private int countOtherProduct;
	private int totalOtherProduct;
	private int avgOtherProduct;
	
	//-------------------- constructor
	SalesData_Q1() {
		customer = null;
		product = null;
		state = null;
		quant = 0;
		
		countProductForState = 0;
		totalProductForState = 0;
		avgProductForState = 0;
		
		countProductForOtherState = 0;
		totalProductForOtherState = 0;
		avgProductForOtherState = 0;

		countOtherProduct = 0;
		totalOtherProduct = 0;
		avgOtherProduct = 0;
	}
	
	
	//-------------------- getters
	public String getCustomer() {
		if (customer.equals("")) {
			return "Null";
		}
		
		return customer;
	}
	
	public String getProduct() {
		if (product.equals("")) {
			return "Null";
		}
		
		return product;
	}
	
	public String getState() {
		if (state.equals("")) {
			return "Null";
		}
		
		return state;
	}
	
	public int getQty() {
		return quant;
	}
	
	// product for state methods
	public int getProductForStateCount() {
		return countProductForState;
	}
	
	public int getProductForStateTotal() {
		return totalProductForState;
	}
	
	public int getProductForStateAvg() {
		return avgProductForState;
	}
	
	
	// product for other state methods 
	public int getProductForOtherStateCount() {
		return countProductForOtherState;
	}
	
	public int getProductForOtherStateTotal() {
		return totalProductForOtherState;
	}
	
	public int getProductForOtherStateAvg() {
		return avgProductForOtherState;
	}
	
	
	// other product for the given state methods 
	public int getOtherProductCount() {
		return countOtherProduct;
	}
	
	public int getOtherProductTotal() {
		return totalOtherProduct;
	}
	
	public int getOtherProductAvg() {
		return avgOtherProduct;
	}

	
	//------------------------- setters
	public void setCustomer(String customer) {
		if (customer.equals("")) {
			this.customer = "Null";
		} else {
			this.customer = customer;
		}		
	}
	
	public void setProduct(String product) {
		if (product.equals("")) {
			this.product = "Null";
		} else {
			this.product = product;
		}		
	}
	
	public void setState(String state) {
		if (state.equals("")) {
			this.state = "Null";
		} else {
			this.state = state;
		}		
	}
	
	public void setQty(int quant) {
		this.quant = quant;		
	}
	
	
	// product for state methods
	public void setProductForStateCount(int count) {
		this.countProductForState = count;
	}
	
	public void setProductForStateTotal(int sum) {
		this.totalProductForState = sum;
	}
	
	public void setProductForStateAvg(int avg) {
		this.avgProductForState = avg;
	}
	
	
	// product for other state methods 
	public void setProductForOtherStateCount(int count) {
		this.countProductForOtherState = count;
	}
	
	public void setProductForOtherStateTotal(int sum) {
		this.totalProductForOtherState = sum;
	}
	
	public void setProductForOtherStateAvg(int avg) {
		this.avgProductForOtherState = avg;
	}
	
		
	// other product for the given state methods
	public void setOtherProductCount(int count) {
		this.countOtherProduct = count;
	}
	
	public void setOtherProductTotal(int sum) {
		this.totalOtherProduct = sum;
	}
	
	public void setOtherProductAvg(int avg) {
		this.avgOtherProduct = avg;
	}
}

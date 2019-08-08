import java.io.Serializable;

public class Transaction implements Serializable{
	private int type;
	private int debit;
	private int amount;
	private String id;
	
	public Transaction() {
		
	}
	
	public Transaction (String id, int type , int debit , int amount) {
		this.type = type;
		this.debit = debit;
		this.amount = amount;
		this.id = id;
	}
	
	public String getId() {
		return this.id;
	}
	
	public String getType() {
			
		if (this.type == 1) 
		{
			return "Cash & Cash equivalence";
		} 
		else if (this.type == 2) 
		{
			return  "Note & Accounts Receivable";
		} 
		else if (this.type == 3)
		{
			return "Supplies & Inventories";
		} 
		else if (this.type == 4) 
		{
			return "Other current assets";
		}
		else if (this.type == 5) 
		{
			return "Property, Plant & Equipment";
		}
		else if (this.type == 6)
		{
			return "Depreciation";
		}
		else if (this.type == 7)
		{
			return  "Other assets (including intangible assets)";
		}
		else if (this.type == 8) {
			return  "Note & Loan payable";
		}
		else if (this.type == 9) {
			return "Account payable & Other accrued liabilities ";
		}
		else if (this.type == 10) {
			return  "Long-term Liabilities";
		}
		else if (this.type == 11) {
			return  "Capital Stock";
		}
		else if (this.type == 12) {
			return  "Revenue - Retained Earnings";
		}
		else if (this.type == 13) {
			return "Expense - Retained Earnings";
		}
		return null;
	}

	
	public String getDebitCredit() {
		if (this.debit == 1) {
			return " Debit ";
		}
		return " Credit ";
	}
	
	public int getAmount() {
		return this.amount;
	}
	

}

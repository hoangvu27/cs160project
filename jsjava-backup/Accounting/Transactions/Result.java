import java.io.Serializable;
import java.util.List;

public class Result implements Serializable {
	private String id;
	private List<Transaction> t;
	
	public Result() {
		
	}
	
	public Result (String id, List<Transaction> t ) {
		this.id = id;
		this.t = t;
	}
	
	public String getId() {
		return this.id;
	}
	
	public List<Transaction> getTransactions() {
		return this.t;
	}
}

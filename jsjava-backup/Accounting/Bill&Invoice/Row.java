import java.io.Serializable;

public class Row implements Serializable{
	private String id;
	private String name;
	
	public Row() {
		
	}
	
	public Row (String id, String name) {
		this.id = id;
		this.name = name;
	}
	
	
	public String getId() {
		return this.id;
	}
	
	public String getName() {
		return this.name;
	}
	

}

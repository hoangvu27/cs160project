package loginRegister;
import java.sql.*;  
public class databaseInput {
	public  static int addUser(User user) {
		int position=0; 
		try
		{
			Connection connection = provider.getConnection();
			PreparedStatement ps=connection.prepareStatement("insert into user values(?,?,?)");  		
			ps.setString(1,user.getUserEmail());  
			ps.setString(2,user.getUsername());  
			ps.setString(3,user.getUserpass());  
			position=ps.executeUpdate();  
		}
		catch (Exception e) 
		{
		}
			return position;
	}
	

}

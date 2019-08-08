package loginRegister;


import java.sql.Connection;
import java.sql.DriverManager;

public class provider {
	static Connection connection = null;
	static Connection getConnection() {
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/myDB" , "root", "cs160project");
			// return connection; if return is put here, an error will appear 
			// cannot explain why & do not concern about this 
		}
		catch (Exception e) 
		{
			System.out.println(e);
		}
		return connection;
	}
}

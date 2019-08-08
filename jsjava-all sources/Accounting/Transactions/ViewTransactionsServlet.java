

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ViewTransactionsServlet
 */
@WebServlet("/ViewTransactionsServlet")
public class ViewTransactionsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public ViewTransactionsServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResultSet rs = null;

		List<Result> results = new ArrayList<Result>();
		List<Transaction> oneTransaction = new ArrayList<Transaction>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
	 	java.sql.Connection connection;
		connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
		
	 	PreparedStatement statement;
		statement = connection.prepareStatement("SELECT * FROM transactions");
//		get all id of transactions 
		rs =  statement.executeQuery();
		
		while (rs.next()) {
			 String targetId =   rs.getString("id")  ;
			 
			 PreparedStatement st;
			 st = connection.prepareStatement("SELECT * FROM transactionsTable where id=" + "'" + targetId + "'" );
			 ResultSet set = st.executeQuery();  
			 
			 while ( set.next() ) {
				 int type = set.getInt( "type");
				 int debit = set.getInt( "debit");
				 int amount = set.getInt( "amount");
				 Transaction t = new Transaction(targetId ,  type , debit , amount );
				 oneTransaction.add(t);
				
			 }
//			 Result r = new Result(targetId , oneTransaction);
//			 results.add(r);
		}
	 	connection.close();
	 	
			} catch (ClassNotFoundException | SQLException e) {

				e.printStackTrace();
			}
	
		
//		HttpSession session = request.getSession();
//		session.setAttribute("results", results);
		
//		request.setAttribute("results", results);
	 	
		request.setAttribute("results", oneTransaction);
		
	 	RequestDispatcher requestDispatcher = request.getRequestDispatcher("/ViewTransactions.jsp");
	    requestDispatcher.forward(request, response);
	}

}

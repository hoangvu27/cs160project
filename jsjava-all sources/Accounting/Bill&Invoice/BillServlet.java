

import java.io.FileWriter;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
 * Servlet implementation class BillServlet
 */
@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BillServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ResultSet rs = null;
		List<Integer> ids = new ArrayList<Integer>();
		List<String> names = new ArrayList<String>();
		List<Row> rows = new ArrayList<Row>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
	 	java.sql.Connection connection;
		connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
		
	 	PreparedStatement statement;
		statement = connection.prepareStatement("SELECT * FROM Item");
		
		rs =  statement.executeQuery();
		
		while (rs.next()) {
			 ids.add( Integer.valueOf( rs.getString("id") ) ) ;
			 names.add(  rs.getString("productName") );
			 
			 Row row = new Row(rs.getString("id") ,  rs.getString("productName") );

			 rows.add(row);
		}
	 	connection.close();
	 	
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		HttpSession session = request.getSession();
		session.setAttribute("rows", rows);
	 	
		
	 	RequestDispatcher requestDispatcher = request.getRequestDispatcher("/Bill.jsp");
	    requestDispatcher.forward(request, response);
	}

}

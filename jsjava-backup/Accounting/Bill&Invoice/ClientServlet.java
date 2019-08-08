

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
 * Servlet implementation class ClientServlet
 */
@WebServlet("/ClientServlet")
public class ClientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClientServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		ResultSet rs = null;
		List<Client> clients = new ArrayList<Client>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
		
	 	java.sql.Connection connection;
		connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
		
	 	PreparedStatement statement;
		statement = connection.prepareStatement("SELECT * FROM client");
		
		rs =  statement.executeQuery();
		
		while (rs.next()) {

			 
			 Client client = new Client(rs.getString("id") ,  rs.getString("fullname") );
			 clients.add(client);
		}
	 	connection.close();
	 	
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		HttpSession session = request.getSession();
		session.setAttribute("clients", clients);
	 	
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/Bill.jsp");
	    requestDispatcher.forward(request, response);
	}

}

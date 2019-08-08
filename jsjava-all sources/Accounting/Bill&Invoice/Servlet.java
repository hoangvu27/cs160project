

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Servlet
 */
@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("customerID");
		String message = "";
		double total = 0;
		
		if ( id != null ) {
			String dayCreated = request.getParameter("dayCreated");
			String dueDate = request.getParameter("dueDate");
			String invoiceNumber = request.getParameter("invoiceNumber");
			String orderNumber = request.getParameter("orderNumber");
			
			String[] itemId = request.getParameterValues("itemId");
			String[] quantity = request.getParameterValues("quantity");
			String[] price = request.getParameterValues("price");
			String[] tax = request.getParameterValues("tax");
			String[] discount = request.getParameterValues("discount");
			
			FileWriter fw = new FileWriter(new File("/Users/Student/cs160/", "bill.csv"));
			
			fw.append("customerId : " + id);
			fw.append("\n");
			fw.append("dayCreated : " + dayCreated);
			fw.append("\n");
			fw.append("dueDate : " + dueDate);
			fw.append("\n");
			fw.append("invoiceNumber : " + invoiceNumber);
			fw.append("\n");
			fw.append("orderNumber : " + orderNumber);
			fw.append("\n");
			
			fw.append("itemId ,");
			fw.append("quantity ,");
			fw.append("price ,");
			fw.append("tax ,");
			fw.append("discount ");
			fw.append("\n");
			try {
				
				for (int i=0 ; i < itemId.length; i++) {
					double temp = ( Double.parseDouble( tax[i] ) -  Double.parseDouble( discount[i] ) ) / 100;
					total += Double.parseDouble( quantity[i] ) * Double.parseDouble( price[i] )
								* ( 1 + temp ) ;
					
					
					fw.append( itemId[i] );
					fw.append(",");
					fw.append(quantity[i]);
					fw.append(",");
					fw.append(price[i] );
					fw.append(",");
					fw.append(tax[i]);
					fw.append(",");
					fw.append(discount[i]);
					fw.append("\n");
				}
			} catch (Exception e) {
				e.printStackTrace();
				message = "Invalid data of some inputs";
			}
			fw.append("Total : " + total);
			fw.append("\n");
			
			fw.close();
		}
		request.setAttribute("message", message);
		request.setAttribute("total", total);
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/Bill.jsp");
	    requestDispatcher.forward(request, response);
	}

}

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<span style="color: aqua; font-size: 30px"> NEW ITEM OR SERVICE </span> <br>
	<form method="post">
		ID: : <br> <input required type="text" name="id" required> <br>
		Name : <br> <input  required type="text" name="productName" >  <br>
		
		Type: <br> <select name="type">
  			<option value="product">product</option>
  			<option value="service">service</option>
		</select> <br>
		
		Description: <br> <textarea rows="10" cols="50" name="description"> </textarea> <br>
		Price per item / Rate per hour : <br>
		<input required type="number" name="price"  value="0.00" onchange="format(this)" step="0.01" > <br>
		
		Tax (%) : <br> 
		<input type="number" name="tax" value="0.00" onchange="format(this)"  step="0.01"> <br>
		<input type="submit" value="Save Item">
	</form>
	
	<script>
		function format(element) {
    element.value = parseFloat(element.value).toFixed(2);
	}
	</script>
	
	 <%@ page import="java.sql.*" %>
	 <%@ page import="javax.sql.*" %>
	 <%
	 	String id = request.getParameter("id");
		String productName =  request.getParameter("productName");
	 	String type = request.getParameter("type");
	 	
	 	String description =  request.getParameter("description");
	 	String price = request.getParameter("price");
	 	String tax =  request.getParameter("tax");
	 	
	 	Class.forName("com.mysql.jdbc.Driver");
	 	java.sql.Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
	 	Statement statement = connection.createStatement();
		
	 	if (id != null ) {
	 		String temp1 = "'" + id + "'";
	 		String temp2 = "'" + productName  + "'";
	 		String temp3 = "'" + type + "'";
	 		String temp4 = "'" + description + "'";
	 		
	 		String temp5 = "'" + price  + "'";
	 		String temp6 = "'" + tax + "'";	
	 		
	 		
	 		String fullStatement =  temp1 + "," + temp2 + "," + temp3 +  "," + temp4 + ","
	 						+  temp5 + "," + temp6 ;
	 		try {				
	 			int temp = statement.executeUpdate("INSERT INTO item values(" + fullStatement + ");" ); 
	 		}
			catch (Exception e) {
				out.println("Something is wrong. Maybe id already existed");
			}
		 	out.println("created item");
	 	}
	 %>
	 
	 
</body>
</html>
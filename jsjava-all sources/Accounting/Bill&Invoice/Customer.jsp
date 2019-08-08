<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<style>
.grid-container {
  display: grid;
  grid-template-columns: auto auto;
  grid-column-gap: 50px;
  grid-row-gap: 10px;
  background-color: white;
  padding: 10px;
}

.grid-container > div {
  background-color: rgba(255, 255, 255, 0.8);
  text-align: left;
  padding: 10px 0px;
  font-size: 20px;
}
</style>
</head>
<body>
	<span style="color: aqua; font-size: 30px"> NEW CLIENT </span> <br>
	<span style="color: red; font-size: 15px"> ** means required field </span> <br>
	<span style="color: red; font-size: 15px"> Assuming billing address is the same as shipping address </span> <br>
	<a href="http://localhost:8080/Accounting/Customer.jsp"> Create new Customer</a>
	
	<form method="post"> 
<div class="grid-container">
<div style="font-family: 'Abril Fatface';font-size: 15px;" > Main information  </div><br>
  <div class="item0"> ID: ** <br> <input type="text" name="id" required> </div>
  <div class="item1"> Full Name : ** <br> <input type="text" name="fullname" required> </div>
  <div class="item2"> DOB: <br> <input type="date" name="bday"> </div>
  <div class="item3"> Email : <br>  <input type="text" name="email" > </div>  
  
  
  <div class="item4"> Phone: <br> <input type="tel" name="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" maxlength="12" >
  					<br>	<span>Format: 123-456-7890 </span></div>
  <div class="item5"> Address : <br>  <input type="text" name="address" > </div>
  <div class="item6"> Post Codes : <br>  <input type="text" name="postcode" pattern="[0-9]{5}"  maxlength="5"></div>
  
  
  <div class="item7"> City : <br>  <input type="text" name="city" > </div>
  <div class="item8"> Country : <br>  <input type="text" name="country" ></div>
  <br>
  
  
	Other information: 
	<div class="itemNone"></div>
	<div class="item9">Organizational Name: <br>  <input type="text" name="OName"> </div>
	<div class="item10"> gender: <br> <input type="text" name="gender"> </div>
	<div class="item11">  The payment is in USD dolalrs </div>
	<div class="item12">  Notes: <br> <textarea rows="10" cols="50" name="notes"> </textarea> </div>
</div>
		
		<input type="submit" value="Save Client">
	</form>
	
	 <%@ page import="java.sql.*" %>
	 <%@ page import="javax.sql.*" %>
	 <%
		String id =  request.getParameter("id");
	 	String fullname = request.getParameter("fullname");
	 	String date =  request.getParameter("date");
	 	String email = request.getParameter("email");
	 	
	 	String phone =  request.getParameter("phone");
	 	String address = request.getParameter("address");
	 	String postcode =  request.getParameter("postcode");
	 	String city = request.getParameter("city");
	 	
	 	String country =  request.getParameter("country");
	 	String OName = request.getParameter("OName");
	 	String gender =  request.getParameter("gender");
	 	String notes =  request.getParameter("notes");
	 	
	 	Class.forName("com.mysql.jdbc.Driver");
	 	java.sql.Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
	 	Statement statement = connection.createStatement();
	 	if (id != null & fullname != null) {
	 		
	 		String temp1 = "'" + id + "'";
	 		String temp2 = "'" + fullname  + "'";
	 		String temp3 = "'" + date + "'";
	 		String temp4 = "'" + email + "'";
	 		
	 		String temp5 = "'" + phone  + "'";
	 		String temp6 = "'" + address + "'";	
	 		String temp7 = "'" + postcode + "'";
	 		String temp8 = "'" + city  + "'";
	 		
	 		String temp9 = "'" + country + "'";
	 		String temp10 = "'" + OName + "'";
	 		String temp11 = "'" + gender  + "'";
	 		String temp12 = "'" + notes  + "'";
	 		
	 		String fullStatement =  temp1 + "," + temp2 + "," + temp3 +  "," + temp4 + ","
	 						+  temp5 + "," + temp6 + "," + temp7 +  "," + temp8 + ","
	 						+  temp9 + "," + temp10 + "," + temp11 +  "," + temp12;
	 		int temp = 0;
	 		try {
	 			 temp = statement.executeUpdate("INSERT INTO client values(" + fullStatement + ");" ); 
	 		}
	 		catch (Exception e)
	 		{
	 			out.println("Something is wrong. Maybe customer already existed");
	 		}
	 		
	 		if (temp != 0) { 
	 				out.println("Customer created");	
	 		}
	 		
	 	}
	 %>
</body>
</html>
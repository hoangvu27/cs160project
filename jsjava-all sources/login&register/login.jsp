<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
</head>
<body>
	<form>
	username:  <input type="text" name="username"> <br>
	password: <input type="password" name="password"> <br> 
				<!-- need to have show / hide button ???? -->
	<input type="submit" name="submit" value="login">  
	 <a href="register.jsp"> registration</a> <br>
	 </form>
	 
	 <%@ page import="java.sql.*" %>
	 <%@ page import="javax.sql.*" %>
	 <%
		String username =  request.getParameter("username");
	 	String password = request.getParameter("password");
	 	Class.forName("com.mysql.jdbc.Driver");
	 	java.sql.Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
	 	Statement statement = connection.createStatement();
		if (username != null & password != null) {
			
		
	 	String temp1 = "'" + username + "'"; 
	 	ResultSet queryResult = statement.executeQuery("select * from person where name=" + temp1);
	 	if ( queryResult.next() == true ) // fix this, since no same username should exist 
	 	{
	 		String test = queryResult.getString(2);
	 		if ( queryResult.getString(2).equals(password)  ) 
	 		{
	 			out.println("login success");
	 		} 	
			
	 	}
		}	
	 %>
</body>
</html>
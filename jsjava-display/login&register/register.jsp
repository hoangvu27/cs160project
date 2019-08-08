<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- <form action="process.jsp"> -->
	<form>
	username:  <input type="text" name="username"> <br>
	password: <input type="password" name="password1"> <br>
	<!-- retyped password: <input type="text" name="password2"> <br> -->
	email:		<input type="text" name="email"> <br>
	<!-- name:	<input type="text" name="name"> <br> -->
	<input type="submit" name="submit" value="register">  
	 <a href="login.jsp"> login</a> <br>
	 </form>
	 
	 <%@ page import="java.sql.*" %>
	 <%@ page import="javax.sql.*" %>
	 <%
	 	String email =  request.getParameter("email");
	 	String username =  request.getParameter("username");
	 	session.setAttribute("email", email);
	 	String password = request.getParameter("password1");
	 	Class.forName("com.mysql.jdbc.Driver");
	 	java.sql.Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/myDB?verifyServerCertificate=false&useSSL=true" , "root", "cs160project");
	 	Statement statement = connection.createStatement();
	 	if ( email != null && username != null && password != null ) {
	 		String temp1 = "'" + username + "'";
	 		String temp2 = "'" + password  + "'";
	 		String temp3 = "'" + email + "'";
	 		int temp = statement.executeUpdate("INSERT INTO person values(" + temp1 + "," + temp2 + "," + temp3 + ");" ); 
	 	out.println("registered successfully");
	 	}
	 %>
</body>
</html>
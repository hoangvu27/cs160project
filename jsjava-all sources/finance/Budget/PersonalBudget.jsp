<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<div ><span style="color: aqua; font-size: 30px;"> Personal Budget</span> <br></div>
	<br>
		<a href="http://localhost:8080/loginRegister/loginLogoutjsp.jsp" => Home </a>
	
	<form method="post" id="myForm"> 
		Add Income/Fund:  <input type="number" required step="1" name="income" >
		<input type="submit" value="submit">
	</form>
	<br>
	<form >
	Date	<input required type="date" name="theDate">
		<div id="items"></div>
		<input type="submit" value="submit">
	</form>
	<br>
	<button onclick="addExpenses()"> Add expenses </</button>
	<button onclick="removeExpenses()"> Remove expenses </button><br>
	
	<%@ page import="java.sql.*" %>
	 <%@ page import="javax.sql.*, java.util.Date" %>
	 <%@ page import="java.text.DateFormat, java.text.SimpleDateFormat, java.net.URLEncoder" %>
	 <%@ page import="javax.servlet.http.HttpUtils.*" %>
	 <%
// 	 java.net.UrlEncoder.encode(s ,"UTF-8").replace("+","%20");
	 String income = request.getParameter("income");
	 String[] type = request.getParameterValues("type");
	 String[] amount = request.getParameterValues("amount");
	 String date = request.getParameter("theDate");
	 
	 try {
			Class.forName("com.mysql.jdbc.Driver");
			
	 	java.sql.Connection connection;
		connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
		
	 	PreparedStatement statement;
		statement = connection.prepareStatement("SELECT * FROM summary");
		
		ResultSet rs =  statement.executeQuery();
		
		if (rs.next() == false) {
// 			String querry = "INSERT INTO summary VALUES ("
// 					+ 0 + "," + 0 + "," + 0 +")";
			String querry = "INSERT INTO summary (income, expenses, saving) VALUES (?,?,?)";
			
			statement = connection.prepareStatement(querry);
			statement.setInt(1, 0);
			statement.setInt(2, 0);
			statement.setInt(3, 0);
			statement.execute();
		}
		statement = connection.prepareStatement("SELECT * FROM summary");
		ResultSet result =  statement.executeQuery();
		result.next();
		
		if (income != null ) {
			int a  = Integer.parseInt(income) + result.getInt("income");
			
			String querry = "UPDATE summary SET income=" + a + "";
			statement = connection.prepareStatement(querry);
			statement.executeUpdate();
	 	}
		
		if (type != null && amount != null && date != null ) {
			int b  = result.getInt("expenses");
// 			System.out.println("=============");
// 			System.out.println(date);
// 			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
// 			Date d = sdf.parse(date);
// 			System.out.println(d);
			System.out.println(java.sql.Date.valueOf(date)); 
			
// 			sdf.applyPattern("YYYY-MM-DD");
// 			String temp = sdf.format(d);
// 			System.out.println(temp);
			String querry = "";
			
			for (int i = 0; i < type.length; i++) {
				querry = "INSERT INTO expenses (type, amount, date) VALUES (?,?, ?)";
				statement = connection.prepareStatement(querry);
				statement.setInt(1, Integer.parseInt(type[i]) );
				statement.setInt(2, Integer.parseInt(amount[i]) );
				statement.setDate(3, java.sql.Date.valueOf(date)  );
				b += Integer.parseInt(amount[i]);
				statement.execute();
			}
			querry = "UPDATE summary SET expenses=" + b + "";
			statement = connection.prepareStatement(querry);
			statement.executeUpdate();
 
		}
	

	 	connection.close();
	 	
		} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
		}

	 %>


	<script>
	let item = 0;
	
	function addExpenses() {
		item += 1
		document.getElementById("items").insertAdjacentHTML("beforeend", '<div> <select name="type"> <option value="1">Transportation</option> <option value=2>Housing</option> <option value="3">Utilities</option> <option value="4">Entertainment</option> <option value="5">Medical Expenses</option> <option value="6">Education</option> <option value="7">Taxes</option>  <option value="8">Gifts + Contributions</option> <option value="9">Miscellaneous</option></select> Amount: <input type="number" required step="1" name="amount" > <br> </div>');
		
	}
	
	function removeExpenses() {
		if (item === 0) { alert("No more item to be removed")}
		else {
			item -= 1 ;
			let list = document.getElementById("items");
				list.removeChild(list.childNodes[list.childNodes.length - 1 ] );
		}
	}
	</script>
</body>
</html>
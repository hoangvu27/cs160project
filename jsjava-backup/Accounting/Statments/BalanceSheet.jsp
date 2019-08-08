<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
	 <%
			
	 	int[] list = new int[13];
	 
	 	Class.forName("com.mysql.jdbc.Driver");
	 	java.sql.Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
	 	
	 	Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery("select * from BS");
	 	if ( rs.next() == true ) 
	 	{
	 		for (int i= 1; i<=13; i++ ) {
	 			list[i-1] = rs.getInt( i );
	 		}
	 	}
	 	
	 	int assetSum = 0;
	 	int otherHalf  = 0;
	 	for (int i= 1; i<=7; i++ ) {
	 		assetSum += list[i-1];
 		}
	 	
	 	for (int i= 8; i<=13; i++ ) {
	 		otherHalf += list[i-1];
 		}
	 	otherHalf = -1 * otherHalf;
	 	
	 	int RE = -1 * (list[11] + list[12]);
	 	int revenue = -1 * list[11];
	 %>
	 
<div><span style="color: aqua; font-size: 30px;"> BALANCE SHEET </span> <br>
<a href="file:///Users/Student/Dropbox/JSP%20&%20Javascript%20project/Accounting/mainAccounting.html">Main Accounting </a> <br>

================================ <br>

1.	Cash & cash equivalence     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <%= list[0] %> <br><br>

2.	Note & Accounts receivable   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    <%= list[1] %>  <br>

3.	Supplies & inventories 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <%= list[2] %>  <br>

4.	Other current assets (prepaid rent & insurances) 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%= list[3] %> <br>


5.	Property, plant & equipment 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%= list[4] %> <br>

6.	Depreciation 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%= list[5] %> <br> 

7.	Other assets (including intangible assess )	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%= list[6] %> <br><br>


	TOTAL  ASSET   	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <%=assetSum %>   <br>
	
	===================== <br><br>
	

8.	Note & loan payable 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%= -1 * list[7] %> <br>

9.	Account payable & other accrued liabilities 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
	( salaries payable, tax payable, interest payable, unearned fees) 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= -1 * list[8] %> <br>

10.	Long-term debt & bonds 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= -1 * list[9] %> <br>



11.	Capital stock 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= -1 * list[10] %> <br>

12.	Retained earnings  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= RE %> <br><br>
	
	TOTAL  LIABILITIES + EQUITY   	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <%= otherHalf %> <br>
	
	
==================================
<div><span style="color: aqua; font-size: 30px;"> INCOME </span> <br>
<div style="font-family: 'Abril Fatface';font-size: 30px; color: red"> Sorry, full income report is not available now. </div> <br>
<div style="font-family: 'Abril Fatface';font-size: 30px; color: red">	Future release will include more catageories for
 incomes and expenses </div><br>
 
 
 Revenue : 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <%=revenue  %> <br>
 
 Expense : 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= list[12] %> <br><br>
 
 Net Income : 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= RE %> <br><br>
 
 ======================
 <div><span style="color: aqua; font-size: 30px;"> CASH FLOW </span> <br>
 
 Net Income : 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= RE %> <br>
 Depreciation 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%= list[5] %> <br> 
 
 Cash flow from operating activities : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= RE + list[5] %> 	<br><br><br>
 
 Purchase less sales of Property, plant & equipment <br> 
 Cash flow in investing activities :  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <%= -1 * list[4] %> <br><br><br>
 
 
 Addition less reduction in long-term & short-term debt  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    <%= -1 * ( list[7] + list[8] + list[9] ) %> <br>
 Increase/Decrease in net cash & cash equivalents   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    <%= list[0] %> <br>
 Cash dividend payments:  ( this number is unavailable now )  <br>
 Cash flow in investing activities :  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%= list[0] -1 * ( list[7] + list[8] + list[9] ) %> <br>  <br><br><br>
 
 Plus cash flow at beginning period   ( this number is unavailable now ) <br>
 Cash flow at the end period   ( this number is unavailable now )

 
</body> 
</html>
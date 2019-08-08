<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Transactions</title>
</head>
<body>
	
	<div><span style="color: aqua; font-size: 30px;"> VIEW TRANSACTIONS </span> <br>
	<a href="http://127.0.0.1:8888/Accounting/mainAccounting.html">Main Accounting </a> <br>
	<a href="http://localhost:8080/Accounting/Transactions.jsp"> Create new transaction </a><br>		
	<br>
	
	<form method="post" action="ViewTransactionsServlet">
		<input type="submit" value="see all transactions">
	</form>
	
	<c:forEach  var = "temp" items="${results}" >
		 Transaction ID : ${ temp.id }     &nbsp;&nbsp;&nbsp;      
	<div align="center" style="position: relative; top:-20px">	${ temp.type }    &nbsp;&nbsp;&nbsp;   </div>
	<div align="right" style="position: relative; top:-40px">	 <span> ${ temp.amount }  </span>  &nbsp;&nbsp;&nbsp;   
		  <span >  ${ temp.getDebitCredit() } </span><br>  &nbsp;&nbsp;&nbsp;   </div>
	
	</c:forEach>
	
	
</body>
</html>
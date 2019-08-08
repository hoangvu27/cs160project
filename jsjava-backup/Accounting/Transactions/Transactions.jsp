<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
table, th, td {
  border: 1px solid black;
}
	th, td {
  padding: 15px;
}
</style>
</head>
<body>
	<div><span style="color: aqua; font-size: 30px;"> Create A Transaction </span> <br>
	<div style="font-family: 'Abril Fatface';font-size: 20px; color: red"> Warning: the first debit row will be removed. Also, please give integer input only </div><br>
	<button onclick="addDebitRow()" > Add debit row </button> &emsp;&emsp;&emsp;
	<button onclick="removeDebitRow()" > Remove debit row </button><br>
	
	<button onclick="addCrebitRow()" > Add credit row </button> &emsp;&emsp;&emsp;
	<button onclick="removeCrebitRow()" > Remove credit row </button> <br>
	
	<form id="myForm" method="post">
	Date :  <input type="date" name="date" > &emsp;&emsp;&emsp;
	ID : <input type="text" name="id" required> 
	<br><br>
		
<table style="width:100%" id="table">
	<col width="300">
  	<col width="210">
	<col width="200">
	
  <tr>
    <th>Transactions</th>
    <th>Debit</th> 
    <th>Credit</th>
  </tr>
  <tr>
    <td>  <textarea rows="1" cols="50" name="description"> </textarea> </td>

  </tr>
	
  <tr title="start row debit">
    <td> <select name="type">
  			<option value="1">	Cash + Cash Equivalence </option>
 			 <option value="2"> Note + Accounts Receivable </option>
  			<option value="3"> Supplies + Inventories </option>
  			<option value="4">Other current assets </option>
			<option value="5">	Property, Plant + Equipment </option>
 			 <option value="6"> Depreciation </option>
  			<option value="7"> Other assets (including intangible assets)  </option>
  			<option value="8">	Note + Loan payable  </option>
			<option value="9">	Account payable + Other accrued liabilities  </option>
 			 <option value="10"> Long-term Liabilities </option>
  			<option value="11"> Capital Stock </option>
  			<option value="12"> Revenue - Retained Earnings </option>
  			<option value="13"> Expense - Retained Earnings </option>
			</select> </td>
    <td > <input class="dr"  type="number" step="1" name="debit" required> </td>  
  </tr>
	
	 <tr title="start row credit">
    <td>  <select name="type">
  			<option value="1">	Cash & Cash equivalence </option>
 			 <option value="2"> Note & Accounts Receivable </option>
  			<option value="3"> Supplies & Inventories </option>
  			<option value="4">Other current assets </option>
			<option value="5">	Property, Plant & Equipment </option>
 			 <option value="6"> Depreciation </option>
  			<option value="7"> Other assets (including intangible assets)  </option>
  			<option value="8">	Note & Loan payable  </option>
			<option value="9">	Account payable & Other accrued liabilities  </option>
 			 <option value="10"> Long-term Liabilities </option>
  			<option value="11"> Capital Stock </option>
  			<option value="12"> Revenue - Retained Earnings </option>
  			<option value="13"> Expense - Retained Earnings </option>
			</select></td>
		 
    <td></td>
    <td > <input class="cr" type="number" step="1" name="credit" required></td>
  </tr>

</table>
		
		<br>
		 <input type="submit" value="Done">
	</form>
	<!-- <button onClick="process()"> Done </button> <br> -->
	
	<button onClick="checkBalance()"> check balance </button> <br>
	<div id="check"> </div>
	
	
	<script>
		let debitRow = 1
		let creditRow = 1

		
		function addDebitRow() {
			document.getElementById('check').innerHTML = ''
			var table = document.getElementById("table");
			var row = table.insertRow(2);
			var cell1 = row.insertCell(0);
			var cell2 = row.insertCell(1);
		
			let input = document.createElement('input')
			input.type = "number"
			input.step = "1"
			input.required = true	
			input.setAttribute('class', 'dr')
			input.name = "debit"
			cell2.appendChild(input)
			
			debitRow += 1
			
			let array = ["Cash & Cash equivalence", 
						 "Note & Accounts Receivable", 
						 "Supplies & Inventories",
						 "Other current assets",
						 
						"Property, Plant & Equipment",
						 "Depreciation",
						 "Other assets (including intangible assets)",
						 
						 "Note & Loan payable",
						 "Account payable & Other accrued liabilities ",
						 "Long-term Liabilities",
						 
						 "Capital Stock",
						"Revenue - Retained Earnings",
						"Expense - Retained Earnings",
						];
			
			let list = document.createElement("select");
			list.name = "type"
			cell1.appendChild(list)
			
			for (let i = 1; i <= array.length; i++) {
    			let option = document.createElement("option");
    			option.value = i
				option.text = array[i-1];
    			list.appendChild(option);
			}
		}
		
		function addCrebitRow() {
			document.getElementById('check').innerHTML = ''
			var table = document.getElementById("table");
			var row = table.insertRow(-1);
			var cell1 = row.insertCell(0);
			var cell2 = row.insertCell(1);
			var cell3 = row.insertCell(2);

			let input = document.createElement('input')
			input.type = "number"
			input.step = "1"
			input.required = true	
			input.setAttribute('class', 'cr')
			input.name="credit"
			cell3.appendChild(input)
			
			creditRow += 1 
			
			let array = ["Cash & Cash equivalence", 
						 "Note & Accounts Receivable", 
						 "Supplies & Inventories",
						 "Other current assets",
						 
						"Property, Plant & Equipment",
						 "Depreciation",
						 "Other assets (including intangible assets)",
						 
						 "Note & Loan payable",
						 "Account payable & Other accrued liabilities ",
						 "Long-term Liabilities",
						 
						 "Capital Stock",
						 "Revenue - Retained Earnings",
							"Expense - Retained Earnings",
						];
			
			let list = document.createElement("select");
			list.name = "type"
			cell1.appendChild(list)
			
			for (let i = 1; i <= array.length; i++) {
    			let option = document.createElement("option");
    			option.value = i
				option.text = array[i-1];
    			list.appendChild(option);
			}
		}
		
		function removeDebitRow() {
			if ( debitRow > 1) {
				document.getElementById("table").deleteRow(2); 
				debitRow -= 1 
			} else {
				document.getElementById('check').innerHTML = 'no more debit row to remove'
			}
		}
		
		function removeCrebitRow() {
			if ( creditRow > 1) {
				document.getElementById("table").deleteRow(-1);
				creditRow -= 1
			} else {
				document.getElementById('check').innerHTML = 'no more credit row to remove'
			}
		}
		
		function checkBalance() {
			let arr1 = document.getElementsByClassName('dr')
			let arr2 = document.getElementsByClassName('cr')
			let debitSum = 0
			let creditSum = 0
			for (x of arr1) {
				debitSum += parseInt(x.value)
				console.log(x)
				console.log(x.value)
			}
			for (x of arr2) {
				creditSum += parseInt(x.value)
			}
			console.log(arr1[0].value)
			console.log(debitSum)
			console.log(creditSum)
			if (debitSum === creditSum) {
				document.getElementById('check').innerHTML = 'balanced'
			} else {
				document.getElementById('check').innerHTML = 'not balanced'
			}
		}
		
		function process() {
			let ListObject = document.getElementById('type')
			
			document.getElementById('myForm').submit();
		}
		
		function format(element) {
    	element.value = parseInt(element.value).toFixed(0);
	}
	</script>
	
	<%@ page import="java.util.Date" %>
	<%@ page import="java.util.*"%> 
	<%@ page import="java.sql.*" %>
	 <%@ page import="javax.sql.*" %>
	 <%@ page import="java.text.DateFormat" %>
	 <%@ page import="java.text.SimpleDateFormat" %>
	 <%@ page import="java.text.DecimalFormat" %>
	 <%@ page import="java.text.NumberFormat" %>

	<%
		String[] types = request.getParameterValues("type");
		String[] credit = request.getParameterValues("credit");
		String[] debit = request.getParameterValues("debit");

		if ( request.getParameter("id") != null ) 
		{	
			String id = request.getParameter("id") ;  
			
			Class.forName("com.mysql.jdbc.Driver");
		 	java.sql.Connection connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
		 	
			
			String full = "";

			PreparedStatement statement;
			statement = connection.prepareStatement("SELECT * FROM BS");
			ResultSet rs =  statement.executeQuery();
			rs.next();
			

			for (int i=0 ; i < debit.length; i++) {
				int finalResult = Integer.parseInt(  debit[i] ) + rs.getInt(  types[i] );
				 full += "`" + types[i] + "`" + "="  + finalResult  + ",";
				
 			}
			 
			for (int i=0 ; i < credit.length; i++) {
				int finalResult = -1 * Integer.parseInt(  credit[i] ) + rs.getInt(   types[i + debit.length] );
				full += "`" +  types[i + debit.length ] + "`"  + "=" +  + finalResult   + ",";
			}
			
// 			this is used to update balance sheet
			full = "UPDATE BS SET " + full;
			full = full.substring(0, full.length() - 1 );
// 				System.out.println(full);
			Statement stmt = connection.createStatement();
			stmt.executeUpdate( full ); 
			
			
// 			here is to record transactions 
// 			String temp = "'" + id + "'";
// 			for (int i=0 ; i < debit.length; i++) {
// 				String querry = "INSERT INTO " +
// 						"`"	+ 	Integer.parseInt( types[i] ) + "`"  + " VALUES (" + temp + "," +  debit[i] + "," + 0 + ")";
// 		 		statement.executeUpdate(querry); 

//  			}
			
// 			for (int i=0 ; i < credit.length; i++) {
// 				String querry = "INSERT INTO " +
// 						"`"	+ 	Integer.parseInt( types[i + debit.length] ) + "`"  + " VALUES (" + temp + "," +  0 + "," + credit[i] + ")";
// 		 		statement.executeUpdate(querry); 
// 			}
			
			String temp = "'" + id + "'";
			String querry1 = "INSERT INTO transactions VALUES (" + temp + ")";
	 		statement.executeUpdate(querry1); 
	 		
			for (int i=0 ; i < debit.length; i++) {
				String querry = "INSERT INTO transactionsTable VALUES (" + temp + "," +  Integer.parseInt( types[i] ) + ","
							 + 1 + "," + Integer.parseInt( debit[i] ) + ")" ;
		 		statement.executeUpdate(querry); 
			}
			
			for (int i=0 ; i < credit.length; i++) {
				String querry = "INSERT INTO transactionsTable VALUES (" + temp + "," +  Integer.parseInt( types[i + debit.length] ) + ","
							 + 0 + "," + Integer.parseInt( debit[i] ) + ")" ;
		 		statement.executeUpdate(querry); 
			}
		}
	

	%>
	
	

</body>
</html>
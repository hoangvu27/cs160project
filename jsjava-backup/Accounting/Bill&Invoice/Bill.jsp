<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--the style is taken from w3school -->
	<style>
.tooltip {
  position: relative;

  display: inline-block;
  border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 250px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;

  /* Position the tooltip */
  position: absolute;
  z-index: 1;
}

.tooltip:hover .tooltiptext {
  visibility: visible;
}
</style>
</head>
<body>
	<div align="right"><span style="color: aqua; font-size: 30px;"> NEW BILL / INVOICE </span> <br>
 	<a href="file:///Users/Student/Dropbox/JSP%20&%20Javascript%20project/Accounting/mainAccounting.html"> Accounting Main Page</a> <br>
	<a href="http://localhost:8080/Accounting/Bill.jsp"> Create another bill/invoice </a> </div>
 
	<div class="tooltip" style="color: aqua"> tips here 
 <span class="tooltiptext">Add ID of regular customers to "bill to box". Otherwise, click "add non-regular customer" button. If No items are found, you must create the items first </span>	</div> 
	<br><br><br><br>
	<button onclick="Name()" style=>add non-regular customer </button> <br> <br>	
	
	

	<div class="tooltip" style="color: aqua"> tips here 
 <span class="tooltiptext">For the clientID, user should copy by mouse, automate feature is unavailable now</span>	</div> <br>
	<br>

	
	 <select size="5">
	<c:choose>
	<c:when test = "${sessionScope.clients.size() == 0}"> No result found </c:when>
	</c:choose>
	<c:forEach  var = "temp" items="${sessionScope.clients}" >
<%--    				<span>	Client Id : ${temp.getId() } , Name : ${temp.getName() } </span> <br> --%>
		<option value="${temp.getId() }" onclick="toHidden(this)" >Client Id : ${temp.getId() } , Name : ${temp.getName() } </option>
	</c:forEach>
	</select>
	
	<form method="post" action="ClientServlet" >
		<input type="submit" value="Show Clients">
	</form>
	<br>
	
	
	<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search Item..." style="display: block" >
	<ul id="myUL">
	<c:choose>
		<c:when test = "${rows.size() == 0}"> No result found
		</c:when>
		<c:otherwise>
			<c:forEach  var = "temp" items="${sessionScope.rows}" >
   					 <li> <a href="#" onmousedown="add(this)" > Item Id : ${temp.getId() } , Name : ${temp.getName() } </a></li>

			</c:forEach>
		</c:otherwise>
	</c:choose>
	</ul>
	<form method="post" action="BillServlet" id="form2">
		
	<input type="submit" value="Check Item" onClick="showItem()">
	</form>

	<br>
	<div class="tooltip" style="color: aqua"> tips here 
 <span class="tooltiptext">Click "add item" button first before searching the item</span>	</div> <br>
	
 
	************************************************************************
	<form id="form3" method="post" action="Servlet" >
		 
	Customer ID: <div id="displayCustomerId" > </div>
		<input type="hidden" required id="customerID" name="customerID"> <br>
		
	Invoice Number:   <input id="invoiceNumber" type="text" required name="invoiceNumber"  > <br>
	P.O / S.O Number:   <input id="orderNumber" type="text"  name="orderNumber"  > <br>
		
	Date invoice/bill created  : <input id="dayCreated"  type="date" name="dayCreated" onChange="adjustDate()"> <br>
	Payment date/due <input id="dueDate" type="date"  name="dueDate" > <br>
	
	<div id="items"> </div>
	<br><br> 	
	<input type="submit" value="Create"> 
	</form>	 
	*******************************************************************************<br>
	
	<button onclick="addItem()">Add item</button> 
	<button onclick="removeItem()" >Remove item</button> <br>
	
	Total : ${message}  ${total} <br>
	<div class="tooltip" style="color: aqua"> tips here 
 <span class="tooltiptext"> click the link below to save and print the bill/invoice</span>	</div> <br>
	<a href="http://127.0.0.1:8888/bill.csv" download>Your bill/invoice</a>
<!-- 	<a href="/Users/Student/jsjava-display/webseverchrome/bill.csv" download>Your bill/invoice</a> -->
	<script>
		
		let today = new Date().toISOString().substr(0, 10);
		document.getElementById('dayCreated').value = today
		document.getElementById('dueDate').value = today
		document.getElementById('dueDate').min = document.getElementById('dayCreated').value
		
		function adjustDate() {
			document.getElementById('dueDate').value = document.getElementById('dayCreated').value
			document.getElementById('dueDate').min =  document.getElementById('dayCreated').value 
		}
		
		function Name() {
			document.getElementById('customerID').value = "noID"
			document.getElementById('displayCustomerId').innerHTML = "noID"
		}
		
		
		var UL = document.getElementById("myUL");
		UL.style.display = "none";

		var searchBox = document.getElementById("myInput");


		searchBox.addEventListener("focus",  function(){
	
		});

		
		searchBox.addEventListener("blur", function(){
		    UL.style.display = "none";
		});


		function myFunction() {
		    var input, filter, ul, li, a, i;
		    input = document.getElementById("myInput");
		    ul = document.getElementById("myUL");
		    filter = input.value.toUpperCase();
		
		    if(filter.trim().length < 1) {
		        ul.style.display = "none";
		        return false;
		    } else {
		        ul.style.display = "block";
		    }

		    li = ul.getElementsByTagName("li");
		    for (i = 0; i < li.length; i++) {
		        a = li[i].getElementsByTagName("a")[0];

		       
		     if (a.innerHTML.toUpperCase().indexOf(filter) > -1) { 
		        li[i].style.display = "";
		     } else {
		        li[i].style.display = "none";
		    } 


		    }
//			console.log( document.getElementById('myInput').value ) 
//			console.log( document.getElementById('1').innerHTML ) 
		}
		
		function add(element) {
			document.getElementById('myInput').value = element.innerHTML
		}
		

		
	</script>
	
		<script>
			let item = 0;
			
			function showItem() {
				document.getElementById('myInput').style.display = "block"
			}
			
			function addItem() {
				item += 1
				document.getElementById("items").insertAdjacentHTML("beforeend",'<div> ID:  <input required type="text" name="itemId" required>  Quantity :  <input required type="number" name="quantity"  value="0"  step="1" > Price per item / Rate per hour :  <input required type="number" name="price"  value="0.00" onchange="format(this)" step="0.01" > Tax (%) :  <input type="number" name="tax" value="0.00" onchange="format(this)"  step="0.1"> Discount (%) :  <input type="number" name="discount" value="0.00" onchange="format(this)"  step="0.1"> <br><br> </div>');
				
			}
			
			function removeItem() {
				if (item === 0) { alert("No more item to be removed")}
				else {
					item -= 1 ;
					let list = document.getElementById("items");
					console.log(list.lastChild)
  					list.removeChild(list.lastChild);
				}
			}
			
			function format(element) {
    	element.value = parseFloat(element.value).toFixed(2);
	}
			
			function toHidden(element) {
				document.getElementById('customerID').value = element.value
				document.getElementById('displayCustomerId').innerHTML = element.value
			}
	</script>
</body>
</html>
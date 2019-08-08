<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<head>
			

 </head>
 		

<body>
	<form id="aForm">
		<input type="hidden" id="userID" name="userID" value=""/>
		<input type="hidden" id="name" name="name" value=""/>
	</form>

	

	<div ><span style="color: aqua; font-size: 30px;"> View Budget</span> <br></div>
	<a href="http://localhost:8080/loginRegister/loginLogoutjsp.jsp"> Home</a>
	<br>
	
	<%@ page import="java.sql.*" %>
	 <%@ page import="javax.sql.*" %>
	 <%
		
	 
	 int income = 0;
	 int expenses = 0;
	 int saving = 0;
	 int[] type = new int[9];
	 int[] month = new int[12];
	 
	 String querry = "";
	 try {
			Class.forName("com.mysql.jdbc.Driver");
			
	 	java.sql.Connection connection;
		connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/myDB?useLegacyDatetimeCode=false&serverTimezone=UTC" , "root", "cs160project");
		
	 	PreparedStatement statement;
		statement = connection.prepareStatement("SELECT * FROM summary");
		ResultSet rs =  statement.executeQuery();
		
		if (rs.next() == true) {
			income = rs.getInt("income");
			expenses = rs.getInt("expenses");
			saving = income - expenses;
		}
		
		for (int i=1; i<= 9; i++) {
			querry  = "SELECT SUM(amount) FROM expenses WHERE type=" + i ;
			statement = connection.prepareStatement(querry);
			ResultSet tempSet =  statement.executeQuery();
			if ( tempSet.next() == false ) {
				type[i-1] = 0;
			} 
			else {
				type[i-1] = tempSet.getInt("SUM(amount)");
			}
		}
		
		for (int i=1; i<= 12; i++) {
			String temp1 = "";
			String temp2 = "";
			if ( i < 10 ) { 
				temp1 = "0" + i;
			}
			else {  
				temp1 = Integer.toString(i);
			}
			int j = i+1;
			if ( i < 9 ) {
				temp2 = "0" + j + "-01'";
			}
			else if ( i < 12  ){  
				temp2 = Integer.toString(j) + "-01'";
			}
			else {
				temp2 = "12-31'";
			}
			
			querry  = "SELECT SUM(amount) FROM expenses WHERE date>='2019-" + temp1 + 
								"-01' AND date <='2019-" + temp2  ;
			statement = connection.prepareStatement(querry);
			ResultSet tempSet =  statement.executeQuery();
			if ( tempSet.next() == false ) {
				month[i-1] = 0;
			} 
			else {
				month[i-1] = tempSet.getInt("SUM(amount)");
			}
		}
		
	
	 	connection.close();
	 	
	 	} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
		}
	 
	 %>
	 WELCOME, <div id="welcome" > </div>
	 
Total	Income/Fund : <%= income %>  	&nbsp;&nbsp;&nbsp; Total Expenses: <%= expenses %> 	&nbsp;&nbsp;&nbsp;
 Total saving: : <%= saving %>
		
		<br><br><br>
		Total amount for each category <br><br>
		Transportation : &nbsp; <%= type[0] %>    <br> 
		Housing : &nbsp; <%= type[1] %> <br>
		Utilities : &nbsp; <%= type[2] %> <br> 
		Entertainment : &nbsp; <%= type[3] %> <br>
		Medical Expenses : &nbsp; <%= type[4] %> <br>
		Education :   &nbsp; <%= type[5] %> <br>
		Taxes :   &nbsp; <%= type[6] %> <br>
		Gifts + Contributions :   &nbsp; <%= type[7] %> <br>
		Miscellaneous :  &nbsp; <%= type[8] %> <br>


<!-- this is taken from google API  -->
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Expenses', 'Total amount since beginning'],
          ['Transportation',     <%= type[0] %>],
          ['Housing',       <%= type[1] %> ],
          ['Utilities',  <%= type[2] %>],
          ['Entertainment', <%= type[3] %>],
          ['Medical Expenses',    <%= type[4] %>],
          ['Education',     <%= type[5] %>],
          ['Taxes',       <%= type[6] %> ],
          ['Gifts + Contributions',  <%= type[7] %>],
          ['Miscellaneous', <%= type[8] %>],
        ]);

        var options = {
          title: 'Total expenses since beginning',
          is3D: true,
          slices: {  2: {offset: 0.4},
              5: {offset: 0.3},
              7: {offset: 0.4},
  
    },
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>
    
	<div id="piechart_3d" style="width: 900px; height: 500px;"></div>
	
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Month', 'Expenses'],
          ['Jan', <%= month[0] %>],
          ['Feb', <%= month[1] %>],
          ['Mar', <%= month[2] %>],
          ['April', <%= month[3] %>],
          ['May', <%= month[4] %>],
          ['Jun', <%= month[5] %>],
          ['July', <%= month[6] %>],
          ['Aug', <%= month[7] %>],
          ['Sep', <%= month[8] %>],
          ['Oct', <%= month[9] %>],
          ['Nov', <%= month[10] %>],
          ['Dec', <%= month[11] %>],
        ]);

        var options = {
          chart: {
            title: 'Company Performance',
            subtitle: 'Sales, Expenses, and Profit: 2014-2017',
          }
        };

        var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
    
    <div id="columnchart_material" style="width: 800px; height: 500px;"></div>
    
    <script>
			let x = location.search;
				x = x.substring(1, x.length)
				let arr = x.split("=")
				
				let targetIndex =  arr.indexOf('serialNumber')
				let temp = arr[targetIndex + 1]
				let anotherTemp = atob(temp).split(",")
				console.log(anotherTemp)
				let text = document.createTextNode( 'User Id: ' + anotherTemp[0] + ' , Name:  ' + anotherTemp[1])
				document.getElementById('welcome').appendChild(text)		
				
	</script> 
</body>
</html>
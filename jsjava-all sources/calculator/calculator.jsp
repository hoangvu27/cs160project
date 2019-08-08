<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
		
</head>
<body>
	
	<form name="FinanceCalculator" method="post">
		Assumption: 1 compounding per period <br>
		Period numbers : <input type="text" name="N"> <br> 
			
		I/Y ( = rate per period = annual interest / number of months): <input type="text" name="I/Y"> <br>
			
		Present value : <input type="text" name="PV"> <br>
		<!-- Growth of each annuity: % <input type="text" name="G"> <br>  -->
		
		Payment: <input type="text" name="PMT"> <br> 
		Future value: <input type="text" name="FV" id="FV" > <br> 
		
		 <input type="reset" value="Clear Input" name="clear"> 
		<input type="submit" value="Clear Result" name="action" >
		<input type="submit" value="Compute" name="submit"  onclick="why()" >  
		<select name="choose">
			<option value="FutureValue">FV</option> 
			<option value="PresentValue">PV</option>
			<option value="NumberPeriods">N</option>
			<option value="I/Y">I/Y</option>
			<!-- <option value="growth rate">G</option> -->
		</select> <br>
		
		
	</form>
		<% 
			try
			{
				double n =0; 
				double i = 0;
				double pmt = 0;
				double pv = 0;
				double fv = 0;
				boolean clearResult = false;
				
				String x = request.getParameter("action"); 
				// strange, if x is here, then x is not null
				if ( "Clear Result".equals(x) )
				{
					saveInput (0, 0, 0, 0, 0);
					clearResult = true;
				}
					
				if ( request.getParameter("N") != null && !request.getParameter("N").isEmpty() )
				{
					n = Double.parseDouble( request.getParameter("N") );
				}
				if ( request.getParameter("I/Y") != null && !request.getParameter("I/Y").isEmpty()  )
				{
					i = Double.parseDouble( request.getParameter("I/Y") );
					 // maybe should add function round here 
				}
				if (  request.getParameter("PV") != null && !request.getParameter("PV").isEmpty()  )
				{
					pv = Double.parseDouble( request.getParameter("PV") );
				}
				if ( request.getParameter("PMT") != null && !request.getParameter("PMT").isEmpty() )
				{
					pmt = Double.parseDouble( request.getParameter("PMT") );
				}
				if ( request.getParameter("FV") != null && !request.getParameter("FV").isEmpty()  )
				{
					fv = Double.parseDouble( request.getParameter("FV") );
				}
				
				
				if ( clearResult == false)
				{
					String choice = request.getParameter("choose");
					if ( choice != null && choice.equals("FutureValue") )
					{
						fv = futureValue(n,  i,  pv) + FVofSumPMT( n,  i, pmt);					
					}
					else if ( choice != null && choice.equals("PresentValue") )
					{
						double temp = futureValue(n,  i,  pv)  + FVofSumPMT( n,  i, pmt) + fv;
						pv = presentValue(n, i, temp);
					}
					else if ( choice != null && choice.equals("NumberPeriods") )
					{
						n = period( i,  pv,  pmt,  fv);
					}
					else if ( choice != null && choice.equals("I/Y") )
					{
						i = interestRate( n,  pv,  pmt,  fv) ;
					}
					saveInput(n, i, pv, pmt, fv);	
				}
			} 
			catch (Exception e)
			{
				%> 
				<script> alert("all inputs must be numbers");</script>
				<%	saveInput (0, 0, 0, 0, 0); 
			} %>
		
		<%! 
       		double futureValue(double n, double i, double pv) 
        	{ 
        		return pv * Math.pow( ( 1 + i / 100 ), n);
        	} 
 
       		double FVofSumPMT(double n, double i, double pmt) 
        	{ 
        	 	double temp = i / 100;
				 return ( pmt / temp ) * ( Math.pow( 1 + temp , n) - 1 );
        	} 
       		
       		double presentValue(double n, double i, double fv)  
       		{
       			return fv / Math.pow( ( 1 + i / 100 ), n);
       		}
       		
       		double period( double i, double pv, double pmt, double fv) 
       		{
       			double r = i / 100;
       			double temp = (fv * r + pmt ) / (pmt + pv * r);
       			return Math.log10(temp) / Math.log10(1+r);
       		}
       		
       		double interestRate( double n, double pv, double pmt, double fv) 
       		{
       			double r = 0.01;
       			while ( fv * r + pmt - Math.pow(1 + r, n) * (pmt + pv * r)   > 0 ) 
       			{
       				r += 0.01;
       			}
       			if (fv * r + pmt -  Math.pow(1 + r, n) * (pmt + pv * r) == 0)
       			{
       				return r * 100;
       			}
       			r -= 0.01;
       			
       			while ( fv * r + pmt - Math.pow(1 + r, n) * (pmt + pv * r)   > 0 ) 
       			{
       				r += 0.0001;
       			}
       			return r * 100;
       		}
       		
       		double periodPayment( double n, double pv, double i) {
       			double temp = i / 100;
       			return pv * temp * Math.pow( 1 + temp  , n) / ( Math.pow( 1 + temp , n) - 1 );
//        			here, temp is interest rate for ONE PERIOD, not 1 year
       		}
         %> 
         
         
		<%!
			double n =0; 
			double i = 0;
			double pv = 0;
			double pmt = 0;
			double fv = 0;

			
			 void saveInput (double n, double i, double pv, double pmt, double fv) {
				 this.n = n; 
				 this.i = i; 
				 this.pv = pv;
				 this.pmt = pmt; 
				 this.fv = fv;
			 }
			 
			 double getN() { return this.n; }
			 double getI() { return this.i; }
			 double getPV() { return this.pv; }
			 double getPMT() { return this.pmt; }
			 double getFV() { return this.fv; }
			 
		 %>
		
		
		Result:  <br>
		Period numbers : <%= getN() %>  <br>
		I/Y :  <%= getI() %>	<br>
		PV : <%= getPV() %>  <br>
		PMT:  <%= getPMT() %>  <br>
		FV : <%= getFV() %>  <br>

	
		
	<form>
		<h1></h1>
		Interest type : <select name="opt">
			<option value="EIR">Effective Interest Rate</option> 
			<option value="EAIR">Effective Annual Interest Rate</option>
		</select> 
		 <input type="text" name="rate" placeholder="0"> <br>
		Period numbers : <input type="text" name="N1" placeholder="0"> <br>
		
		<input type="submit" value="Compute" name="cpt1">  
	</form>
		
		<% 
			try
			{
				double n=0;
				double r = 0;
				saveResult(0, 0, 0);
				boolean submit = false;
				
				if ( request.getParameter("N1") != null && !request.getParameter("N1").isEmpty() )
				{
					n = Double.parseDouble( request.getParameter("N1") );
				}
				if ( request.getParameter("rate") != null && !request.getParameter("rate").isEmpty() )
				{
					r = Double.parseDouble( request.getParameter("rate") );
					submit = true;
				}
				double temp = r;
				temp = temp / 100;
				String opt = request.getParameter("opt");
			
				if (opt != null && "EIR".equals(opt) )
				{	
					double i = Math.pow( 1 + temp / n , n ) - 1;
					saveResult(n, r, i * 100);	
				}
				else if (opt != null &&  "EAIR".equals(opt))
				{
					double i = n * ( Math.pow( temp + 1, 1 / n) - 1 );
					saveResult(n, i * 100, r);
				}	
				
			}
			catch (Exception e)
			{
				enableError("all inputs must be numbers");
			}
		%>
		
		<%!
			double n1=0; 
			double EIR =0; 
			double EAIR = 0;
			String message = "";
			
			void saveResult(double n1, double EIR, double EAIR) {
				this.n1 =n1; 	this.EIR = EIR; 	this.EAIR = EAIR;
			}
			double getEIR() {
				return EIR;
			}
			double getN1() {
				return n1;
			}
			double getEAIR() {
				return EAIR;
			}
			void enableError(String str) {
				message = str;
			}
			String getMessage() {
				return message;
			}
		%>
		<br>
		Result: <%= getMessage() %> <br>
		Effective Interest Rate : <%= getEIR() %> <br>
		Effective Annual Interest Rate : <%= getEAIR() %> <br>
		Number of periods per year : <%= getN1() %> <br>
		
	================== <br>	<br>
		interest rate adjustment - PLAM <br>
		
	<form name="PLAM" method="post">
		Assumption: 1 compounding per period <br>
		
		Original amount : <input type="text" name="original"> <br>
		Original year : <input type="text" name="year1"> <br> 
		Loan term (default is 30 years) : <input type="text" name="term" value="30"> <br> 
		Original rate( = compounding rate per year ): <input type="text" name="I1"> <br>
		CPI increases by : <input type="text" name="I2"> <br>
		
		
		 <input type="reset" value="Clear Input" name="clear"> 
		<input type="submit" value="Compute" name="submit"   >  
	</form>
	<% 
			try
			{
				double original=0;
				double originalMonth = 0;
				double I1 = 0;
				double I2 = 0;
				double term = 0;
				double originalPayment = 0;
				double newPayment = 0;
				saveInput(0, 0, 0, 0);
				
				if ( request.getParameter("original") != null && !request.getParameter("original").isEmpty() )
				{
					original = Double.parseDouble( request.getParameter("original") );
				}
				if ( request.getParameter("year1") != null && !request.getParameter("year1").isEmpty() )
				{
					originalMonth = 12 * Double.parseDouble( request.getParameter("year1") );
				}
				if ( request.getParameter("I1") != null && !request.getParameter("I1").isEmpty() )
				{
					I1 =  Double.parseDouble( request.getParameter("I1") ) ; 
				}
				if ( request.getParameter("I2") != null && !request.getParameter("I2").isEmpty() )
				{
					I2 =  Double.parseDouble( request.getParameter("I2") ) ; 
				}
				if ( request.getParameter("term") != null && !request.getParameter("term").isEmpty() )
				{
					term = Double.parseDouble( request.getParameter("term") );
				}
				
				if ( original != 0 && originalMonth != 0 && I1 != 0 && I2 != 0 && term != 0) {
					 originalPayment = periodPayment(12 * term , original, I1 / 12 );
					
					 double targtFV = futureValue( originalMonth, I1 / 12, original) 
							 - FVofSumPMT( originalMonth,  I1 , originalPayment);
					 
					 targtFV = targtFV * ( 1 + I2 / 100);
					 newPayment = periodPayment(12 * (term-1) , targtFV, I1 / 12 );							 
					 saveOutput( originalPayment, newPayment) ;
				}
			}
			catch (Exception e)
			{
				enableError("all inputs must be numbers");
			}
		%>
	<%!
			double original =0; 
			double year1 = 0;
			double I1 = 0;
			double I2 = 0;
			
			double payment1 = 0;
			double payment2 = 0;
			
			 void saveInput (double original, double year1, double I1, double I2) {
				 this.original = original; 
				 this.year1 = year1; 
				 this.I1 = I1;
				 this.I2 = I2; 
				
			 }
			 
			 void saveOutput( double payment1, double payment2) {
				 this.payment1 = payment1;
				 this.payment2 = payment2;
			 }
			 
			 double getOriginal() { return this.original; }
			 double getYear1() { return this.year1; }
			 double getI1() { return this.I1; }
			 double getI2() { return this.I2; }

			 double getPayment1() { return this.payment1; }
			 double getPayment2() { return this.payment2; }	 
		 %>
		 
		 <br>
		Original Payment: <%= getPayment1() %> <br>
		New Payment : <%= getPayment2() %> <br>
</body>
</html>
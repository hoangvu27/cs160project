<%@page import="loginRegister.databaseInput"%>  
<!DOCTYPE html>
<jsp:useBean id="obj" class="loginRegister.User"/>  
  
<jsp:setProperty property="*" name="obj"/>  <%  
	int status=databaseInput.addUser(obj);  
	if(status>0)  
	out.print("You are successfully registered");  
  
%>  
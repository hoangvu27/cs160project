<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">


	<script src="https://apis.google.com/js/platform.js" async defer></script>
	<meta name="google-signin-client_id" content="35954428427-oe02bmdt4j8r0dop28ks2851f2a11fj7.apps.googleusercontent.com">
</head>
	
<body >
<!-- 	codes from this page is mainly taken from Google and stackoverflow  -->


<div class="g-signin2" data-onsuccess="onSignIn"></div> <br>
	<a href="#" onclick="signOut();" id="signOut">Sign out</a> <br>
	
<!-- 	<a href="" >Home</a> -->
<!-- 	onclick="" -> store sth in json ???  -->
	
<form action="http://localhost:4000/" method="GET">
    <input type="hidden" id="serialNumber" name="serialNumber" value=""/>
    <input type="submit" value="Home" id="goHome"/>
</form>
	
<script>

	
  function signOut() {
	  document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://localhost:8080/loginRegister/loginLogoutjsp.jsp";
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
      console.log('User signed out.');
    });
    sessionStorage.clear();
    alert('aha');
  }
  
  
  function onSignIn(googleUser) {
	  var profile = googleUser.getBasicProfile();	 
	  
	  var myUserEntity = {};
	  

	  let temp = profile.getId() + "," + profile.getName() + "," + profile.getEmail()
	  temp = btoa(temp)
	  temp = temp.substring(0, temp.length-1)
	  console.log(temp)
	  document.getElementById('serialNumber').value = temp 
	  console.log(atob(temp))
		sessionStorage.setItem('myUserEntity', temp)
	}
	
  
	
	
			if(sessionStorage.getItem('myUserEntity') == null){
				document.getElementById('serialNumber').value = ""
				
			} else {

				var userEntity = {};
				userEntity = sessionStorage.getItem('myUserEntity');
			}


</script>

</body>
</html>
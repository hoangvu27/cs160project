const  app = require('express')()
let http = require('http').createServer(app)
let fs = require("fs");
let obj = JSON.parse(fs.readFileSync('/Users/Student/jsjava-display/file1.json', 'utf8'));
let express = require('express');

app.use(express.static('/Users/Student/jsjava-display/fishGame2'));


app.get('/', function(req, res){
	if (obj.permitted === false) {
		res.setHeader("Content-Type", "text/html");
		res.write('<p>You need to log in first</p><br><br> <a href="http://localhost:8080/loginRegister/register.jsp" > login here</a>');
//		res.redirect('http://localhost:8080/loginRegister/register.jsp')
		res.end()
	}
   else {
	   res.sendFile('/Users/Student/jsjava-display/fishGame2/fishGame.html');
   }
});

http.listen(2000)
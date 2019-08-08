const  app = require('express')()
let http = require('http').createServer(app)
let io = require('socket.io')(http)

const Filter = require('bad-words'),
  filter = new Filter();


io.on('connection', function(socket){
  console.log('new user joined');
	socket.username = 'unnamed person'
	socket.on('changeName', (data) => {
		socket.username = data.newName
	});
	
	
	socket.on('newMessage', (data) => {
	 	console.log(socket.username)
		let temp = filter.clean(data.newMessage)
		io.emit('filter', { newMessage : temp , username : socket.username })		  
//	here, alternatively, can put socket.on('newMessag') in the <script> of index.html so that no forward and backward on & emit
//		the only problem is that the script cannot work with require. 
	});
	
	socket.on('sending', (data) => {
		io.emit('displaySending', { username : socket.username} )
	})
	
});


app.get('/', function(req, res){
  res.sendFile('/Users/Student/jsjava-display/chatApp/index.html');
});


http.listen(3000)
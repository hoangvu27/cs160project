We need to download  node.js,  and  install pm2,  express,  socket.io 

npm install pm2@latest -g
npm install socket.io
npm install express


if having a problem, try to type in terminal:    sudo chown -R $USER /usr/local 


		RUN SERVER OF NODE.JS, 
just go to specific folder and type in command: pm2 start app

for example, to run home.js, go to /Users/Student/jsjava-display/dashboard, then type
	
	pm2 start home.js




***EMAIL CLASSIFICATIONS, go to pyproject/personal_portfolio/settings.py, type in
 
EMAIL_HOST_USER = ‘your-gmail’
EMAIL_HOST_PASSWORD = ‘your-password’

Next, go to https://myaccount.google.com/lesssecureapps, enable this

note that the model is not good enough to detect any kind of spam -> should use the spam email in the dataset



		RUN WEBSERVER CHROME:

go to and add plug-in webster chrome, https://chrome.google.com/webstore/detail/web-server-for-chrome/ofhbbkphhbklhfoeikjpcbhemlocgigb?hl=en


then, launch app, -> a window appear,  change port to 8888 , close window, and then open window. Now the port is changed to http://127.0.0.1:8888. 

	choose the folder jsjava-display/webseverchrome 

‘


		RUN DJANGO  SERVER
download python 3.7.4,  cd …/pyproject
type in terminal:       source venv/bin/activate
then:			pip install Django
then:  			python manage.py runserver



	RUN  JSP SERVER
download tomcat  ->  create project folder -> put jsp in  -> run server

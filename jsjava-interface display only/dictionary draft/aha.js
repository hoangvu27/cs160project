'use strict';
/*jshint esversion: 6 */
/*jslint node: true */
var fs = require('fs');
fs.readFile('dict.txt', 'utf8', function (err, data) {
     if (err) {
		 throw err;
	 }
    console.log(data);
});
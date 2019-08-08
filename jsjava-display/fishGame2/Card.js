'use strict';
/*jshint esversion: 6 */
/*jslint node: true */
 class Card {
	constructor(index) {
		this.index = index;
		this.number = '';
		this.numberIndex = index % 13;
		if (this.numberIndex === 0 ) { this.numberIndex = 13}
		this.x = 0;
		this.y = 0;
		if ( index % 13 === 1 ) { this.number = 'A';}
		else if ( index % 13 === 11 ) { this.number = 'J';}
		else if ( index % 13 === 12 ) { this.number = 'Q';}
		else if ( index % 13 === 0 ) { this.number = 'K';}
		else {  let temp = index % 13
			this.number = temp.toString() 
		}
		
		this.type = '';
		let temp = Math.ceil(index / 13);
		if (temp === 1) { this.type = 'H';}
		else if (temp === 2) { this.type = 'D';}
		else if (temp === 3) { this.type = 'S';}
		else if (temp === 4) { this.type = 'C';}
	}
	setPosition(x, y) {
		this.x = x;
		this.y = y;
	}
		getNumber() { return this.number.toString(); }
		getType() {  return this.type; }
		getNumberIndex() { return this.numberIndex;}
		getIndex() { return this.index; }
	 
		getX() {
			return this.x;
		}
		getY() {
			return this.y;
		}
		showBack() {
			
		}
	showFace() {
		
	}
		hide() {
			
		}
	 
	 getImgName() {
		 return this.number + this.type
	 }
}











/*jshint esversion: 6 */
/*jslint node: true */
//the shuffle function is taken from stackoverflow 
function shuffle(array) {
  	var currentIndex = array.length, temporaryValue, randomIndex;

  // While there remain elements to shuffle...
  	while (0 !== currentIndex) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
    }

  		return array;
  	}

class cardDeck {
	
	constructor(shuffle) {
		this.cardDeck = [];
		for (let index = 1; index <= 52; index++) {
			let z = new Card(index);
			this.cardDeck.push(z);
		}
		let copy = this.cardDeck.slice(0)
		this.cardDeck = shuffle(copy);
	}
	
	
	
	
	getList() {
		return this.cardDeck;
	}
	
	getCard(position) {
		return this.cardDeck[position]
	}
}


